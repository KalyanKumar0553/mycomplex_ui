import 'package:flutter/material.dart';
import 'package:mycomplex_ui/widgets/custom_text_field.dart';
import '../../../colors.dart';

class ContactDetailsTab extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final VoidCallback onSave;

  const ContactDetailsTab({
    Key? key,
    required this.emailController,
    required this.phoneController,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
            children: [
              CustomTextField(
                  labelText: 'Email',
                  controller: emailController,
                  isPassword: false,
                  helperText: 'Enter your Email',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                  labelText: 'Phone',
                  controller: phoneController,
                  isPassword: false,
                  helperText: 'Enter your Phone Number',
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Done', style: TextStyle(color: AppColors.background)),
              ),
            ],
          ),
      ),
      ),
    );
  }
}
