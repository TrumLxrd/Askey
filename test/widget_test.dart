// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:liquid_glass_ui_app/main.dart';

void main() {
  testWidgets('Login screen loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the login title appears
    expect(find.text('Log In'), findsWidgets);

    // Verify that the sign in text appears
    expect(find.text('Sign in to continue'), findsOneWidget);

    // Verify that email field appears
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);

    // Verify that password field appears
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
  });
}
