import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mycomplex_ui/colors.dart';
import 'package:mycomplex_ui/services/auth_service.dart';
import '../widgets/custom_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailOrMobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  bool isEmail = true;

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

 void _signUp() async {
    if (_formKey.currentState!.validate()) {
      String emailOrMobile = emailOrMobileController.text.trim();
      String password = passwordController.text.trim();
      Map<String, dynamic> payload = isEmail
          ? {'email': emailOrMobile, 'password': password}
          : {'mobile': emailOrMobile, 'password': password};
      try {
        final response = await _authService.signUp(payload);
        Fluttertoast.showToast(
          msg: response['message'] ?? 'Sign up successful',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.success,
          textColor: AppColors.onPrimary,
          fontSize: 16.0,
        );
      } catch (e) {
        Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.error,
          textColor: AppColors.onPrimary,
          fontSize: 16.0,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign up',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
              const SizedBox(height: 8),
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
              const SizedBox(height: 8),
              CustomTextField(
                labelText: isEmail ? 'Email' : 'Mobile Number',
                controller: emailOrMobileController,
                inputType: isEmail ? TextInputType.emailAddress : TextInputType.phone,
                validator: isEmail ? emailValidator : mobileValidator,
                prefixIcon: const Icon(Icons.person),
              ),
              CustomTextField(
                labelText: 'Password',
                controller: passwordController,
                isPassword: true,
                validator: passwordValidator,
                prefixIcon: const Icon(Icons.password),
              ),
              CustomTextField(
                labelText: 'Confirm Password',
                controller: confirmPasswordController,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.password),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _signUp,
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.onPrimary,
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 50), // full-width button
                ),
                child: const Text('Sign up'),
              ),
              const SizedBox(height: 12),
              const Text('Or'),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  context.go("/");
                },
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
