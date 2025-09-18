

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';

import '../lib/main.dart';

void main() {
  setUpAll(() async {
   
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'test-api-key',
        appId: 'test-app-id',
        messagingSenderId: 'test-sender-id',
        projectId: 'test-project-id',
      ),
    );
  });

  testWidgets('App loads and shows login screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for the app to settle (e.g., Firebase initialization)
    await tester.pumpAndSettle();

    // Verify that the login screen is displayed
    expect(find.byType(TextFormField), findsWidgets);
    expect(find.byType(ElevatedButton), findsWidgets);
  });
}
