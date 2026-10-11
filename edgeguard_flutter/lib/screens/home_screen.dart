import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import 'package:edgeguard_client/edgeguard_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  static const platform = MethodChannel('com.parv.safetexts/bridge');
  bool isAllGranted = false;
  Map<dynamic, dynamic> currentPerms = {};
  List<dynamic> messages = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermissions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermissions();
    }
  }

  Future<void> _checkPermissions() async {
    try {
      final Map<dynamic, dynamic> perms = await platform.invokeMethod('checkPermissions');
      currentPerms = perms;
      bool allGranted = perms['isAccessibilityEnabled'] == true &&
          perms['isNotificationListenerEnabled'] == true &&
          perms['isOverlayPermissionGranted'] == true &&
          perms['isBatteryOptimized'] == true &&
          perms['isUsageStatsEnabled'] == true;

      setState(() {
        isAllGranted = allGranted;
      });

      if (allGranted) {
        _loadMessages();
      }
    } on PlatformException catch (e) {
      print("Failed to get permissions: ${e.message}");
    }
  }

  Future<void> _loadMessages() async {
    try {
      final List<dynamic> msgs = await platform.invokeMethod('getMessages');
      setState(() {
        messages = msgs;
      });

      for (var msg in msgs) {
        String analysis = msg['analysisResult'] ?? '';
        if (analysis.toLowerCase().contains('scam') || analysis.toLowerCase().contains('alert')) {
          _silentSyncToServerpod(msg['sender'], analysis);
        } else if (analysis == "FALSE_POSITIVE") {
          _silentSyncFalsePositiveToServerpod(msg['id'].toString(), msg['content']);
        }
      }
    } on PlatformException catch (e) {
      print("Failed to get messages: ${e.message}");
    }
  }

  Future<void> _silentSyncFalsePositiveToServerpod(String msgId, String content) async {
    String key = 'fp_synced_$msgId';
    bool alreadySynced = prefs.getBool(key) ?? false;
    if (!alreadySynced) {
      try {
        await client.scam.reportFalsePositive(FalsePositiveReport(
          messageContent: content,
          timestamp: DateTime.now().toUtc(),
        ));
        await prefs.setBool(key, true);
        print("Successfully synced False Positive for ID: $msgId");
      } catch (e) {
        print("Failed to sync False Positive to Serverpod: $e");
      }
    }
  }

  Future<void> _silentSyncToServerpod(String sender, String category) async {
    String key = 'synced_$sender';
    bool alreadySynced = prefs.getBool(key) ?? false;
    if (!alreadySynced) {
      try {
        await client.scam.reportScam(ScamReport(
          phoneNumber: sender,
          category: category,
          timestamp: DateTime.now().toUtc(),
        ));
        prefs.setBool(key, true);
      } catch (e) {
        print('Serverpod sync failed: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredMessages = messages;
    if (searchQuery.isNotEmpty) {
      filteredMessages = messages.where((msg) {
        return msg['sender'].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               msg['content'].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('SafeConvos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                  Row(
                    children: [
                      if (isAllGranted && messages.isNotEmpty)
                        IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () => Navigator.pushNamed(context, '/permissions', arguments: currentPerms).then((_) => _checkPermissions()),
                      ),
                    ],
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('AI based scam detector', style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant)),
              ),
              if (isAllGranted && (messages.isNotEmpty || searchQuery.isNotEmpty)) ...[
                const SizedBox(height: 16),
                TextField(
                  onChanged: (val) => setState(() => searchQuery = val),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: searchQuery.isNotEmpty ? IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(() => searchQuery = '')) : null,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              Expanded(
                child: !isAllGranted 
                ? _buildBlockedState() 
                : _buildMessagesList(filteredMessages),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlockedState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.security, size: 80, color: Theme.of(context).colorScheme.error),
        const SizedBox(height: 24),
        const Text('Protection Disabled', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('All permissions are required for protection.', textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: FilledButton(
            onPressed: () => Navigator.pushNamed(context, '/permissions', arguments: currentPerms).then((_) => _checkPermissions()),
            style: FilledButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            child: const Text('Activate Protection', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildMessagesList(List<dynamic> items) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('No messages scanned yet.', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
            Text('Unknown messages will appear here.', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        var msg = items[index];
        bool isScam = msg['analysisResult'].toString().toLowerCase().contains('scam');
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(msg['sender'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), overflow: TextOverflow.ellipsis)),
                    Text(msg['analysisResult'].toString().toUpperCase(), style: TextStyle(color: isScam ? Colors.red : Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(msg['content']),
                const SizedBox(height: 8),
                Text(msg['appName'] ?? '', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 12)),
              ],
            ),
          ),
        );
      },
    );
  }
}
