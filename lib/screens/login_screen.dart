import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mycomplex_ui/colors.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
              const SizedBox(height: 8),
              const Text('Enter your credential to login',style: TextStyle(color: AppColors.primary)),
              CustomTextField(
                labelText: 'Username',
                controller: usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.person),
              ),
              CustomTextField(
                labelText: 'Password',
                controller: passwordController,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.password),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Simulate a login API call and save token
                    String token = 'sample_bearer_token';
                    context.go('/dashboard', extra: token);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.onPrimary,
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 50), // full-width button
                ),
                child: const Text('Login'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  context.go('/forgot_password');
                },
                child: const Text('Forgot password?'),
              ),
              TextButton(
                onPressed: () {
                  context.go('/signup');
                },
                child: const Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
