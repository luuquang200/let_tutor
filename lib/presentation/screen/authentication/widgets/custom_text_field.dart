import 'package:flutter/material.dart';

class CustomTextFieldAuth extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final VoidCallback? onPressedHidePass;
  final ValueChanged<String> onChanged;
  final String? errorText;
  final bool showIcon;
  final IconData? icon;

  const CustomTextFieldAuth({
    Key? key,
    required this.hintText,
    required this.controller,
    this.obscureText,
    this.onPressedHidePass,
    required this.onChanged,
    this.errorText,
    this.showIcon = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFFB0B0B0),
        ),
        prefixIcon: icon != null
            ? Icon(icon, size: 26, color: Color(0xFF0058C6))
            : null,
        suffixIcon: showIcon
            ? IconButton(
                icon: Icon(
                  obscureText ?? false
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: onPressedHidePass,
              )
            : null,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        errorText: errorText,
      ),
    );
  }
}
