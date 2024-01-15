import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    super.key,
    required String message,
    required IconData icon,
    required Color backgroundColor,
  }) : super(
          showCloseIcon: true,
          content: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8.0),
              Text(message),
            ],
          ),
          backgroundColor: backgroundColor,
        );
}
