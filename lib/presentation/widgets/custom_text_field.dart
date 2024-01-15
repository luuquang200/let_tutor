import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double height;
  final TextEditingController controller;
  final double radius;
  final bool enableEdit;

  const CustomTextField({
    Key? key,
    required this.height,
    required this.controller,
    required this.radius,
    this.enableEdit = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: TextField(
        controller: controller,
        enabled: enableEdit,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}
