import 'package:flutter/material.dart';
import 'package:mycomplex_ui/routes.dart';
import 'package:mycomplex_ui/screens/dashboard_screen.dart';
import 'package:mycomplex_ui/screens/forgot_password_screen.dart';
import 'package:mycomplex_ui/screens/otp_verification_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MyComplex - User App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      routerConfig: router,
    );
  }
}

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 118, 13, 188),
            Color.fromARGB(255, 107, 12, 112),
          ],
        ),
      ),
      child: child,
    );
  }
}