import 'package:flutter/material.dart';
import 'screens/eco_home_screen.dart'; // 👈 correct path since the file is inside lib/screens/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // hides debug banner
      title: 'Eco City',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const EcoHomeScreen(), // 👈 load your EcoHomeScreen
    );
  }
}
