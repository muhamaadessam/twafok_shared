import 'package:flutter/material.dart';
import 'package:twafok_shared/twafok_shared.dart';

import '../core/constants/app_theme.dart';

class AppThemeConfig {
  static void init() {
    // تحديث الألوان حسب اللي انت عايزه
    AppColors.updateColors(
      mainColor: const Color(0xff1E294D),  // لونك الأساسي
      orderProductColor: const Color(0xff33a9ff),
      errorColor: Colors.red,
      secondTextColor: const Color(0xff4A5E6D),
    );

    // أي تعديلات إضافية على الـ Theme
    // تقدر تعمل override لأي حاجة هنا
  }

  // Method لاختيار الـ Theme
  static ThemeData getTheme(Brightness brightness) {
    return brightness == Brightness.dark
        ? AppTheme.darkMode()
        : AppTheme.lightMode();
  }
}