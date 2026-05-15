import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twafok_shared/core/core.dart';

part 'app_theme_state.dart';


class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit(bool isDark)
      : super(
          AppThemeState(
            isDark: isDark,
            theme: isDark ? darkMode() : lightMode(),
          ),
        );

  static AppThemeCubit get(BuildContext context) =>
      context.read<AppThemeCubit>();

  Future<void> toggleTheme() async {
    final newIsDark = !state.isDark;
    await CacheHelper.put(key: 'isDark', value: newIsDark);

    emit(
      AppThemeState(
        isDark: newIsDark,
        theme: newIsDark ? darkMode() : lightMode(),
      ),
    );
  }
}
