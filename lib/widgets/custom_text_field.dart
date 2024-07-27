import 'package:flutter/material.dart';
import '../colors.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final Icon? prefixIcon;

  const CustomTextField({super.key, 
    required this.labelText,
    required this.controller,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.validator,
    this.prefixIcon,
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
          filled: true,
          fillColor: AppColors.inputFillColor,
          labelStyle: TextStyle(color: Colors.grey.shade600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          prefixIcon: prefixIcon,
        ),
        style: const TextStyle(color: Colors.black38),
        validator: validator,
      ),
    );
  }
}
