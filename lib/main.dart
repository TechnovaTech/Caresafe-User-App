import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/otp_verification_screen.dart';
import 'screens/permissions_screen.dart';
import 'screens/emergency_contact_screen.dart';
import 'screens/home_screen.dart';
import 'screens/consult_screen.dart';
import 'screens/records_screen.dart';
import 'screens/sos_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/profile_settings_screen.dart';

import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF181571)),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.black87),
          titleMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/verification': (context) => const OtpVerificationScreen(),
        '/permissions': (context) => const PermissionsScreen(),
        '/emergency': (context) => const EmergencyContactScreen(),
        '/home': (context) => const HomeScreen(),
        '/consult': (context) => const ConsultScreen(),
        '/records': (context) => const RecordsScreen(),
        '/sos': (context) => const SosScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/profile-settings': (context) => const ProfileSettingsScreen(),
        '/notifications': (context) => const NotificationsScreen(),
      },
    );
  }
}