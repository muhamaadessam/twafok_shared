import 'package:flutter/material.dart';

import 'hex_color.dart';

class AppColors {
  AppColors._();

  // ===== Static Fixed Colors =====

  static Color defaultMainColor = HexColor('#1E294D');
  static Color defaultSecondaryColor = HexColor('#1E294D');
  static Color defaultSuccessColor = HexColor('#1E294D');

  // ===== Mutable Colors =====

  static Color mainColor = HexColor('#1E294D');
  static Color secondaryColor = HexColor('#1E294D');
  static Color successColor = HexColor('#1E294D');

  static Color errorColor = Colors.red;

  static Color secondTextColor = HexColor('#4A5E6D');
  static Color borderColor = Colors.black.withValues(alpha: .25);

  // ===== Theme Based Colors =====

  static Color homeBackgroundColor(BuildContext context) =>
      _isDarkMode(context) ? HexColor('#272A2F') : HexColor('#FFFFFF');

  static Color customBackgroundColor(BuildContext context) =>
      _isDarkMode(context) ? HexColor('#272A2F') : HexColor('#F2F4F8');

  static Color deepBackgroundColor(BuildContext context) =>
      _isDarkMode(context) ? HexColor('#191D23') : HexColor('#F1F1F1');

  static Color appBarColor(BuildContext context) =>
      _isDarkMode(context) ? HexColor('#191D23') : HexColor('#FFFFFF');

  static Color containerBackgroundColor(BuildContext context) =>
      _isDarkMode(context) ? HexColor('#191D23') : HexColor('#FFFFFF');

  static Color textColor(BuildContext context) =>
      _isDarkMode(context) ? HexColor('#FFFFFF') : HexColor('#000000');

  static Color reverseTextColor(BuildContext context) =>
      _isDarkMode(context) ? HexColor('#000000') : HexColor('#FFFFFF');

  // ===== Helpers =====

  static bool _isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  // ===== Dynamic Update =====

  static void updateColors({
    Color? mainColor,
    Color? secondaryColor,
    Color? successColor,
    Color? errorColor,
    Color? secondTextColor,
    Color? borderColor,
  }) {
    if (mainColor != null) {
      AppColors.mainColor = mainColor;
    }

    if (secondaryColor != null) {
      AppColors.secondaryColor = secondaryColor;
    }

    if (errorColor != null) {
      AppColors.errorColor = errorColor;
    }

    if (secondTextColor != null) {
      AppColors.secondTextColor = secondTextColor;
    }

    if (borderColor != null) {
      AppColors.borderColor = borderColor;
    }

    if (successColor != null) {
      AppColors.successColor = successColor;
    }
  }
}
