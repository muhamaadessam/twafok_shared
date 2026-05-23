import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twafok_shared/twafok_shared.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit(bool isDark)
      : super(
          AppThemeState(
            isDark: isDark,
            theme: isDark ? AppTheme.darkMode() : AppTheme.lightMode(),
          ),
        );

  static AppThemeCubit get(BuildContext context) =>
      context.read<AppThemeCubit>();

  Future<void> toggleTheme() async {
    final newIsDark = !state.isDark;

    // Save to cache
    await CacheHelper.put(key: 'isDark', value: newIsDark);

    // Update TwafokConfig
    TwafokConfig.setThemeMode(newIsDark ? ThemeMode.dark : ThemeMode.light);

    emit(
      AppThemeState(
        isDark: newIsDark,
        theme: newIsDark ? AppTheme.darkMode() : AppTheme.lightMode(),
      ),
    );
  }

  // Method to change theme mode (system/light/dark)
  Future<void> setThemeMode(ThemeMode mode) async {
    final isDark = mode == ThemeMode.dark;

    await CacheHelper.put(key: 'themeMode', value: mode.index);
    await CacheHelper.put(key: 'isDark', value: isDark);

    TwafokConfig.setThemeMode(mode);

    emit(
      AppThemeState(
        isDark: isDark,
        theme: isDark ? AppTheme.darkMode() : AppTheme.lightMode(),
        themeMode: mode,
      ),
    );
  }

  // Method to get current theme mode
  ThemeMode get currentThemeMode {
    if (state.themeMode == ThemeMode.system) {
      return CacheHelper.get(key: 'themeMode') ?? false
          ? ThemeMode.dark
          : ThemeMode.light;
    }
    return state.themeMode;
  }
}
