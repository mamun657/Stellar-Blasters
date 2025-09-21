import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eco_city/main.dart';
// 👆 Replace `eco_city` with your actual project name from pubspec.yaml

void main() {
  testWidgets('App loads and shows Login Screen', (WidgetTester tester) async {
    // Load the main app widget
    await tester.pumpWidget(const MyApp());

    // Let the UI settle
    await tester.pumpAndSettle();

    // ✅ Check for Login text
    expect(find.text('Login'), findsOneWidget);

    // ✅ Check if we have at least one TextFormField
    expect(find.byType(TextFormField), findsWidgets);

    // ✅ Check if the Sign In button is there
    expect(find.text('Sign In'), findsOneWidget);
  });
}
