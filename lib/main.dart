import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Screens
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/eco_home_screen.dart';
import 'screens/eco_urban_health_screen.dart';
import 'screens/predict_ai_screen.dart';
import 'screens/eco_route_screen.dart';
import 'screens/relocate_screen.dart'; // ✅ Relocate Screen যোগ করা হলো

// Services
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eco City',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),

      // ✅ সব Route এখানে রেজিস্টার করা হলো
      routes: {
        '/': (context) => const AuthWrapper(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const EcoHomeScreen(),
        '/predict': (context) => const PredictAiScreen(),
        '/urbanHealth': (ctx) => const EcoUrbanHealthScreen(),
        '/ecoRoute': (ctx) => const EcoRouteScreen(),
        '/relocate': (ctx) => const RelocateScreen(), // ✅ Relocate যোগ হলো
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          // ✅ যদি ইউজার লগইন করা থাকে তাহলে হোমে যাবে
          return const EcoHomeScreen();
        } else {
          // ✅ না থাকলে LoginScreen দেখাবে
          return const LoginScreen();
        }
      },
    );
  }
}
