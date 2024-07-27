import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mycomplex_ui/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/otp_verification_screen.dart';
import 'splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) {
        final String token = state.extra as String;
        return DashboardScreen(token: token);
      },
    ),
    GoRoute(
      path: '/forgot_password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/otp_verification',
      builder: (context, state) => const OtpVerificationScreen(),
    ),
  ],
);