import 'package:flutter/material.dart';
import 'hex_color.dart';

class AppColors {
  // الألوان الثابتة (زي ما هي عندك)
  static Color mainColor = const Color(0xff1E294D);
  static Color secondaryColor = const Color(0xff1E294D);
  static Color orderProductColor = const Color(0xff33a9ff);
  static Color errorColor = Colors.red;

  // الألوان اللي بتتغير حسب mode (جوه package)
  static Color homeBackgroundColor(BuildContext context) =>
      _isDarkMode(context) ? const Color(0xff272A2F) : Colors.white;

  static Color customBackgroundColor(BuildContext context) =>
      _isDarkMode(context) ? const Color(0xff272A2F) : const Color(0xffF2F4F8);

  static Color deepBackgroundColor(BuildContext context) =>
      _isDarkMode(context) ? const Color(0xff191D23) : const Color(0xfff1f1f1);

  static Color appBarColor(BuildContext context) =>
      _isDarkMode(context) ? const Color(0xff191D23) : Colors.white;

  static Color containerBackgroundColor(BuildContext context) =>
      _isDarkMode(context) ? const Color(0xff191D23) : Colors.white;

  static Color textColor(BuildContext context) =>
      _isDarkMode(context) ? Colors.white : Colors.black;

  static Color secondTextColor = HexColor('#4A5E6D');
  static Color borderColor = Colors.black.withValues(alpha: .25);

  static Color reverseTextColor(BuildContext context) =>
      _isDarkMode(context) ? Colors.white : Colors.black;

  // Helper method
  static bool _isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // Method لتحديث الألوان من الـ App
  static void updateColors({
    Color? mainColor,
    Color? secondaryColor,
    Color? orderProductColor,
    Color? errorColor,
    Color? secondTextColor,
    Color? borderColor,
    Map<String, Color>? customColors,
  }) {
    if (mainColor != null) AppColors.mainColor = mainColor;
    if (secondaryColor != null) AppColors.secondaryColor = secondaryColor;
    if (orderProductColor != null) AppColors.orderProductColor = orderProductColor;
    if (errorColor != null) AppColors.errorColor = errorColor;
    if (secondTextColor != null) AppColors.secondTextColor = secondTextColor;
    if (borderColor != null) AppColors.borderColor = borderColor;
  }
}