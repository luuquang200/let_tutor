import 'package:flutter/material.dart';

class CustomTextStyle {
  static bool isLightTheme = true;

  static TextStyle get headlineMedium {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: isLightTheme ? Colors.black : Colors.white,
    );
  }

  static TextStyle get headlineLarge {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: isLightTheme ? Colors.black : Colors.white,
    );
  }

  static TextStyle get headlineLargeWhite {
    return const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );
  }

  static TextStyle get bodyRegular {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: isLightTheme ? Colors.black : Colors.white,
    );
  }

  static TextStyle get boldRegular {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: isLightTheme ? Colors.black : Colors.white,
    );
  }

  static TextStyle get topHeadline {
    return TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: isLightTheme ? const Color(0xFF0058C6) : Colors.white);
  }

  static TextStyle get titleLarge {
    return TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: isLightTheme ? Colors.black : Colors.white,
    );
  }

  static TextStyle get initialNameOfTutor {
    return TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: isLightTheme ? Colors.black : Colors.white,
    );
  }

  static TextStyle get headlineOpps {
    return TextStyle(
      fontSize: 44,
      fontWeight: FontWeight.w500,
      color: isLightTheme ? Colors.black : Color.fromARGB(255, 98, 95, 95),
    );
  }

  static TextStyle get timer {
    return TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: isLightTheme
            ? const Color.fromARGB(255, 255, 255, 0)
            : Colors.white);
  }

  static TextStyle get bodyLarge {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: isLightTheme ? Colors.black : Colors.white,
    );
  }

  static TextStyle getHeadlineMedium(bool isLightTheme) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: isLightTheme ? Colors.black : Colors.white,
    );
  }

  static TextStyle getHeadlineLarge(bool isLightTheme) {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: isLightTheme ? Colors.black : Colors.white,
    );
  }

  static TextStyle getTopHeadline(bool isLightTheme) {
    return TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: isLightTheme ? const Color(0xFF0058C6) : Colors.white,
    );
  }
}
