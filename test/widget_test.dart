// This is a basic Flutter widget test for the Cinemax app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:movie_ticket_booking/main.dart';
// ignore: depend_on_referenced_packages
//import 'package:movie_ticket_booking/main.dart';
import 'package:moviex/main.dart';

void main() {
  testWidgets('App launches with splash screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that splash screen elements are present
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Cinemax'), findsOneWidget);
  });

  testWidgets('Splash screen navigates after delay',
      (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const MyApp());

    // Wait for splash screen duration (3 seconds)
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Verify navigation occurred (onboarding or next screen should be visible)
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
