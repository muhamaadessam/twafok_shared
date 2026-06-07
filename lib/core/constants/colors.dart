import 'package:flutter/material.dart';

import '../design_system/design_system.dart' as ds;

/// Legacy color class for backward compatibility.
///
/// This class now delegates to the immutable design system tokens.
/// New code should use [AppColors] from the design system directly.
@Deprecated('Use AppColors from design_system instead')
class LegacyColors {
  LegacyColors._();

  // ===== Theme Based Colors (for backward compatibility) =====

  static Color homeBackgroundColor(BuildContext context) => _isDarkMode(context)
      ? ds.AppColors.darkScaffold
      : ds.AppColors.lightScaffold;

  static Color customBackgroundColor(BuildContext context) =>
      _isDarkMode(context)
          ? ds.AppColors.darkScaffold
          : ds.AppColors.lightBackground;

  static Color deepBackgroundColor(BuildContext context) => _isDarkMode(context)
      ? ds.AppColors.darkBackground
      : ds.AppColors.lightBackground;

  static Color appBarColor(BuildContext context) =>
      _isDarkMode(context) ? ds.AppColors.darkBackground : ds.AppColors.white;

  static Color containerBackgroundColor(BuildContext context) =>
      _isDarkMode(context) ? ds.AppColors.darkBackground : ds.AppColors.white;

  static Color textColor(BuildContext context) => ds.AppColors.white;

  static Color reverseTextColor(BuildContext context) =>
      _isDarkMode(context) ? ds.AppColors.white : ds.AppColors.black;

  static Color iconColor(BuildContext context) =>
      _isDarkMode(context) ? ds.AppColors.darkIcon : ds.AppColors.lightIcon;

  // ===== Helpers =====

  static bool _isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}

/// Re-export of the new AppColors for backward compatibility.
///
/// New code should import from 'package:essam_shared/core/design_system/design_system.dart'
/// instead of using this file.
class AppColors {
  AppColors._();

  // ===== Re-export design system colors =====

  static const Color primary = ds.AppColors.primary;
  static const Color secondary = ds.AppColors.secondary;
  static const Color success = ds.AppColors.success;
  static const Color error = ds.AppColors.error;
  static const Color warning = ds.AppColors.warning;
  static const Color info = ds.AppColors.info;
  static const Color white = ds.AppColors.white;
  static const Color black = ds.AppColors.black;
  static const Color transparent = ds.AppColors.transparent;
  static const Color textSecondary = ds.AppColors.textSecondary;
  static const Color border = ds.AppColors.border;
  static const Color darkScaffold = ds.AppColors.darkScaffold;
  static const Color darkBackground = ds.AppColors.darkBackground;
  static const Color darkIcon = ds.AppColors.darkIcon;
  static const Color lightScaffold = ds.AppColors.lightScaffold;
  static const Color lightBackground = ds.AppColors.lightBackground;
  static const Color lightIcon = ds.AppColors.lightIcon;

  // ===== Legacy color name aliases for backward compatibility =====

  @Deprecated('Use primary instead')
  static const Color mainColor = primary;

  @Deprecated('Use textSecondary instead')
  static const Color secondTextColor = textSecondary;

  @Deprecated('Use darkScaffold instead')
  static const Color darkScaffoldBackgroundColor = darkScaffold;

  @Deprecated('Use lightScaffold instead')
  static const Color lightScaffoldBackgroundColor = lightScaffold;

  @Deprecated('Use darkBackground instead')
  static const Color darkBackgroundColor = darkBackground;

  @Deprecated('Use lightBackground instead')
  static const Color lightBackgroundColor = lightBackground;

  @Deprecated('Use darkIcon instead')
  static const Color darkIconColor = darkIcon;

  @Deprecated('Use lightIcon instead')
  static const Color lightIconColor = lightIcon;

  @Deprecated('Use error instead')
  static const Color errorColor = error;

  @Deprecated('Use success instead')
  static const Color successColor = success;

  // ===== Legacy method names for backward compatibility =====

  static Color homeBackgroundColor(BuildContext context) =>
      LegacyColors.homeBackgroundColor(context);

  static Color customBackgroundColor(BuildContext context) =>
      LegacyColors.customBackgroundColor(context);

  static Color deepBackgroundColor(BuildContext context) =>
      LegacyColors.deepBackgroundColor(context);

  static Color appBarColor(BuildContext context) =>
      LegacyColors.appBarColor(context);

  static Color containerBackgroundColor(BuildContext context) =>
      LegacyColors.containerBackgroundColor(context);

  static Color textColor(BuildContext context) =>
      LegacyColors.textColor(context);

  static Color reverseTextColor(BuildContext context) =>
      LegacyColors.reverseTextColor(context);

  static Color iconColor(BuildContext context) =>
      LegacyColors.iconColor(context);

  // ===== Legacy updateColors method for backward compatibility =====
  @Deprecated('Colors are now immutable. Use EssamSharedConfig instead.')
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
    // No-op - colors are now immutable
    // This method is kept for backward compatibility only
  }
}
