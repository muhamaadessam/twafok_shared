/// Immutable spacing design tokens.
///
/// Provides consistent spacing values throughout the application
/// to ensure visual harmony and rhythm.
class AppSpacing {
  AppSpacing._();

  // ===== Base Spacing Unit =====

  /// Base spacing unit (4px).
  static const double unit = 4.0;

  // ===== Scale =====

  /// Extra extra small spacing (4px).
  static const double xxs = unit;

  /// Extra small spacing (8px).
  static const double xs = unit * 2;

  /// Small spacing (12px).
  static const double sm = unit * 3;

  /// Medium spacing (16px).
  static const double md = unit * 4;

  /// Large spacing (24px).
  static const double lg = unit * 6;

  /// Extra large spacing (32px).
  static const double xl = unit * 8;

  /// Extra extra large spacing (48px).
  static const double xxl = unit * 12;

  /// Huge spacing (64px).
  static const double huge = unit * 16;

  // ===== Common Spacing Values =====

  /// Padding for cards and containers.
  static const double cardPadding = md;

  /// Padding for sections.
  static const double sectionPadding = lg;

  /// Padding for pages.
  static const double pagePadding = lg;

  /// Gap between inline elements.
  static const double inlineGap = xs;

  /// Gap between stacked elements.
  static const double stackGap = sm;

  /// Gap between grid items.
  static const double gridGap = md;
}

/// Extension on [double] to convert spacing units to pixels.
extension SpacingExtension on double {
  /// Converts spacing units to pixels.
  double get toPx => this * AppSpacing.unit;
}
