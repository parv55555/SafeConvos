import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> with WidgetsBindingObserver {
  static const platform = MethodChannel('com.parv.safetexts/bridge');

  bool isAccessibilityEnabled = false;
  bool isNotificationListenerEnabled = false;
  bool isContactsPermissionGranted = false;
  bool isCallLogPermissionGranted = false;
  bool isPhoneStatePermissionGranted = false;
  bool isOverlayPermissionGranted = false;
  bool isBatteryOptimized = false;
  bool isUsageStatsEnabled = false;

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
      setState(() {
        isAccessibilityEnabled = perms['isAccessibilityEnabled'] ?? false;
        isNotificationListenerEnabled = perms['isNotificationListenerEnabled'] ?? false;
        isContactsPermissionGranted = perms['isContactsPermissionGranted'] ?? false;
        isCallLogPermissionGranted = perms['isCallLogPermissionGranted'] ?? false;
        isPhoneStatePermissionGranted = perms['isPhoneStatePermissionGranted'] ?? false;
        isOverlayPermissionGranted = perms['isOverlayPermissionGranted'] ?? false;
        isBatteryOptimized = perms['isBatteryOptimized'] ?? false;
        isUsageStatsEnabled = perms['isUsageStatsEnabled'] ?? false;
      });
    } on PlatformException catch (e) {
      print("Failed to get permissions: ${e.message}");
    }
  }

  Future<void> _requestPermission(String type) async {
    try {
      await platform.invokeMethod('requestPermission', {'type': type});
    } on PlatformException catch (e) {
      print("Failed to request permission: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permissions')),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const Text('Scam Message Protection', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildCard([
            _buildRow('Accessibility Access', 'Required to read messages from WhatsApp & SMS for scams.', isAccessibilityEnabled, 'accessibility'),
            const Divider(),
            _buildRow('Notification Access', 'Required to scan background messages and VoIP calls for scams.', isNotificationListenerEnabled, 'notification'),
          ]),
          const SizedBox(height: 24),
          const Text('Screen & App Security', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildCard([
            _buildRow('Overlay Permission', 'Required to show scam warnings over other apps.', isOverlayPermissionGranted, 'overlay'),
            const Divider(),
            _buildRow('Usage Access', 'Required to detect when banking apps are opened to prevent digital arrest scams.', isUsageStatsEnabled, 'usage'),
          ]),
          const SizedBox(height: 24),
          const Text('System & Background', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildCard([
            _buildRow('Battery Optimization', 'Prevent the system from killing the background scanner.', isBatteryOptimized, 'battery'),
          ]),
          const SizedBox(height: 32),
          const Text(
            'Developed by SafeConvos in collaboration with Indore cyber cell. AI model is trained over the scam patterns observed in the recent complaints in Indore.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildRow(String title, String description, bool isGranted, String type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              Text(description, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
            ],
          ),
        ),
        Switch(
          value: isGranted,
          onChanged: (val) {
             _requestPermission(type);
          },
          activeColor: Colors.white,
          activeTrackColor: Colors.green,
        )
      ],
    );
  }
}

