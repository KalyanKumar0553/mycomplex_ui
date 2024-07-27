import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mycomplex_ui/colors.dart';
import '../widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailOrPhoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

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
                height: 100,
              ),
              const SizedBox(height: 16),
              const Text(
                'Enter your email or phone number to reset password',
                style: TextStyle(fontSize: 16,color: AppColors.primary),
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
                    child: Text('Phone'),
                  ),
                ],
              ),
              CustomTextField(
                labelText: isEmail ? 'Email' : 'Phone Number',
                controller: emailOrPhoneController,
                inputType: isEmail ? TextInputType.emailAddress : TextInputType.phone,
                validator: isEmail ? emailValidator : phoneValidator,
                prefixIcon: isEmail ? const Icon(Icons.email) : const Icon(Icons.phone),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Add forgot password logic here
                    context.go('/otp_verification');
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: AppColors.primary, // foreground (text) color
                  minimumSize: const Size(double.infinity, 50), // full-width button
                ),
                child: const Text('Reset Password'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
