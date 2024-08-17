import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mycomplex_ui/colors.dart';
import 'package:mycomplex_ui/screens/auth/otp_verification_screen.dart';
import 'package:mycomplex_ui/screens/auth/reset_password_screen.dart';
import 'package:mycomplex_ui/services/auth_service.dart';
import 'package:mycomplex_ui/widgets/custom_toast_msg.dart';
import '../../widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailOrMobileController = TextEditingController();
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


  void _forgotPassword() async {
    if (_formKey.currentState!.validate()) {
      String emailOrMobile = emailOrMobileController.text.trim();
      Map<String, dynamic> payload = isEmail
          ? {'email': emailOrMobile,'isEmailSent': isEmail}
          : {'mobile': emailOrMobile,'isEmailSent': isEmail};
      try {
        final response = await _authService.sendOTP(payload);
        _showCustomToast(response['message'] ?? 'Login successful', ToastStatus.success, icon: Icons.check_circle);
        if (mounted) {
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPasswordScreen(isEmail: isEmail,contact: emailOrMobile,),
            ),
          );
        }
      } catch (e) {
        print('Error: $e');  // Print error to console
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
                Text(
                  isEmail ? 'Enter email to reset password' : 'Enter phone number to reset password',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.inputLabelColor,
                  ),
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
                  controller: emailOrMobileController,
                  inputType: isEmail ? TextInputType.emailAddress : TextInputType.phone,
                  validator: isEmail ? emailValidator : phoneValidator,
                  prefixIcon: isEmail ? const Icon(Icons.email) : const Icon(Icons.phone),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _forgotPassword,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.background, backgroundColor: AppColors.primary, // foreground (text) color
                    minimumSize: const Size(double.infinity, 50), // full-width button
                  ),
                  child: const Text('Reset Password'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back to Login'),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

}
