import 'package:flutter/material.dart';

/// Immutable typography design tokens.
///
/// Provides consistent typography values throughout the application
/// to ensure readability and visual hierarchy.
class AppTypography {
  AppTypography._();

  // ===== Font Weights =====
  
  /// Thin font weight (100).
  static const FontWeight thin = FontWeight.w100;
  
  /// Extra light font weight (200).
  static const FontWeight extraLight = FontWeight.w200;
  
  /// Light font weight (300).
  static const FontWeight light = FontWeight.w300;
  
  /// Regular font weight (400).
  static const FontWeight regular = FontWeight.w400;
  
  /// Medium font weight (500).
  static const FontWeight medium = FontWeight.w500;
  
  /// Semi-bold font weight (600).
  static const FontWeight semiBold = FontWeight.w600;
  
  /// Bold font weight (700).
  static const FontWeight bold = FontWeight.w700;
  
  /// Extra bold font weight (800).
  static const FontWeight extraBold = FontWeight.w800;
  
  /// Black font weight (900).
  static const FontWeight black = FontWeight.w900;

  // ===== Font Sizes =====
  
  /// Display large font size (57sp).
  static const double displayLarge = 57.0;
  
  /// Display medium font size (45sp).
  static const double displayMedium = 45.0;
  
  /// Display small font size (36sp).
  static const double displaySmall = 36.0;
  
  /// Headline large font size (32sp).
  static const double headlineLarge = 32.0;
  
  /// Headline medium font size (28sp).
  static const double headlineMedium = 28.0;
  
  /// Headline small font size (24sp).
  static const double headlineSmall = 24.0;
  
  /// Title large font size (22sp).
  static const double titleLarge = 22.0;
  
  /// Title medium font size (16sp).
  static const double titleMedium = 16.0;
  
  /// Title small font size (14sp).
  static const double titleSmall = 14.0;
  
  /// Body large font size (16sp).
  static const double bodyLarge = 16.0;
  
  /// Body medium font size (14sp).
  static const double bodyMedium = 14.0;
  
  /// Body small font size (12sp).
  static const double bodySmall = 12.0;
  
  /// Label large font size (14sp).
  static const double labelLarge = 14.0;
  
  /// Label medium font size (12sp).
  static const double labelMedium = 12.0;
  
  /// Label small font size (11sp).
  static const double labelSmall = 11.0;

  // ===== Letter Spacing =====
  
  /// Tight letter spacing (-0.5).
  static const double letterSpacingTight = -0.5;
  
  /// Normal letter spacing (0).
  static const double letterSpacingNormal = 0;
  
  /// Wide letter spacing (0.5).
  static const double letterSpacingWide = 0.5;
  
  /// Extra wide letter spacing (1.0).
  static const double letterSpacingExtraWide = 1.0;

  // ===== Line Heights =====
  
  /// Tight line height (1.0).
  static const double lineHeightTight = 1.0;
  
  /// Normal line height (1.5).
  static const double lineHeightNormal = 1.5;
  
  /// Relaxed line height (1.75).
  static const double lineHeightRelaxed = 1.75;
  
  /// Loose line height (2.0).
  static const double lineHeightLoose = 2.0;
}

/// Extension on [BuildContext] to access theme typography.
extension TypographyExtension on BuildContext {
  /// Access the theme's text theme.
  TextTheme get textTheme => Theme.of(this).textTheme;
  
  /// Access the theme's primary text style.
  TextStyle get primaryTextStyle => textTheme.bodyLarge!;
  
  /// Access the theme's secondary text style.
  TextStyle get secondaryTextStyle => textTheme.bodyMedium!;
}
