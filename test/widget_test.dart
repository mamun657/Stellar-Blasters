import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eco_city/main.dart';


void main() {
  testWidgets('App loads and shows Login Screen', (WidgetTester tester) async {
    
    await tester.pumpWidget(const MyApp());

    
    await tester.pumpAndSettle();

    
    expect(find.text('Login'), findsOneWidget);


    expect(find.byType(TextFormField), findsWidgets);

   
    expect(find.text('Sign In'), findsOneWidget);
  });
}
