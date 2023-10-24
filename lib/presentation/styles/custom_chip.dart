import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color labelColor;
  final double fontSize;

  const CustomChip({
    super.key,
    required this.label,
    this.backgroundColor = const Color(0xFFDDEAFF),
    this.labelColor = const Color(0xFF0058C6),
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: backgroundColor,
      side: BorderSide.none,
      label: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          color: labelColor,
        ),
      ),
    );
  }
}
