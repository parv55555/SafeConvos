import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Terms and Conditions', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text(
              "Welcome to SafeConvos. By using our app, you agree to the following terms:\n\n" +
              "1. Acceptance of Terms\nBy accessing and using this application, you accept and agree to be bound by the terms and provision of this agreement.\n\n" +
              "2. Description of Service\nSafeConvos provides local on-device scanning of incoming notifications to detect potential scams using artificial intelligence.\n\n" +
              "3. Privacy & Data\nAll message scanning is performed locally on your device. We do not transmit your private messages to any external servers.\n\n" +
              "4. Disclaimer of Warranties\nThe app is provided \"as is\". We do not guarantee that all scams will be detected, nor do we take responsibility for false positives.\n\n" +
              "5. Limitation of Liability\nSafeConvos and its developers shall not be liable for any direct, indirect, incidental, or consequential damages resulting from the use or inability to use the service.",
            ),
          ],
        ),
      ),
    );
  }
}

