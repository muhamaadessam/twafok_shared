import 'package:flutter/material.dart';

import '../extensions/context_extension.dart';
import 'hex_color.dart';

class AppColors {
  static Color mainColor = const Color(0xff1E294D);

  static Color homeBackgroundColor(BuildContext context) =>
      context.isDarkMode ? const Color(0xff272A2F) : Colors.white;

  static Color customBackgroundColor(BuildContext context) =>
      context.isDarkMode ? const Color(0xff272A2F) : const Color(0xffF2F4F8);

  static Color deepBackgroundColor(BuildContext context) =>
      context.isDarkMode ? const Color(0xff191D23) : const Color(0xfff1f1f1);

  static Color appBarColor(BuildContext context) =>
      context.isDarkMode ? const Color(0xff191D23) : Colors.white;

  static Color containerBackgroundColor(BuildContext context) =>
      context.isDarkMode ? const Color(0xff191D23) : Colors.white;

  static Color orderProductColor = const Color(0xff33a9ff);

  static Color textColor = Colors.black;
  static Color secondTextColor = HexColor('#4A5E6D');
  static Color borderColor = Colors.black.withValues(alpha: .25);

  static Color reverseTextColor(BuildContext context) =>
      context.isDarkMode ? Colors.white : Colors.black;
  static Color errorColor = Colors.red;
}

ThemeData darkMode() => ThemeData(
      useMaterial3: false,
      brightness: Brightness.dark,
      colorSchemeSeed: const Color(0xff1E294D).withValues(alpha: .8),
      scaffoldBackgroundColor: const Color(0xff272A2F),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff191D23),
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xff191D23),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Colors.white),
        displayMedium: TextStyle(color: Colors.white),
        displaySmall: TextStyle(color: Colors.white),
        headlineLarge: TextStyle(color: Colors.white),
        headlineMedium: TextStyle(color: Colors.white),
        headlineSmall: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        titleSmall: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Colors.white),
        labelLarge: TextStyle(color: Colors.white),
        labelMedium: TextStyle(color: Colors.white),
        labelSmall: TextStyle(color: Colors.white),
      ),
    );

ThemeData lightMode() => ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      colorSchemeSeed: const Color(0xff1E294D).withValues(alpha: .6),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        shadowColor: Colors.black.withValues(alpha: .25),
        elevation: 3,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Colors.black),
        displayMedium: TextStyle(color: Colors.black),
        displaySmall: TextStyle(color: Colors.black),
        headlineLarge: TextStyle(color: Colors.black),
        headlineMedium: TextStyle(color: Colors.black),
        headlineSmall: TextStyle(color: Colors.black),
        titleLarge: TextStyle(color: Colors.black),
        titleMedium: TextStyle(color: Colors.black),
        titleSmall: TextStyle(color: Colors.black),
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
        bodySmall: TextStyle(color: Colors.black),
        labelLarge: TextStyle(color: Colors.black),
        labelMedium: TextStyle(color: Colors.black),
        labelSmall: TextStyle(color: Colors.black),
      ),
    );
