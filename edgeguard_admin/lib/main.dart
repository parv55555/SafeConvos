import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:edgeguard_client/edgeguard_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

var client = Client('https://safeconvos.api.serverpod.space/')..connectivityMonitor = FlutterConnectivityMonitor();


void main() {
  runApp(const SafeConvosApp());
}

class WebScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class SafeConvosApp extends StatelessWidget {
  const SafeConvosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeConvos',
      debugShowCheckedModeBanner: false,
      scrollBehavior: WebScrollBehavior(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFF0B1120),
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.w800, color: Colors.white, height: 1.2),
          displayMedium: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, height: 1.2),
          titleLarge: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          bodyLarge: TextStyle(color: Color(0xFF94A3B8), height: 1.6),
        ),
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [Color(0xFF1E293B), Color(0xFF0B1120)],
          ),
        ),
        child: Focus(autofocus: true, child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                children: [
                  Icon(Icons.shield_moon, color: Colors.indigoAccent.shade100),
                  const SizedBox(width: 12),
                  const Text('SafeConvos', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboard()));
                  },
                  child: const Text('Live Dashboard', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 16),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
                child: Column(
                  children: [
                    const HeroSection(),
                    const SizedBox(height: 100),
                    const FeaturesSection(),
                    const SizedBox(height: 100),
                    const TechStackSection(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 900),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.indigoAccent.withOpacity(0.1),
            ),
            child: Icon(Icons.security, size: 80, color: Colors.indigoAccent.shade100),
          ),
          const SizedBox(height: 32),
          Text(
            'Zero-Trust Scam Protection.\nPowered by Edge AI.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: MediaQuery.of(context).size.width > 600 ? 64 : 40,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'SafeConvos intercepts malicious texts, WhatsApp messages, and voice calls in real-time. By leveraging on-device NLP and behavioral analysis, we protect users from financial fraud with absolute privacy.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  final url = Uri.parse('https://parv55555.github.io/SafeConvos/SafeConvos.apk');
                  launchUrl(url, mode: LaunchMode.externalApplication);
                },
                icon: const Icon(Icons.android),
                label: const Text('Download APK'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  backgroundColor: Colors.indigoAccent.shade400,
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shadowColor: Colors.indigoAccent.withOpacity(0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboard()));
                },
                icon: const Icon(Icons.analytics),
                label: const Text('View Intelligence Dashboard'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.indigoAccent.shade100.withOpacity(0.5), width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: Column(
        children: [
          Text('How it Works', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 16),
          Text('Engineered for absolute privacy and zero latency.', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18)),
          const SizedBox(height: 48),
          Wrap(
            spacing: 32,
            runSpacing: 32,
            alignment: WrapAlignment.center,
            children: const [
              FeatureCard(
                icon: Icons.smartphone,
                title: '100% On-Device Processing',
                description: 'We utilize Android Accessibility Services to read incoming messages locally. No messages ever leave your device for classification.',
              ),
              FeatureCard(
                icon: Icons.privacy_tip,
                title: 'Privacy-First Data Collection',
                description: 'We do NOT collect your private conversations. Only confirmed scam reports (where you verify a scam) are sent to our Serverpod Cloud for global threat intelligence.',
              ),
              FeatureCard(
                icon: Icons.offline_bolt,
                title: 'Zero Latency',
                description: 'By bypassing cloud APIs for detection, our TFLite models analyze incoming texts in milliseconds, blocking scams before you even read them.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 900),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology, color: Colors.purpleAccent.shade100, size: 40),
              const SizedBox(width: 16),
              Text('NLP & Behavioral Analysis', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 32)),
            ],
          ),
          const SizedBox(height: 24),
          const TechPoint(
            title: 'On-Device NLP (TFLite)',
            description: 'SafeConvos utilizes quantized TensorFlow Lite models running directly on the Android NPU. The models parse sentence structure and semantics to detect urgency, financial demands, and spoofed authority (e.g., fake bank alerts).',
          ),
          const SizedBox(height: 16),
          const TechPoint(
            title: 'Behavioral Heuristics',
            description: 'Beyond text analysis, we analyze sender behavior: rapid messaging bursts, unknown numbers containing links, and pressure-inducing terminology. This dual-layered approach drastically reduces false positives.',
          ),
          const SizedBox(height: 16),
          const TechPoint(
            title: 'Accessibility Pipeline',
            description: 'Our Kotlin-based Accessibility Service seamlessly hooks into UI events, extracting text across WhatsApp, SMS, and system notifications without requiring root access or intrusive permissions.',
          ),
        ],
      ),
    );
  }
}

