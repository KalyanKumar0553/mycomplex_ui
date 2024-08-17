import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:mycomplex_ui/colors.dart';
import 'package:mycomplex_ui/screens/auth/otp_verification_screen.dart';
import 'package:mycomplex_ui/services/auth_service.dart';
import '../../widgets/custom_text_field.dart';
import 'package:mycomplex_ui/widgets/custom_toast_msg.dart';

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
  bool isSignupRequestInProgress = false;
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
      setState(() {
        isSignupRequestInProgress = true;
      });
      String emailOrMobile = emailOrMobileController.text.trim();
      String password = passwordController.text.trim();
      Map<String, dynamic> payload = isEmail
          ? {'email': emailOrMobile, 'password': password, 'isEmailSent': isEmail}
          : {'mobile': emailOrMobile, 'password': password, 'isEmailSent': isEmail};
      try {
        final response = await _authService.signUp(payload);
        _showCustomToast(response['statusMsg'] ?? 'Sign up successful', ToastStatus.success, icon: Icons.check_circle);
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerificationScreen(isEmail:isEmail,contact: emailOrMobile,),
            ),
          );
        }
        setState(() {
          isSignupRequestInProgress = false;
        });
      } catch (e) {
        _showCustomToast(e.toString(), ToastStatus.failure, icon: Icons.error);
        setState(() {
          isSignupRequestInProgress = false;
        });
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
                ToggleButtons(
                  isSelected: [isEmail, !isEmail],
                  onPressed: (int index) {
                    setState(() {
                      isEmail = index == 0;
                      emailOrMobileController.text = '';
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
                isSignupRequestInProgress ? 
                Column(
                  children: [
                    Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(color: AppColors.primary,),
                        height: 20,
                        width: 20,
                      ),
                    )
                  ],
                ):
                ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.background,
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size(double.infinity, 50), // full-width button
                  ),
                  child: const Text('Sign up'),
                ),
                const SizedBox(height: 12),
                isSignupRequestInProgress ? Container(height: 0,) : const Text('Or'),
                const SizedBox(height: 12),
                isSignupRequestInProgress ? Container(height: 0,) : TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
