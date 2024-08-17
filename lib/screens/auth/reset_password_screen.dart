import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mycomplex_ui/colors.dart';
import 'package:mycomplex_ui/services/auth_service.dart';
import 'package:mycomplex_ui/widgets/custom_toast_msg.dart';
import '../../widgets/custom_text_field.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ResetPasswordScreen extends StatefulWidget {
  final bool isEmail;
  final String contact;

  const ResetPasswordScreen({required this.isEmail,required this.contact,super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> with CodeAutoFill {
  final TextEditingController otpController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  bool isEmail = true;

  @override
    void initState() {
      super.initState();
      listenForCode(); // Provide Pattern to 
    }

    @override
    void dispose() {
      cancel();
      super.dispose();
    }

    @override
    void codeUpdated() {
      setState(() {
        otpController.text = code!;
      });
    }

    String? otpValidator(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter the OTP';
      }
      if (value.length != 6) {
        return 'OTP must be 6 digits';
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

    void _resetPassword() async {
      if (_formKey.currentState!.validate()) {
      Map<String, dynamic> payload = widget.isEmail
          ? {'email': widget.contact, 'otp': otpController.text,'isEmailSent':isEmail}
          : {'mobile': widget.contact, 'otp': passwordController.text,'isEmailSent':isEmail};
      try {
        final response = await _authService.resetPassword(payload);
        _showCustomToast(response['message'] ?? 'OTP verified successfully. Please login with credentials.', ToastStatus.success, icon: Icons.check_circle);
        if (mounted) {
          int count = 0;
          Navigator.of(context).popUntil((_) => count++ >= 2);
        }
      } catch (e) {
        print('Error: $e');  // Print error to console
        _showCustomToast("Error to verify OTP : Please try again", ToastStatus.failure, icon: Icons.error);
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child:  Padding(
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
                  'Verify OTP',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.inputLabelColor),
                ),
                const SizedBox(height: 8),
                Text('Enter the OTP sent to your ${widget.isEmail ? 'email' : 'mobile number'}'),
                CustomTextField(
                  labelText: 'OTP',
                  controller: otpController,
                  inputType: TextInputType.number,
                  validator: otpValidator,
                  prefixIcon: const Icon(Icons.lock),
                  helperText: 'Enter the 6-digit OTP',
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
                  onPressed: _resetPassword,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.background, 
                    backgroundColor: AppColors.primary, // foreground (text) color
                    minimumSize: const Size(double.infinity, 50), // full-width button
                  ),
                  child: const Text('Verify OTP'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    int count = 0;
                    Navigator.of(context).popUntil((_) => count++ >= 2);
                  },
                  child: const Text('Back to Login'),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
