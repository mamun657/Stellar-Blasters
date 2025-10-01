import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/eco_home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/predict_ai_screen.dart';
import 'screens/signup_screen.dart';
import 'services/auth_service.dart';
import 'screens/eco_urban_health_screen.dart';
import 'services/gemini_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  final gemini = GeminiService(apiKey: "AIzaSyACl28JncbrqtUJMt7IXFGm7rV8WbuLGog");

  final response = await gemini.askGemini(
    "Hello Gemini, can you tell me a fun eco fact?",
  );
  print("Gemini response: $response");

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
      routes: {
        '/': (context) => const AuthWrapper(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const EcoHomeScreen(),
        '/predict': (context) => const PredictAiScreen(),
        '/urbanHealth': (ctx) => const EcoUrbanHealthScreen(),
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
          return const EcoHomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
