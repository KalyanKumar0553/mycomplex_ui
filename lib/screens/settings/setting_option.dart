import 'package:flutter/material.dart';
import '../../colors.dart';

class SettingOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingOption({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textColor),
      title: Text(title, style: const TextStyle(color: AppColors.textColor)),
      onTap: onTap,
    );
  }
}