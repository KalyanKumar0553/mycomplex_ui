import 'package:flutter/material.dart';
import '../colors.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final Icon? prefixIcon;
  final String? helperText;

  const CustomTextField({super.key, 
    required this.labelText,
    required this.controller,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.validator,
    this.prefixIcon,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: labelText,
          helperText: helperText,
          filled: true,
          fillColor: AppColors.inputFillColor,
          labelStyle: const TextStyle(color: AppColors.inputLabelColor),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          prefixIcon: prefixIcon,
        ),
        style: const TextStyle(color: AppColors.textColor),
        validator: validator,
      ),
    );
  }
}