class TechPoint extends StatelessWidget {
  final String title;
  final String description;
  const TechPoint({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(description, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 16, height: 1.5)),
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureCard({super.key, required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 48, color: Colors.indigoAccent.shade200),
          const SizedBox(height: 24),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Text(description, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  AdminDashboardState createState() => AdminDashboardState();
}

class AdminDashboardState extends State<AdminDashboard> {
  List<ScamReport> scams = [];
  List<FalsePositiveReport> falsePositives = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final fetchedScams = await client.adminDataset.getAllScamReports();
      final fetchedFPs = await client.adminDataset.getAllFalsePositives();
      
      setState(() {
        scams = fetchedScams;
        falsePositives = fetchedFPs;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: ');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F172A),
          title: const Text('Global Threat Intelligence'),
          bottom: const TabBar(
            indicatorColor: Colors.indigoAccent,
            tabs: [
              Tab(icon: Icon(Icons.warning, color: Colors.redAccent), text: 'Confirmed Scams'),
              Tab(icon: Icon(Icons.check_circle, color: Colors.greenAccent), text: 'False Positives'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() => isLoading = true);
                _fetchData();
              },
            )
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0B1120), Color(0xFF1E293B)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: isLoading 
              ? const Center(child: CircularProgressIndicator(color: Colors.indigoAccent))
              : TabBarView(
                  children: [
                    _buildScamList(scams),
                    _buildFPList(falsePositives),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildScamList(List<ScamReport> list) {
    if (list.isEmpty) {
      return const Center(child: Text('No scam reports yet.', style: TextStyle(color: Colors.white70)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        final String messageText = (item.city != null && item.city!.trim().isNotEmpty)
            ? item.city!
            : 'Scam message detected and blocked by SafeConvos AI.';
        final String timeFormatted = item.timestamp.toLocal().toString().substring(0, 16);

        return Card(
          elevation: 6,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.redAccent.withOpacity(0.3), width: 1),
          ),
          color: const Color(0xFF1E293B),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.redAccent,
                          child: Icon(Icons.warning_amber_rounded, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          item.phoneNumber,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.redAccent.withOpacity(0.6)),
                      ),
                      child: Text(
                        item.category.toUpperCase(),
                        style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Scam Message Content:',
                        style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      SelectableText(
                        messageText,
                        style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reported: $timeFormatted',
                      style: const TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                    const Row(
                      children: [
                        Icon(Icons.shield_outlined, color: Colors.redAccent, size: 14),
                        SizedBox(width: 4),
                        Text('AI Intercepted', style: TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFPList(List<FalsePositiveReport> list) {
    if (list.isEmpty) {
      return const Center(child: Text('No false positives reported.', style: TextStyle(color: Colors.white70)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        final String timeFormatted = item.timestamp.toLocal().toString().substring(0, 16);
        return Card(
          elevation: 6,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.greenAccent.withOpacity(0.3), width: 1),
          ),
          color: const Color(0xFF1E293B),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.greenAccent,
                          child: Icon(Icons.verified_user, color: Colors.black87, size: 20),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'False Positive',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.greenAccent.withOpacity(0.6)),
                      ),
                      child: const Text(
                        'USER FEEDBACK',
                        style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Legitimate Message Content:',
                        style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      SelectableText(
                        item.messageContent,
                        style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Reported: $timeFormatted',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
