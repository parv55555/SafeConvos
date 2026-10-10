// programmed by parv
package com.parv.safetexts

import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.graphics.PixelFormat
import android.graphics.drawable.GradientDrawable
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import android.util.Log
import android.view.Gravity
import android.view.WindowManager
import android.widget.Button
import android.widget.FrameLayout
import android.widget.LinearLayout
import android.widget.TextView

object OverlayUtils {


    @Volatile
    var isOverlayShowing = false

    private fun createBaseLayoutParams(): WindowManager.LayoutParams {
        return WindowManager.LayoutParams(
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
    }

    fun showOtpWarningOverlay(context: Context) {
        if (!Settings.canDrawOverlays(context) || isOverlayShowing) {
            Log.w("OtpSecurity", "Overlay permission not granted or overlay already showing.")
            return
        }
        isOverlayShowing = true

        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val layoutParams = createBaseLayoutParams()

        val outerContainer = FrameLayout(context).apply {
            // Background is now handled smoothly by FLAG_DIM_BEHIND
            setPadding(48, 48, 48, 48)
        }

        val overlayView = LinearLayout(context).apply {
            isClickable = true
            orientation = LinearLayout.VERTICAL
            val bgDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#FFF8E1")) // Light yellow/orange background
                cornerRadius = 48f
                setStroke(4, Color.parseColor("#FF8F00")) // Orange border
            }
            background = bgDrawable
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                elevation = 32f
            }
            setPadding(64, 64, 64, 64)
            val params = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                gravity = Gravity.CENTER
            }
            this.layoutParams = params
        }

        val titleView = TextView(context).apply {
            text = "⚠️ OTP SECURITY ALERT"
            textSize = 22f
            setTextColor(Color.parseColor("#E65100")) // Dark orange text
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 24)
        }

        val messageView = TextView(context).apply {
            text = "You recently received an OTP.\n\nDo NOT share it with anyone on this call or message. Bank officials will NEVER ask for your OTP."
            textSize = 18f
            setTextColor(Color.parseColor("#212121"))
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 48)
        }

        val dismissButton = Button(context).apply {
            text = "I UNDERSTAND"
            setTextColor(Color.WHITE)
            setTypeface(null, android.graphics.Typeface.BOLD)
            val btnDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#FF8F00"))
                cornerRadius = 24f
            }
            background = btnDrawable
            setPadding(32, 24, 32, 24)
            setOnClickListener {
                try {
                    windowManager.removeView(outerContainer)
                } catch (e: Exception) {
                    Log.e("OtpSecurity", "Error removing overlay", e)
                } finally {
                    isOverlayShowing = false
                }
            }
        }

        overlayView.addView(titleView)
        overlayView.addView(messageView)
        overlayView.addView(dismissButton)
        outerContainer.addView(overlayView)

        try {
            windowManager.addView(outerContainer, layoutParams)
        } catch (e: Exception) {
            Log.e("OtpSecurity", "Failed to add overlay view: ${e.message}")
            isOverlayShowing = false
        }
    }

    fun showRatWarningOverlay(context: Context, isSevere: Boolean) {
        if (!Settings.canDrawOverlays(context) || isOverlayShowing) {
            Log.w("RatWatchdog", "Overlay permission not granted for RAT warning or overlay already showing.")
            return
        }
        isOverlayShowing = true

        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val layoutParams = createBaseLayoutParams()

        val outerContainer = FrameLayout(context).apply {
            // Background is now handled smoothly by FLAG_DIM_BEHIND
            setPadding(48, 48, 48, 48)
        }

        val overlayView = LinearLayout(context).apply {
            isClickable = true
            orientation = LinearLayout.VERTICAL
            val bgDrawable = GradientDrawable().apply {
                setColor(if (isSevere) Color.parseColor("#FFEBEE") else Color.parseColor("#FFF3E0")) 
                cornerRadius = 48f
                setStroke(6, if (isSevere) Color.parseColor("#D50000") else Color.parseColor("#E65100")) 
            }
            background = bgDrawable
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                elevation = 40f
            }
            setPadding(64, 64, 64, 64)
            val params = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                gravity = Gravity.CENTER
            }
            this.layoutParams = params
        }

        val titleView = TextView(context).apply {
            text = if (isSevere) "🚨 SECURITY ALERT 🚨" else "⚠️ REMOTE ACCESS WARNING"
            textSize = 24f
            setTextColor(if (isSevere) Color.parseColor("#B71C1C") else Color.parseColor("#E65100"))
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 32)
        }

        val messageView = TextView(context).apply {
            val msgText = if (isSevere) 
                "If the caller has asked you to download this app, it is better not to install it as it might hack your device & bank account.\n\nEven if you are on a call with someone claiming to be a government officer, a bank person, or a loan giver, DO NOT install this app! If they ask you to install it, they are just scammers."
            else 
                "You just installed a screen-sharing app.\n\nBEWARE: If someone claiming to be a customer service/care agent, a government officer, or a banking/loan person asks you to download this over a call or video call, they might hack your phone & bank account. If they ask you to install it, they are just scammers."
            text = msgText
            textSize = 18f
            setTextColor(Color.parseColor("#212121"))
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 48)
        }

        val dismissButton = Button(context).apply {
            text = if (isSevere) "I UNDERSTAND THE RISK" else "GOT IT"
            setTextColor(Color.WHITE)
            setTypeface(null, android.graphics.Typeface.BOLD)
            val btnDrawable = GradientDrawable().apply {
                setColor(if (isSevere) Color.parseColor("#D50000") else Color.parseColor("#E65100"))
                cornerRadius = 24f
            }
            background = btnDrawable
            setPadding(32, 24, 32, 24)
            setOnClickListener {
                try {
                    windowManager.removeView(outerContainer)
                } catch (e: Exception) {
                    Log.e("RatWatchdog", "Error removing overlay", e)
                } finally {
                    isOverlayShowing = false
                }
            }
        }

        overlayView.addView(titleView)
        overlayView.addView(messageView)
        overlayView.addView(dismissButton)
        outerContainer.addView(overlayView)

        try {
            windowManager.addView(outerContainer, layoutParams)
        } catch (e: Exception) {
            Log.e("RatWatchdog", "Failed to add overlay view: ${e.message}")
            isOverlayShowing = false
        }
    }
    
    fun showDigitalArrestWarningOverlay(context: Context) {
        if (!Settings.canDrawOverlays(context) || isOverlayShowing) {
            Log.w("DigitalArrest", "Overlay permission not granted for Digital Arrest warning or overlay already showing.")
            return
        }
        isOverlayShowing = true

        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val layoutParams = createBaseLayoutParams()

        val outerContainer = FrameLayout(context).apply {
            // Background is now handled smoothly by FLAG_DIM_BEHIND
            setPadding(48, 48, 48, 48)
        }

        val overlayView = LinearLayout(context).apply {
            isClickable = true
            orientation = LinearLayout.VERTICAL
            val bgDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#FFEBEE"))
                cornerRadius = 48f
                setStroke(8, Color.parseColor("#D50000"))
            }
            background = bgDrawable
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                elevation = 48f
            }
            setPadding(64, 80, 64, 80)
            val params = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                gravity = Gravity.CENTER
            }
            this.layoutParams = params
        }

        val titleView = TextView(context).apply {
            text = "🚨 DIGITAL ARREST\nSCAM WARNING 🚨"
            textSize = 26f
            setTextColor(Color.parseColor("#B71C1C"))
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 40)
        }

        val messageView = TextView(context).apply {
            text = "You are on a long video call following an unknown call, and just opened a banking app.\n\nPolice/CBI will NEVER arrest you over a video call. This is a scam.\n\nDO NOT TRANSFER MONEY."
            textSize = 20f
            setTextColor(Color.parseColor("#212121"))
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 48)
        }

        val dismissButton = Button(context).apply {
            text = "I UNDERSTAND"
            setTextColor(Color.WHITE)
            setTypeface(null, android.graphics.Typeface.BOLD)
            val btnDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#D50000"))
                cornerRadius = 24f
            }
            background = btnDrawable
            setPadding(32, 32, 32, 32)
            setOnClickListener {
                try {
                    windowManager.removeView(outerContainer)
                } catch (e: Exception) {
                    Log.e("DigitalArrest", "Error removing overlay", e)
                } finally {
                    isOverlayShowing = false
                }
            }
        }

        overlayView.addView(titleView)
        overlayView.addView(messageView)
        overlayView.addView(dismissButton)
        outerContainer.addView(overlayView)

        try {
            windowManager.addView(outerContainer, layoutParams)
        } catch (e: Exception) {
            Log.e("DigitalArrest", "Failed to add overlay view: ${e.message}")
            isOverlayShowing = false
        }
    }

    fun showSextortionWarningOverlay(context: Context) {
        if (!Settings.canDrawOverlays(context) || isOverlayShowing) {
            Log.w("Sextortion", "Overlay permission not granted for Sextortion warning or overlay already showing.")
            return
        }
        isOverlayShowing = true

        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val layoutParams = createBaseLayoutParams()

        val outerContainer = FrameLayout(context).apply {
            // Background is now handled smoothly by FLAG_DIM_BEHIND
            setPadding(48, 48, 48, 48)
        }

        val overlayView = LinearLayout(context).apply {
            isClickable = true
            orientation = LinearLayout.VERTICAL
            val bgDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#FFEBEE")) // Light pink/red inside
                cornerRadius = 48f
                setStroke(6, Color.parseColor("#D50000")) // Dark red border
            }
            background = bgDrawable
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                elevation = 40f
            }
            setPadding(64, 80, 64, 80)
            val params = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                gravity = Gravity.CENTER
            }
            this.layoutParams = params
        }

        val titleView = TextView(context).apply {
            text = "⚠️ VIDEO CALL ALERT"
            textSize = 24f
            setTextColor(Color.parseColor("#B71C1C"))
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 24)
        }

        val messageView = TextView(context).apply {
            text = "Scammers use video calls to record your face for blackmail and extortion.\n\nIf you see a naked girl or a police officer on call, IMMEDIATELY cut the call & don't pay anything.\n\nDO NOT SHOW YOUR FACE."
            textSize = 18f
            setTextColor(Color.parseColor("#212121")) // Dark text for readability
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 48)
        }

        val dismissButton = Button(context).apply {
            text = "DISMISS & HANG UP"
            setTextColor(Color.WHITE)
            setTypeface(null, android.graphics.Typeface.BOLD)
            val btnDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#D50000"))
                cornerRadius = 24f
            }
            background = btnDrawable
            setPadding(32, 32, 32, 32)
            setOnClickListener {
                try {
                    windowManager.removeView(outerContainer)
                } catch (e: Exception) {
                    Log.e("Sextortion", "Error removing overlay", e)
                } finally {
                    isOverlayShowing = false
                }
            }
        }

        overlayView.addView(titleView)
        overlayView.addView(messageView)
        overlayView.addView(dismissButton)
        outerContainer.addView(overlayView)

        try {
            windowManager.addView(outerContainer, layoutParams)
        } catch (e: Exception) {
            Log.e("Sextortion", "Failed to add overlay view: ${e.message}")
            isOverlayShowing = false
        }
    }
    fun showPreInstallWarningOverlay(context: Context, isSevere: Boolean) {
        if (!Settings.canDrawOverlays(context) || isOverlayShowing) return
        isOverlayShowing = true

        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val layoutParams = createBaseLayoutParams()

        val outerContainer = FrameLayout(context).apply {
            // Background is now handled smoothly by FLAG_DIM_BEHIND
            setPadding(48, 48, 48, 48)
        }

        val overlayView = LinearLayout(context).apply {
            isClickable = true
            orientation = LinearLayout.VERTICAL
            background = GradientDrawable().apply {
                setColor(if (isSevere) Color.parseColor("#FFEBEE") else Color.parseColor("#FFF3E0"))
                cornerRadius = 48f
                setStroke(6, if (isSevere) Color.parseColor("#D50000") else Color.parseColor("#E65100"))
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) elevation = 40f
            setPadding(64, 64, 64, 64)
            this.layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.WRAP_CONTENT
            ).apply { gravity = Gravity.CENTER }
        }

        val titleView = TextView(context).apply {
            text = if (isSevere) "🚨 SECURITY ALERT 🚨" else "⚠️ UNVERIFIED APP WARNING"
            textSize = 24f
            setTextColor(if (isSevere) Color.parseColor("#B71C1C") else Color.parseColor("#E65100"))
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 32)
        }

        val messageView = TextView(context).apply {
            text = if (isSevere) 
                "If the caller has asked you to download this app, it is better not to install it as it might hack your device & bank account.\n\nEven if you are on a call with someone claiming to be a government officer, a bank person, or a loan giver, DO NOT install this app! If they ask you to install it, they are just scammers."
            else
                "You are trying to install an unverified app.\n\nBEWARE: If someone claiming to be a customer service/care agent, a government officer, or a banking/loan person asks you to download this over a call or video call, they might hack your phone & bank account. If they ask you to install it, they are just scammers."
            textSize = 18f
            setTextColor(Color.parseColor("#212121"))
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 48)
        }

        val buttonContainer = LinearLayout(context).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = Gravity.CENTER
            setPadding(0, 16, 0, 0)
        }

        val dismissButton = Button(context).apply {
            text = "CANCEL INSTALL"
            setTextColor(Color.WHITE)
            setTypeface(null, android.graphics.Typeface.BOLD)
            background = GradientDrawable().apply {
                setColor(if (isSevere) Color.parseColor("#D50000") else Color.parseColor("#E65100"))
                cornerRadius = 24f
            }
            setPadding(32, 24, 32, 24)
            val btnParams = LinearLayout.LayoutParams(
                0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f
            )
            btnParams.marginEnd = 16
            this.layoutParams = btnParams
            setOnClickListener { 
                try { windowManager.removeView(outerContainer) } catch (e: Exception) {} finally { isOverlayShowing = false }
            }
        }

        val bypassButton = Button(context).apply {
            text = "INSTALL ANYWAY"
            setTextColor(if (isSevere) Color.parseColor("#D50000") else Color.parseColor("#E65100"))
            setTypeface(null, android.graphics.Typeface.BOLD)
            background = GradientDrawable().apply {
                setColor(Color.TRANSPARENT)
                setStroke(4, if (isSevere) Color.parseColor("#D50000") else Color.parseColor("#E65100"))
                cornerRadius = 24f
            }
            setPadding(32, 24, 32, 24)
            val btnParams = LinearLayout.LayoutParams(
                0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f
            )
            this.layoutParams = btnParams
            setOnClickListener { 
                MessageReaderAccessibilityService.allowNextInstallUntilTime = System.currentTimeMillis() + 60_000L
                try { windowManager.removeView(outerContainer) } catch (e: Exception) {} finally { isOverlayShowing = false }
            }
        }

        buttonContainer.addView(dismissButton)
        buttonContainer.addView(bypassButton)

        overlayView.addView(titleView)
        overlayView.addView(messageView)
        overlayView.addView(buttonContainer)
        outerContainer.addView(overlayView)

        try {
            windowManager.addView(outerContainer, layoutParams)
        } catch (e: Exception) {
            Log.e("OverlayUtils", "Failed to add Pre-Install overlay: ${e.message}")
            isOverlayShowing = false
        }
    }

    fun showPostInstallWarningOverlay(context: Context, maliciousPackageName: String) {
        if (!Settings.canDrawOverlays(context) || isOverlayShowing) return
        isOverlayShowing = true

        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val layoutParams = createBaseLayoutParams()

        val outerContainer = FrameLayout(context).apply {
            // Background is now handled smoothly by FLAG_DIM_BEHIND
            setPadding(48, 48, 48, 48)
        }

        val overlayView = LinearLayout(context).apply {
            isClickable = true
            orientation = LinearLayout.VERTICAL
            background = GradientDrawable().apply {
                setColor(Color.parseColor("#FFF0F0"))
                cornerRadius = 48f
                setStroke(8, Color.parseColor("#B71C1C")) // Darker red
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) elevation = 32f
            setPadding(64, 64, 64, 64)
            this.layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.WRAP_CONTENT
            ).apply { gravity = Gravity.CENTER }
        }

        val titleView = TextView(context).apply {
            text = "🚨 CRITICAL THREAT INSTALLED"
            textSize = 24f
            setTextColor(Color.parseColor("#B71C1C"))
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 16)
        }

        val messageView = TextView(context).apply {
            text = "A highly dangerous app was just installed on your phone from an untrusted source ($maliciousPackageName).\n\nThis app could be secretly reading your SMS and stealing money from your bank accounts. UNINSTALL IT IMMEDIATELY!"
            textSize = 18f
            setTextColor(Color.parseColor("#424242"))
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 32)
        }

        val dismissButton = Button(context).apply {
            text = "I WILL UNINSTALL IT NOW"
            setTextColor(Color.WHITE)
            setTypeface(null, android.graphics.Typeface.BOLD)
            background = GradientDrawable().apply {
                setColor(Color.parseColor("#B71C1C"))
                cornerRadius = 24f
            }
            setPadding(32, 24, 32, 24)
            setOnClickListener { 
                try { windowManager.removeView(outerContainer) } catch (e: Exception) {} finally { isOverlayShowing = false }
            }
        }

        overlayView.addView(titleView)
        overlayView.addView(messageView)
        overlayView.addView(dismissButton)
        outerContainer.addView(overlayView)

        try {
            windowManager.addView(outerContainer, layoutParams)
        } catch (e: Exception) {
            Log.e("OverlayUtils", "Failed to add Post-Install overlay: ${e.message}")
            isOverlayShowing = false
        }
    }

    fun showScamFunnelWarningOverlay(context: Context, isDM: Boolean = false) {
        if (isOverlayShowing) return
        isOverlayShowing = true
        
        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val layoutParams = createBaseLayoutParams()

        val outerContainer = FrameLayout(context).apply {
            // Background is now handled smoothly by FLAG_DIM_BEHIND
        }

        val overlayView = LinearLayout(context).apply {
            isClickable = true
            orientation = LinearLayout.VERTICAL
            setBackgroundColor(Color.parseColor("#FFF0F0"))
            background = GradientDrawable().apply {
                setColor(Color.parseColor("#FFF0F0"))
                cornerRadius = 48f
                setStroke(8, Color.parseColor("#D32F2F"))
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) elevation = 32f
            setPadding(64, 64, 64, 64)
            this.layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.WRAP_CONTENT
            ).apply { gravity = Gravity.CENTER }
        }

        val titleView = TextView(context).apply {
            text = "⚠️ SCAM FUNNEL DETECTED"
            textSize = 22f
            setTextColor(Color.parseColor("#D32F2F"))
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 16)
        }

        val messageView = TextView(context).apply {
            text = if (isDM) {
                "Do not interact with this person for trading, forex, money tasks, or betting. It is possibly a scammer designed to steal your funds."
            } else {
                "Do not join groups for trading, forex , money tasks, betting. It is possibly a scam group designed to steal your funds."
            }
            textSize = 16f
            setTextColor(Color.parseColor("#424242"))
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 32)
        }

        val dismissButton = Button(context).apply {
            text = "I UNDERSTAND"
            setTextColor(Color.WHITE)
            setTypeface(null, android.graphics.Typeface.BOLD)
            background = GradientDrawable().apply {
                setColor(Color.parseColor("#D32F2F"))
                cornerRadius = 24f
            }
            setPadding(32, 24, 32, 24)
            setOnClickListener {
                try { windowManager.removeView(outerContainer) } catch (e: Exception) {} finally { isOverlayShowing = false }
            }
        }

        overlayView.addView(titleView)
        overlayView.addView(messageView)
        overlayView.addView(dismissButton)
        outerContainer.addView(overlayView)

        try {
            windowManager.addView(outerContainer, layoutParams)
        } catch (e: Exception) {
            Log.e("OverlayUtils", "Failed to add Scam Funnel overlay: ${e.message}")
            isOverlayShowing = false
        }
    }

    fun showPreEmptiveBookingAlert(context: Context) {
        if (!Settings.canDrawOverlays(context) || isOverlayShowing) {
            return
        }
        isOverlayShowing = true

        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val layoutParams = createBaseLayoutParams()

        val outerContainer = FrameLayout(context).apply {
            setPadding(48, 48, 48, 48)
            setOnClickListener {
                try {
                    windowManager.removeView(this)
                } catch (e: Exception) {
                } finally {
                    isOverlayShowing = false
                }
            }
        }

        val overlayView = LinearLayout(context).apply {
            isClickable = true
            orientation = LinearLayout.VERTICAL
            val bgDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#E3F2FD")) // Light Blue background
                cornerRadius = 48f
                setStroke(4, Color.parseColor("#1976D2")) // Blue border
            }
            background = bgDrawable
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                elevation = 32f
            }
            setPadding(64, 64, 64, 64)
            val params = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                gravity = Gravity.CENTER
            }
            this.layoutParams = params
        }

        val titleView = TextView(context).apply {
            text = "✈️ TRAVEL SAFETY ALERT"
            textSize = 22f
            setTextColor(Color.parseColor("#1565C0")) // Dark Blue
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 24)
        }

        val messageView = TextView(context).apply {
            text = "You are searching for travel bookings (hotels, flights, dhams, buses).\n\nNever pay travel agents or booking services an advance over WhatsApp using QR codes or UPI.\n\nDo bookings only from official & genuine websites.\n\nScammers create fake listings to steal your money."
            textSize = 18f
            setTextColor(Color.parseColor("#212121"))
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 48)
        }

        val dismissButton = Button(context).apply {
            text = "I UNDERSTAND"
            setTextColor(Color.WHITE)
            setTypeface(null, android.graphics.Typeface.BOLD)
            val btnDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#1976D2"))
                cornerRadius = 24f
            }
            background = btnDrawable
            setPadding(32, 24, 32, 24)
            setOnClickListener {
                try {
                    windowManager.removeView(outerContainer)
                } catch (e: Exception) {
                    Log.e("OverlayUtils", "Error removing overlay", e)
                } finally {
                    isOverlayShowing = false
                }
            }
        }

        overlayView.addView(titleView)
        overlayView.addView(messageView)
        overlayView.addView(dismissButton)
        outerContainer.addView(overlayView)

        try {
            windowManager.addView(outerContainer, layoutParams)
        } catch (e: Exception) {
            Log.e("OverlayUtils", "Failed to add PreEmptive Booking overlay: ${e.message}")
            isOverlayShowing = false
        }
    }

    fun showPreEmptiveHelplineAlert(context: Context) {
        if (!Settings.canDrawOverlays(context) || isOverlayShowing) {
            return
        }
        isOverlayShowing = true

        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val layoutParams = createBaseLayoutParams()

        val outerContainer = FrameLayout(context).apply {
            setPadding(48, 48, 48, 48)
            setOnClickListener {
                try {
                    windowManager.removeView(this)
                } catch (e: Exception) {
                } finally {
                    isOverlayShowing = false
                }
            }
        }

        val overlayView = LinearLayout(context).apply {
            isClickable = true
            orientation = LinearLayout.VERTICAL
            val bgDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#FFF3E0")) // Light Orange background
                cornerRadius = 48f
                setStroke(4, Color.parseColor("#F57C00")) // Orange border
            }
            background = bgDrawable
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                elevation = 32f
            }
            setPadding(64, 64, 64, 64)
            val params = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                gravity = Gravity.CENTER
            }
            this.layoutParams = params
        }

        val titleView = TextView(context).apply {
            text = "📞 CUSTOMER CARE ALERT"
            textSize = 22f
            setTextColor(Color.parseColor("#E65100")) // Dark Orange
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 24)
        }

        val messageView = TextView(context).apply {
            text = "You are searching for customer care or helplines.\n\nBe very careful of numbers found on Google search results or 3rd party websites.\n\nScammers post fake customer care numbers online to steal your money by asking you to download screen sharing apps or share OTPs.\n\nOnly use contact details found inside the official app."
            textSize = 18f
            setTextColor(Color.parseColor("#212121"))
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 48)
        }

        val dismissButton = Button(context).apply {
            text = "I UNDERSTAND"
            setTextColor(Color.WHITE)
            setTypeface(null, android.graphics.Typeface.BOLD)
            val btnDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#F57C00"))
                cornerRadius = 24f
            }
            background = btnDrawable
            setPadding(32, 24, 32, 24)
            setOnClickListener {
                try {
                    windowManager.removeView(outerContainer)
                } catch (e: Exception) {
                    Log.e("OverlayUtils", "Error removing overlay", e)
                } finally {
                    isOverlayShowing = false
                }
            }
        }

        overlayView.addView(titleView)
        overlayView.addView(messageView)
        overlayView.addView(dismissButton)
        outerContainer.addView(overlayView)

        try {
            windowManager.addView(outerContainer, layoutParams)
        } catch (e: Exception) {
            Log.e("OverlayUtils", "Failed to add PreEmptive Helpline overlay: ${e.message}")
            isOverlayShowing = false
        }
    }


    fun showPreEmptiveLoanAlert(context: Context) {
        if (!Settings.canDrawOverlays(context) || isOverlayShowing) {
            return
        }
        isOverlayShowing = true

        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val layoutParams = createBaseLayoutParams()

        val outerContainer = FrameLayout(context).apply {
            setPadding(48, 48, 48, 48)
            setOnClickListener {
                try {
                    windowManager.removeView(this)
                } catch (e: Exception) {
                } finally {
                    isOverlayShowing = false
                }
            }
        }

        val overlayView = LinearLayout(context).apply {
            isClickable = true
            orientation = LinearLayout.VERTICAL
            val bgDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#FFF3E0")) // Light Orange background
                cornerRadius = 48f
                setStroke(4, Color.parseColor("#F57C00")) // Orange border
            }
            background = bgDrawable
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                elevation = 32f
            }
            setPadding(64, 64, 64, 64)
            val params = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                gravity = Gravity.CENTER
            }
            this.layoutParams = params
        }

        val titleView = TextView(context).apply {
            text = "💰 LOAN SAFETY ALERT"
            textSize = 22f
            setTextColor(Color.parseColor("#E65100")) // Dark Orange
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 24)
        }

        val messageView = TextView(context).apply {
            text = "You are searching for loans online.\n\n⚠️ NEVER download unauthorized loan apps sent via WhatsApp or SMS.\n\n⚠️ NEVER pay an 'advance fee', 'processing fee', or 'GST' to get a loan approved.\n\nScammers use these tricks to steal money and hijack your phone contacts."
            textSize = 18f
            setTextColor(Color.parseColor("#212121"))
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 48)
        }

        val dismissButton = Button(context).apply {
            text = "I UNDERSTAND"
            setTextColor(Color.WHITE)
            setTypeface(null, android.graphics.Typeface.BOLD)
            val btnDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#F57C00"))
                cornerRadius = 24f
            }
            background = btnDrawable
            setPadding(32, 24, 32, 24)
            setOnClickListener {
                try {
                    windowManager.removeView(outerContainer)
                } catch (e: Exception) {
                    Log.e("OverlayUtils", "Error removing overlay", e)
                } finally {
                    isOverlayShowing = false
                }
            }
        }

        overlayView.addView(titleView)
        overlayView.addView(messageView)
        overlayView.addView(dismissButton)
        outerContainer.addView(overlayView)

        try {
            windowManager.addView(outerContainer, layoutParams)
        } catch (e: Exception) {
            Log.e("OverlayUtils", "Failed to add PreEmptive Loan overlay: ${e.message}")
            isOverlayShowing = false
        }
    }

    fun showPreEmptiveJobAlert(context: Context) {
        if (!Settings.canDrawOverlays(context) || isOverlayShowing) {
            return
        }
        isOverlayShowing = true

        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val layoutParams = createBaseLayoutParams()

        val outerContainer = FrameLayout(context).apply {
            setPadding(48, 48, 48, 48)
            setOnClickListener {
                try {
                    windowManager.removeView(this)
                } catch (e: Exception) {
                } finally {
                    isOverlayShowing = false
                }
            }
        }

        val overlayView = LinearLayout(context).apply {
            isClickable = true
            orientation = LinearLayout.VERTICAL
            val bgDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#E3F2FD")) // Light Blue background
                cornerRadius = 48f
                setStroke(4, Color.parseColor("#1976D2")) // Blue border
            }
            background = bgDrawable
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                elevation = 32f
            }
            setPadding(64, 64, 64, 64)
            val params = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                gravity = Gravity.CENTER
            }
            this.layoutParams = params
        }

        val titleView = TextView(context).apply {
            text = "💼 JOB SAFETY ALERT"
            textSize = 22f
            setTextColor(Color.parseColor("#1976D2")) // Dark Blue
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 24)
        }

        val messageView = TextView(context).apply {
            text = "You are searching for online jobs or tasks.\n\n⚠️ NEVER pay a 'registration fee', 'security deposit', or any sort of fee for a job. If asked for registration money etc, then it's a scam."
            textSize = 18f
            setTextColor(Color.parseColor("#212121"))
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 48)
        }

        val dismissButton = Button(context).apply {
            text = "I UNDERSTAND"
            setTextColor(Color.WHITE)
            setTypeface(null, android.graphics.Typeface.BOLD)
            val btnDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#1976D2"))
                cornerRadius = 24f
            }
            background = btnDrawable
            setPadding(32, 24, 32, 24)
            setOnClickListener {
                try {
                    windowManager.removeView(outerContainer)
                } catch (e: Exception) {
                    Log.e("OverlayUtils", "Error removing overlay", e)
                } finally {
                    isOverlayShowing = false
                }
            }
        }

        overlayView.addView(titleView)
        overlayView.addView(messageView)
        overlayView.addView(dismissButton)
        outerContainer.addView(overlayView)

        try {
            windowManager.addView(outerContainer, layoutParams)
        } catch (e: Exception) {
            Log.e("OverlayUtils", "Failed to add PreEmptive Job overlay: ${e.message}")
            isOverlayShowing = false
        }
    }

    fun showPreEmptiveTradingAlert(context: Context) {
        if (!Settings.canDrawOverlays(context) || isOverlayShowing) {
            return
        }
        isOverlayShowing = true

        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val layoutParams = createBaseLayoutParams()

        val outerContainer = FrameLayout(context).apply {
            setPadding(48, 48, 48, 48)
            setOnClickListener {
                try {
                    windowManager.removeView(this)
                } catch (e: Exception) {
                } finally {
                    isOverlayShowing = false
                }
            }
        }

        val overlayView = LinearLayout(context).apply {
            isClickable = true
            orientation = LinearLayout.VERTICAL
            val bgDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#E8F5E9")) // Light Green background
                cornerRadius = 48f
                setStroke(4, Color.parseColor("#2E7D32")) // Dark Green border
            }
            background = bgDrawable
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                elevation = 32f
            }
            setPadding(64, 64, 64, 64)
            val params = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                gravity = Gravity.CENTER
            }
            this.layoutParams = params
        }

        val titleView = TextView(context).apply {
            text = "📈 TRADING SAFETY ALERT"
            textSize = 22f
            setTextColor(Color.parseColor("#2E7D32")) // Dark Green
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 24)
        }

        val messageView = TextView(context).apply {
            text = "You are searching for trading or cryptocurrency.\n\n⚠️ NEVER join 'VIP Trading Groups' on Telegram or WhatsApp for stock tips.\n\n⚠️ Beware of platforms promising guaranteed high returns or risk-free profits. If it sounds too good to be true, it's a scam designed to steal your investments."
            textSize = 18f
            setTextColor(Color.parseColor("#212121"))
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 48)
        }

        val dismissButton = Button(context).apply {
            text = "I UNDERSTAND"
            setTextColor(Color.WHITE)
            setTypeface(null, android.graphics.Typeface.BOLD)
            val btnDrawable = GradientDrawable().apply {
                setColor(Color.parseColor("#2E7D32"))
                cornerRadius = 24f
            }
            background = btnDrawable
            setPadding(32, 24, 32, 24)
            setOnClickListener {
                try {
                    windowManager.removeView(outerContainer)
                } catch (e: Exception) {
                    Log.e("OverlayUtils", "Error removing overlay", e)
                } finally {
                    isOverlayShowing = false
                }
            }
        }

        overlayView.addView(titleView)
        overlayView.addView(messageView)
        overlayView.addView(dismissButton)
        outerContainer.addView(overlayView)

        try {
            windowManager.addView(outerContainer, layoutParams)
        } catch (e: Exception) {
            Log.e("OverlayUtils", "Failed to add PreEmptive Trading overlay: ${e.message}")
            isOverlayShowing = false
        }
    }

    fun showFakeBookingWarningOverlay(context: Context, chatTitle: String) {
        if (isOverlayShowing) return
        isOverlayShowing = true
        
        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val layoutParams = createBaseLayoutParams()

        val outerContainer = FrameLayout(context).apply {
            // Background is now handled smoothly by FLAG_DIM_BEHIND
        }

        val overlayView = LinearLayout(context).apply {
            isClickable = true
            orientation = LinearLayout.VERTICAL
            setBackgroundColor(Color.parseColor("#FFF3E0")) // Light orange caution background
            background = GradientDrawable().apply {
                setColor(Color.parseColor("#FFF3E0"))
                cornerRadius = 48f
                setStroke(8, Color.parseColor("#F57C00")) // Orange stroke
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) elevation = 32f
            setPadding(64, 64, 64, 64)
            this.layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.WRAP_CONTENT
            ).apply { gravity = Gravity.CENTER }
        }

        val titleView = TextView(context).apply {
            text = "⚠️ BOOKING SCAM WARNING"
            textSize = 22f
            setTextColor(Color.parseColor("#E65100")) // Dark orange text
            setTypeface(null, android.graphics.Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 16)
        }

        val messageView = TextView(context).apply {
            text = "You are discussing a booking or service with '$chatTitle' and they have requested payment.\n\nScammers frequently create fake listings and websites to steal advance payments via QR codes.\n\nNEVER scan a QR code for an unverified booking or service."
            textSize = 16f
            setTextColor(Color.parseColor("#424242"))
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 32)
        }

        val dismissButton = Button(context).apply {
            text = "I UNDERSTAND THE RISK"
            setTextColor(Color.WHITE)
            setTypeface(null, android.graphics.Typeface.BOLD)
            background = GradientDrawable().apply {
                setColor(Color.parseColor("#F57C00"))
                cornerRadius = 24f
            }
            setPadding(32, 24, 32, 24)
            setOnClickListener {
                try { windowManager.removeView(outerContainer) } catch (e: Exception) {} finally { isOverlayShowing = false }
            }
        }

        overlayView.addView(titleView)
        overlayView.addView(messageView)
        overlayView.addView(dismissButton)
        outerContainer.addView(overlayView)

        try {
            windowManager.addView(outerContainer, layoutParams)
        } catch (e: Exception) {
            Log.e("OverlayUtils", "Failed to add Fake Booking overlay: ${e.message}")
            isOverlayShowing = false
        }
    }
}

