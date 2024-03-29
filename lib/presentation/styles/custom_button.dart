import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16),
          ),
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xFF0058C6)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyElevatedButton extends StatelessWidget {
  final String text;
  final double height;
  final double radius;
  final double width;
  final double textSize;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  const MyElevatedButton({
    Key? key,
    required this.text,
    required this.height,
    required this.radius,
    this.width = double.infinity,
    this.textSize = 20.0,
    required this.onPressed,
    this.color = const Color(0xFF0058C6),
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // updated
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor, // updated
          fontSize: textSize,
        ),
      ),
    );
  }
}

class MyOutlineButton extends StatelessWidget {
  final String text;
  final double height;
  final double radius;
  final double width;
  final double textSize;
  final VoidCallback onPressed;
  final Color color;

  const MyOutlineButton({
    Key? key,
    required this.text,
    required this.height,
    required this.radius,
    this.width = double.infinity,
    this.textSize = 20.0,
    required this.onPressed,
    this.color = const Color(0xFF0058C6),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color, width: 1),
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: textSize,
        ),
      ),
    );
  }
}
