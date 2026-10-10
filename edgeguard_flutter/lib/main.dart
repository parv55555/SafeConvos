import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edgeguard_client/edgeguard_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'theme/app_theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/permissions_screen.dart';
import 'screens/terms_screen.dart';
import 'screens/privacy_screen.dart';

late final Client client;
late final SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  const serverUrlFromEnv = String.fromEnvironment('SERVER_URL');
  final serverUrl = serverUrlFromEnv.isEmpty ? 'http://localhost:8080/' : serverUrlFromEnv;
  client = Client(serverUrl)..connectivityMonitor = FlutterConnectivityMonitor();
  
  bool hasAccepted = prefs.getBool('has_accepted_tc') ?? false;

  runApp(MyApp(startRoute: hasAccepted ? '/home' : '/welcome'));
}

class MyApp extends StatelessWidget {
  final String startRoute;
  const MyApp({super.key, required this.startRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeConvos',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: startRoute,
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/home': (context) => const HomeScreen(),
        '/permissions': (context) => const PermissionsScreen(),
        '/terms': (context) => const TermsScreen(),
        '/privacy': (context) => const PrivacyScreen(),
      },
    );
  }
}

