package com.parv.safetexts

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.graphics.Color
import android.graphics.PixelFormat
import android.graphics.drawable.GradientDrawable
import android.os.Build
import android.provider.Settings
import android.util.Log
import android.view.Gravity
import android.view.WindowManager
import android.widget.Button
import android.widget.LinearLayout
import android.widget.TextView
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.io.File
import java.io.FileOutputStream
import java.util.Locale

class ScamAnalyzer private constructor(private val context: Context) {
    private val database = AppDatabase.getDatabase(context)
    private val scope = CoroutineScope(Dispatchers.IO)
    private val recentlySeenMessages = java.util.concurrent.ConcurrentHashMap<Int, Long>()
    private val tfliteClassifier = TFLiteScamClassifier(context)

    init {
        createNotificationChannel()
    }

    companion object {
        @Volatile
        private var instance: ScamAnalyzer? = null

        fun getInstance(context: Context): ScamAnalyzer {
            return instance ?: synchronized(this) {
                instance ?: ScamAnalyzer(context.applicationContext).also { instance = it }
            }
        }
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = "Scam Alerts"
            val descriptionText = "Notifications for detected scam messages"
            val importance = NotificationManager.IMPORTANCE_HIGH
            val channel = NotificationChannel("SCAM_ALERTS", name, importance).apply {
                description = descriptionText
            }
            val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }

    fun analyzeMessage(message: MessageEntity, onDuplicateScam: ((MessageEntity) -> Unit)? = null, isApk: Boolean = false, isFakeCredit: Boolean = false) {
        val msgHash = (message.sender + message.content).hashCode()
        val currentTime = System.currentTimeMillis()
        val lastSeen = recentlySeenMessages[msgHash]
        
        // Debounce: If we have seen this exact message within the last 10 seconds, ignore the event.
        if (lastSeen != null && (currentTime - lastSeen) < 10000) {
            return
        }
        recentlySeenMessages[msgHash] = currentTime
        
        // Cleanup old hashes to prevent memory leaks
        if (recentlySeenMessages.size > 100) {
            recentlySeenMessages.entries.removeIf { (currentTime - it.value) > 60000 }
        }

        scope.launch {
            // De-duplication check for persistent storage
            val existingMessage = database.messageDao().getMessage(message.sender, message.content)
            if (existingMessage != null) {
                Log.d("ScamAnalyzer", "Duplicate message found:  - ")
                if (existingMessage.analysisResult == "Scam" || existingMessage.analysisResult == "Alert") {
                    withContext(Dispatchers.Main) {
                        onDuplicateScam?.invoke(existingMessage)
                    }
                }
                return@launch
            }

            if (isApk || isFakeCredit) {
                val scamMessage = message.copy(
                    analysisResult = "Alert",
                    scamProbability = 1.0f
                )
                val id = database.messageDao().insertMessage(scamMessage)
                withContext(Dispatchers.Main) {
                    showScamWarningOverlay(scamMessage.copy(id = id.toInt()), isApk = isApk, isFakeCredit = isFakeCredit)
                }
                return@launch
            }

            val id = database.messageDao().insertMessage(message)
            analyzeKeywords(message.copy(id = id.toInt()))
        }
    }

    private suspend fun analyzeKeywords(message: MessageEntity) {
        try {
            val cleanText = message.content.replace("\n", " ").replace(Regex("\\s+"), " ")
            
            // Run TFLite inference
            val (result, scamProbability) = tfliteClassifier.classify(cleanText)

            val analyzedMessage = message.copy(
                analysisResult = result,
                scamProbability = scamProbability
            )
            database.messageDao().updateMessage(analyzedMessage)
            
            if (result == "Alert" || result == "Scam") {
                withContext(Dispatchers.Main) {
                    showScamWarningOverlay(analyzedMessage)
                }
            }
            
            Log.d("ScamAnalyzer", "TFLite Result for '': $result ($scamProbability)")
        } catch (e: Throwable) {
            Log.e("ScamAnalyzer", "TFLite Inference failed: ")
            val errorMsg = e.message?.take(30) ?: e.javaClass.simpleName
            database.messageDao().updateMessage(message.copy(analysisResult = "Failed: $errorMsg"))
        }
    }

    fun showScamWarningOverlay(message: MessageEntity, isApk: Boolean = false, isFakeCredit: Boolean = false, isBrowserSpam: Boolean = false) {
        if (!Settings.canDrawOverlays(context)) {
            Log.w("ScamAnalyzer", "Overlay permission not granted. Showing fallback notification.")
            showScamWarningNotification(message)
            return
        }

        if (OverlayUtils.isOverlayShowing) {
            Log.d("ScamAnalyzer", "Overlay is already showing. Skipping scam warning.")
            return
        }
        OverlayUtils.isOverlayShowing = true

        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val layoutParams = WindowManager.LayoutParams(
            WindowManager.LayoutParams.MATCH_PARENT,
            WindowManager.LayoutParams.MATCH_PARENT,
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
            } else {
                @Suppress("DEPRECATION")
                WindowManager.LayoutParams.TYPE_PHONE
            },
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
            WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN or
            WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
            WindowManager.LayoutParams.FLAG_DIM_BEHIND,
            PixelFormat.TRANSLUCENT
        ).apply {
            dimAmount = 0.65f
            windowAnimations = android.R.style.Animation_Dialog
        }

        val outerContainer = android.widget.FrameLayout(context).apply {
            setPadding(48, 48, 48, 48)
        }

