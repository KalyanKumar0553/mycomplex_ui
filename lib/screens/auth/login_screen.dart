import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mycomplex_ui/constants.dart';
import 'package:mycomplex_ui/helper/shared_preferences_helper.dart';
import 'package:mycomplex_ui/screens/auth/forgot_password_screen.dart';
import 'package:mycomplex_ui/screens/auth/signup_screen.dart';
import 'package:mycomplex_ui/screens/dashboard/dashboard_screen.dart';
import 'package:mycomplex_ui/widgets/custom_toast_msg.dart';
import '../../widgets/custom_text_field.dart';
import '../../colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailOrMobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  bool isEmail = true;

   @override
  void initState() {
    super.initState(); 
    _checkLoginStatus();
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? mobileValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    final mobileRegex = RegExp(r'^[0-9]{10}$');
    if (!mobileRegex.hasMatch(value)) {
      return 'Please enter a valid 10-digit mobile number';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void _showCustomToast(String message, ToastStatus status, {IconData icon = Icons.info}) {
    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = CustomToastMsg(message: message, icon: icon, status: status);
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

   String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  Future<void> _checkLoginStatus() async {
    String? bearer_token = await SharedPreferencesHelper.getValue(SharedPreferencesKeys.bearerTokenKey);
    String? userID = await SharedPreferencesHelper.getValue(SharedPreferencesKeys.userIDKey);
    if (!mounted) return;
    if (bearer_token != null) {
      context.go('/dashboard', extra: {'token': bearer_token, 'userID': userID});
    }
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String emailOrMobile = emailOrMobileController.text.trim();
      String password = passwordController.text.trim();
      Map<String, dynamic> payload = isEmail
          ? {'email': emailOrMobile, 'password': password, 'isEmailSent': isEmail}
          : {'mobile': emailOrMobile, 'password': password, 'isEmailSent': isEmail};
      try {
          final response = await _authService.login(payload);
          String bearer_token = response['tokenType'] + ' ' +response['accessToken'];
          _showCustomToast('Login successful', ToastStatus.success, icon: Icons.check_circle);
          await SharedPreferencesHelper.saveValue(SharedPreferencesKeys.bearerTokenKey,bearer_token);
          await SharedPreferencesHelper.saveValue(SharedPreferencesKeys.userIDKey,emailOrMobile);
          if (!mounted) return;
          context.go('/dashboard', extra: {'token': bearer_token, 'userID': emailOrMobile});
      } catch (e) {
        _showCustomToast(e.toString(), ToastStatus.failure, icon: Icons.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 200,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Enter your credentials to login',
                    style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.inputLabelColor,),
                  ),
                  const SizedBox(height: 16),
                  ToggleButtons(
                    isSelected: [isEmail, !isEmail],
                    onPressed: (int index) {
                      setState(() {
                        isEmail = index == 0;
                      });
                    },
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Email'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Mobile'),
                      ),
                    ],
                  ),
                  CustomTextField(
                    labelText: isEmail ? 'Email' : 'Mobile Number',
                    controller: emailOrMobileController,
                    inputType: isEmail ? TextInputType.emailAddress : TextInputType.phone,
                    validator: isEmail ? emailValidator : mobileValidator,
                    prefixIcon: isEmail ? const Icon(Icons.email) : const Icon(Icons.phone),
                    helperText: isEmail ? 'Enter your email address' : 'Enter your mobile number',
                  ),
                  CustomTextField(
                    labelText: 'Password',
                    controller: passwordController,
                    isPassword: true,
                    validator: passwordValidator,
                    helperText: 'Enter your password',
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.background, backgroundColor: AppColors.primary, // foreground (text) color
                      minimumSize: const Size(double.infinity, 50), // full-width button
                    ),
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      // context.go('/forgot_password');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ),
                      );
                    },
                    child: const Text('Forgot password?'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                      );
                    },
                    child: const Text('Don\'t have an account? Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        )
      );
    }
}
