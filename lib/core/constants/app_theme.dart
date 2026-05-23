import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData darkMode({
    AppBarTheme? appBarTheme,
    FloatingActionButtonThemeData? fabTheme,
    IconThemeData? iconTheme,
  }) {
    final base = ThemeData(
      useMaterial3: false,
      brightness: Brightness.dark,
      colorSchemeSeed: AppColors.mainColor.withValues(alpha: .8),
      scaffoldBackgroundColor: AppColors.darkScaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackgroundColor,
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.darkBackgroundColor,
      ),
      iconTheme: IconThemeData(color: AppColors.darkIconColor),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: AppColors.white),
        displayMedium: TextStyle(color: AppColors.white),
        displaySmall: TextStyle(color: AppColors.white),
        headlineLarge: TextStyle(color: AppColors.white),
        headlineMedium: TextStyle(color: AppColors.white),
        headlineSmall: TextStyle(color: AppColors.white),
        titleLarge: TextStyle(color: AppColors.white),
        titleMedium: TextStyle(color: AppColors.white),
        titleSmall: TextStyle(color: AppColors.white),
        bodyLarge: TextStyle(color: AppColors.white),
        bodyMedium: TextStyle(color: AppColors.white),
        bodySmall: TextStyle(color: AppColors.white),
        labelLarge: TextStyle(color: AppColors.white),
        labelMedium: TextStyle(color: AppColors.white),
        labelSmall: TextStyle(color: AppColors.white),
      ),
    );
    return base.copyWith(
      appBarTheme: appBarTheme ?? base.appBarTheme,
      floatingActionButtonTheme: fabTheme ?? base.floatingActionButtonTheme,
      iconTheme: iconTheme ?? base.iconTheme,
    );
  }

  static ThemeData lightMode({
    AppBarTheme? appBarTheme,
    FloatingActionButtonThemeData? fabTheme,
    IconThemeData? iconTheme,
  }) {
    final base = ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      colorSchemeSeed: AppColors.mainColor.withValues(alpha: .6),
      scaffoldBackgroundColor: AppColors.lightScaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightScaffoldBackgroundColor,
        shadowColor: AppColors.black.withValues(alpha: .25),
        elevation: 3,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.lightBackgroundColor,
      ),
      iconTheme: IconThemeData(color: AppColors.lightIconColor),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: AppColors.black),
        displayMedium: TextStyle(color: AppColors.black),
        displaySmall: TextStyle(color: AppColors.black),
        headlineLarge: TextStyle(color: AppColors.black),
        headlineMedium: TextStyle(color: AppColors.black),
        headlineSmall: TextStyle(color: AppColors.black),
        titleLarge: TextStyle(color: AppColors.black),
        titleMedium: TextStyle(color: AppColors.black),
        titleSmall: TextStyle(color: AppColors.black),
        bodyLarge: TextStyle(color: AppColors.black),
        bodyMedium: TextStyle(color: AppColors.black),
        bodySmall: TextStyle(color: AppColors.black),
        labelLarge: TextStyle(color: AppColors.black),
        labelMedium: TextStyle(color: AppColors.black),
        labelSmall: TextStyle(color: AppColors.black),
      ),
    );
    return base.copyWith(
      appBarTheme: appBarTheme ?? base.appBarTheme,
      floatingActionButtonTheme: fabTheme ?? base.floatingActionButtonTheme,
      iconTheme: iconTheme ?? base.iconTheme,
    );
  }
}
