import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mycomplex_ui/colors.dart';
import './helper/shared_preferences_helper.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    String? token = await SharedPreferencesHelper.getBearerToken();
    if (!mounted) return;

    if (token != null) {
      // Navigate to Dashboard if the token is available
      context.go('/dashboard', extra: token);
    } else {
      // Navigate to Login if the token is not available
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: AppColors.primary,),
      ),
    );
  }
}