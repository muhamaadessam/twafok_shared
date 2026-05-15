part of 'app_theme_cubit.dart';

class AppThemeState {
  final bool isDark;
  final ThemeData theme;
  final ThemeMode themeMode;

  const AppThemeState({
    required this.isDark,
    required this.theme,
    this.themeMode = ThemeMode.system,
  });

  AppThemeState copyWith({
    bool? isDark,
    ThemeData? theme,
    ThemeMode? themeMode,
  }) {
    return AppThemeState(
      isDark: isDark ?? this.isDark,
      theme: theme ?? this.theme,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}