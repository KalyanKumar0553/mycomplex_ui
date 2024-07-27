import 'package:flutter/material.dart';

enum ToastStatus { success, failure, warning }

class CustomToastMsg extends StatelessWidget {
  final String message;
  final IconData icon;
  final ToastStatus status;

  const CustomToastMsg({super.key, 
    required this.message,
    this.icon = Icons.info,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;

    switch (status) {
      case ToastStatus.success:
        backgroundColor = Colors.green;
        break;
      case ToastStatus.failure:
        backgroundColor = Colors.red;
        break;
      case ToastStatus.warning:
        backgroundColor = Colors.orange;
        break;
      default:
        backgroundColor = const Color(0xFFAD5472);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
