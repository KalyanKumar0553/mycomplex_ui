import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mycomplex_ui/colors.dart';
import 'package:mycomplex_ui/screens/navigation/header.dart';
import 'package:mycomplex_ui/widgets/custom_text_field.dart';
import 'package:mycomplex_ui/widgets/custom_toast_msg.dart';

// Replace this with your API call function
Future<void> updatePassword(String currentPassword, String newPassword) async {
  // Simulating an API call
  await Future.delayed(Duration(seconds: 2));
  // Add your actual API call code here
  print("Password updated: $newPassword");
}

class ChangePasswordScreen extends StatefulWidget {

  final String userID;
  final String selectedApartmentID;

  const ChangePasswordScreen({Key? key, required this.userID,required this.selectedApartmentID}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.background),
        title: Text('Change Password', style: const TextStyle(color: AppColors.background, overflow: TextOverflow.ellipsis)),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: AppColors.background),
            padding: EdgeInsets.only(right: 10),
            onPressed: () {
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
            },
          ),
        ],
        ),
        body: Container(
          child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              color: AppColors.background,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CustomTextField(
                            labelText: 'Current password',
                            controller: _currentPasswordController,
                            isPassword: true,
                            validator: passwordValidator,
                            prefixIcon: const Icon(Icons.password),
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                            labelText: 'New password',
                            controller: _newPasswordController,
                            isPassword: true,
                            validator: passwordValidator,
                            prefixIcon: const Icon(Icons.password),
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                            labelText: 'Confirm password',
                            controller: _confirmPasswordController,
                            isPassword: true,
                            validator: passwordValidator,
                            prefixIcon: const Icon(Icons.password),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                            String currentPassword = _currentPasswordController.text;
                            String newPassword = _newPasswordController.text;
                            String confirmPassword = _confirmPasswordController.text;
                            if (_formKey.currentState!.validate()) {
                                    
                            }
                        },
                        style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('Done', style: TextStyle(color: AppColors.background)),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
            ),
          ),
        ),
      )
    );
  }
}
