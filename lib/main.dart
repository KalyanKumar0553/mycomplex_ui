import 'package:flutter/material.dart';
import 'package:mycomplex_ui/colors.dart';
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
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primary,
          secondary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
        ),
        scaffoldBackgroundColor: AppColors.background,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.inputFillColor,
          labelStyle: const TextStyle(color: AppColors.inputLabelColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.onPrimary, backgroundColor: AppColors.primary,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
          ),
        ),
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
            Color(0xFFAD5472),
            Color(0xFFAD5472),
          ],
        ),
      ),
      child: child,
    );
  }
}