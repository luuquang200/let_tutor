import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

class AppTheme extends ChangeNotifier {
  static bool isLightTheme = true;

  void toggleTheme() {
    isLightTheme = !isLightTheme;
    CustomTextStyle.isLightTheme = isLightTheme;
    notifyListeners();
  }

  static IconThemeData get iconTheme {
    if (isLightTheme) {
      return const IconThemeData(
        color: Color(0xFF0058C6),
      );
    } else {
      return const IconThemeData(
        color: Colors.white,
      );
    }
  }

  static BorderSide get borderSide {
    if (isLightTheme) {
      return const BorderSide(
        color: Color(0xFF0058C6),
        width: 1,
      );
    } else {
      return const BorderSide(
        color: Colors.white,
        width: 1,
      );
    }
  }

  static Color get primaryColor {
    if (isLightTheme) {
      return const Color(0xFF0058C6);
    } else {
      return Colors.white;
    }
  }
}
