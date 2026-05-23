import 'package:flutter/material.dart';

import 'hex_color.dart';

class AppColors {
  AppColors._();

  // ===== Mutable Colors =====

  static Color mainColor = HexColor('#1E294D');
  static Color secondaryColor = HexColor('#1E294D');
  static Color successColor = HexColor('#1E294D');
  static Color errorColor = HexColor('#E74C3C');
  static Color secondTextColor = HexColor('#4A5E6D');
  static Color borderColor = HexColor('#F1F1F1');
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color transparent = Colors.transparent;
  static Color darkScaffoldBackgroundColor = HexColor('#272A2F');
  static Color lightScaffoldBackgroundColor = Colors.white;
  static Color darkBackgroundColor = HexColor('#191D23');
  static Color lightBackgroundColor = HexColor('#F1F1F1');
  static Color lightIconColor = HexColor('#4A5E6D');
  static Color darkIconColor = HexColor('#4A5E6D');

  // ===== Theme Based Colors =====

  static Color homeBackgroundColor(BuildContext context) => _isDarkMode(context)
      ? darkScaffoldBackgroundColor
      : lightScaffoldBackgroundColor;

  static Color customBackgroundColor(BuildContext context) =>
      _isDarkMode(context) ? darkScaffoldBackgroundColor : lightBackgroundColor;

  static Color deepBackgroundColor(BuildContext context) =>
      _isDarkMode(context) ? darkBackgroundColor : lightBackgroundColor;

  static Color appBarColor(BuildContext context) =>
      _isDarkMode(context) ? darkBackgroundColor : white;

  static Color containerBackgroundColor(BuildContext context) =>
      _isDarkMode(context) ? darkBackgroundColor : white;

  static Color textColor(BuildContext context) =>
      _isDarkMode(context) ? white : white;

  static Color reverseTextColor(BuildContext context) =>
      _isDarkMode(context) ? white : black;

  static Color iconColor(BuildContext context) =>
      _isDarkMode(context) ? darkIconColor : lightIconColor;

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
    Color? lightScaffoldBackgroundColor,
    Color? darkScaffoldBackgroundColor,
    Color? lightIconColor,
    Color? darkIconColor,
    Color? lightBackgroundColor,
    Color? darkBackgroundColor,
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

    if (lightScaffoldBackgroundColor != null) {
      AppColors.lightScaffoldBackgroundColor = lightScaffoldBackgroundColor;
    }

    if (darkScaffoldBackgroundColor != null) {
      AppColors.darkScaffoldBackgroundColor = darkScaffoldBackgroundColor;
    }

    if (lightIconColor != null) {
      AppColors.lightIconColor = lightIconColor;
    }

    if (darkIconColor != null) {
      AppColors.darkIconColor = darkIconColor;
    }

    if (lightBackgroundColor != null) {
      AppColors.lightBackgroundColor = lightBackgroundColor;
    }

    if (darkBackgroundColor != null) {
      AppColors.darkBackgroundColor = darkBackgroundColor;
    }
  }
}