        val overlayView = LinearLayout(context).apply {
            orientation = LinearLayout.VERTICAL
            val bgDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#FFF0F0")) 
                cornerRadius = 48f
                setStroke(4, Color.parseColor("#FF5252")) 
            }
            background = bgDrawable
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                elevation = 32f
            }
            setPadding(64, 64, 64, 64)
            val params = android.widget.FrameLayout.LayoutParams(
                android.widget.FrameLayout.LayoutParams.MATCH_PARENT,
                android.widget.FrameLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                gravity = Gravity.CENTER
            }
            this.layoutParams = params
        }

        val titleView = TextView(context).apply {
            text = if (isBrowserSpam) "⚠️ PHISHING ALERT" else "⚠️ SCAM ALERT"
            textSize = 24f
            setTextColor(Color.parseColor("#D32F2F")) 
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 16)
        }

        val senderView = TextView(context).apply {
            if (isBrowserSpam) {
                text = "You got a phishing notification from ${message.sender}, do not click on that notification."
                textSize = 16f
            } else {
                text = "From: ${message.sender} (${message.appName})"
                textSize = 18f
            }
            setTextColor(Color.parseColor("#212121"))
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 32)
        }

        val dismissButton = Button(context).apply {
            text = "DISMISS"
            setTextColor(Color.WHITE)
            setTypeface(null, android.graphics.Typeface.BOLD)
            val btnDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#FF5252"))
                cornerRadius = 24f
            }
            background = btnDrawable
            setPadding(32, 24, 32, 24)
            setOnClickListener {
                try {
                    windowManager.removeView(outerContainer)
                } catch (e: Exception) {
                    Log.e("ScamAnalyzer", "Error removing overlay", e)
                } finally {
                    OverlayUtils.isOverlayShowing = false
                }
            }
        }

        val notScamButton = Button(context).apply {
            text = "NOT A SCAM"
            setTextColor(Color.WHITE)
            setTypeface(null, android.graphics.Typeface.BOLD)
            val btnDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#4CAF50"))
                cornerRadius = 24f
            }
            background = btnDrawable
            setPadding(32, 24, 32, 24)
            setOnClickListener {
                try {
                    windowManager.removeView(outerContainer)
                } catch (e: Exception) {
                    Log.e("ScamAnalyzer", "Error removing overlay", e)
                } finally {
                    OverlayUtils.isOverlayShowing = false
                }
                
                // Mark as FALSE_POSITIVE in database
                CoroutineScope(Dispatchers.IO).launch {
                    try {
                        val db = AppDatabase.getDatabase(context)
                        val msg = db.messageDao().getMessage(message.sender, message.content)
                        if (msg != null) {
                            msg.analysisResult = "FALSE_POSITIVE"
                            db.messageDao().updateMessage(msg)
                        }
                    } catch (e: Exception) {
                        Log.e("ScamAnalyzer", "Failed to update false positive in DB", e)
                    }
                }
            }
        }

        val btnLayout = LinearLayout(context).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = Gravity.CENTER
            addView(dismissButton)
            val space = android.view.View(context).apply {
                layoutParams = LinearLayout.LayoutParams(32, 1)
            }
            addView(space)
            addView(notScamButton)
        }

        overlayView.addView(titleView)
        overlayView.addView(senderView)
        
        if (isApk) {
            val apkWarningView = TextView(context).apply {
                text = "⚠️ DO NOT download & open this file! It might hack your phone & bank account."
                textSize = 18f
                setTextColor(Color.parseColor("#D32F2F"))
                setTypeface(null, android.graphics.Typeface.BOLD)
                gravity = Gravity.CENTER
                setPadding(0, 0, 0, 32)
            }
            overlayView.addView(apkWarningView)
        }
        
        if (isFakeCredit) {
            val fakeCreditWarningView = TextView(context).apply {
                text = "⚠️ You got a fake message , AMOUNT HAS NOT BEEN CREDITED TO YOUR ACCOUNT!"
                textSize = 18f
                setTextColor(Color.parseColor("#D32F2F"))
                setTypeface(null, android.graphics.Typeface.BOLD)
                gravity = Gravity.CENTER
                setPadding(0, 0, 0, 32)
            }
            overlayView.addView(fakeCreditWarningView)
        }
        
        overlayView.addView(btnLayout)
        outerContainer.addView(overlayView)

        try {
            windowManager.addView(outerContainer, layoutParams)
        } catch (e: Exception) {
            Log.e("ScamAnalyzer", "Failed to add overlay view: ${e.message}")
        }
    }

    private fun showScamWarningNotification(message: MessageEntity) {
        val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        
        val snippet = if (message.content.length > 50) {
            message.content.substring(0, 50) + "..."
        } else {
            message.content
        }

        val notification = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Notification.Builder(context, "SCAM_ALERTS")
        } else {
            @Suppress("DEPRECATION")
            Notification.Builder(context)
        }
            .setSmallIcon(android.R.drawable.ic_dialog_alert)
            .setContentTitle("⚠️ SCAM WARNING: ${message.sender}")
            .setContentText("\"$snippet\"")
            .setStyle(Notification.BigTextStyle().bigText("From: ${message.sender} (${message.appName})\n\n${message.content}"))
            .setPriority(Notification.PRIORITY_HIGH)
            .setDefaults(Notification.DEFAULT_ALL)
            .setAutoCancel(true)
            .build()

        notificationManager.notify(message.id, notification)
    }
}
