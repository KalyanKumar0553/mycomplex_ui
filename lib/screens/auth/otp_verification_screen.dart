import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:mycomplex_ui/colors.dart';
import 'package:mycomplex_ui/services/auth_service.dart';
import 'package:mycomplex_ui/widgets/custom_toast_msg.dart';
import '../../widgets/custom_text_field.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpVerificationScreen extends StatefulWidget {
  final bool isEmail;
  final String contact;

  const OtpVerificationScreen({required this.isEmail,required this.contact,super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> with CodeAutoFill {
  final TextEditingController otpController = TextEditingController();
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

    void _verifyOtp() async {
      if (_formKey.currentState!.validate()) {
      String otp = otpController.text.trim();
      Map<String, dynamic> payload = widget.isEmail
          ? {'email': widget.contact, 'otp': otp}
          : {'mobile': widget.contact, 'otp': otp};
      try {
        final response = await _authService.verifyOtp(payload);
        print('Response: $response');  // Print response to console
        _showCustomToast(response['message'] ?? 'OTP verified successfully', ToastStatus.success, icon: Icons.check_circle);

        if (mounted) {
          context.go('/dashboard', extra: {'token': response['token'], 'userID': response['userID'],});
        }
      } catch (e) {
        print('Error: $e');  // Print error to console
        _showCustomToast(e.toString(), ToastStatus.failure, icon: Icons.error);
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
      backgroundColor: Colors.white,
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
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.onPrimary, 
                    backgroundColor: AppColors.primary, // foreground (text) color
                    minimumSize: const Size(double.infinity, 50), // full-width button
                  ),
                  child: const Text('Verify OTP'),
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
      )
    );
  }
}
