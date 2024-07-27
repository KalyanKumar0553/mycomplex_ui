import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mycomplex_ui/screens/signup_screen.dart';

void main() {
  testWidgets('Signup screen has a title and buttons', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignUpScreen(),
      ),
    );

    expect(find.text('Sign up'), findsOneWidget);
    expect(find.text('Create your account'), findsOneWidget);
    expect(find.text('Sign up'), findsOneWidget);
    expect(find.text('Already have an account? Login'), findsOneWidget);
  });

  testWidgets('Signup button triggers validation', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignUpScreen(),
      ),
    );

    await tester.tap(find.text('Sign up'));
    await tester.pump();

    // Add validation expectation
  });

  testWidgets('Toggle between email and mobile number', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignUpScreen(),
      ),
    );

    expect(find.text('Email'), findsOneWidget);
    await tester.tap(find.text('Mobile'));
    await tester.pump();
    expect(find.text('Mobile Number'), findsOneWidget);
  });
}
