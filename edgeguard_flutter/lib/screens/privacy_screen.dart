import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Privacy Policy', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text(
              "Your privacy is our primary concern.\n\n" +
              "On-Device Processing:\n" +
              "SafeConvos was built with a strict privacy-first architecture. All machine learning inference and message analysis happens locally on your phone using TensorFlow Lite. We use our highly trained A0908i model for this purpose. Your messages never leave your device.\n\n" +
              "Permissions:\n" +
              "- Notification Access: Required strictly to read incoming messages for analysis.\n" +
              "- Contacts Access: Used locally to determine if a sender is known to you.\n" +
              "- Overlay Permission: Used to display the scam warning immediately over other apps.\n\n" +
              "Data Retention:\n" +
              "Scanned messages are stored in a local encrypted database on your device and are automatically deleted after 12 days to conserve space and maintain privacy.\n\n" +
              "Changes to Privacy Policy:\n" +
              "We reserve the right to modify this privacy policy at any time, so please review it frequently.",
            ),
          ],
        ),
      ),
    );
  }
}


