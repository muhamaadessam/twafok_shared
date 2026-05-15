part of 'app_theme_cubit.dart';

@immutable
class AppThemeState {
  const AppThemeState({
    required this.theme,
    required this.isDark,
  });

  final ThemeData theme;
  final bool isDark;
}
