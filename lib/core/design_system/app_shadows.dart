import 'package:flutter/material.dart';

/// Immutable shadow design tokens.
///
/// Provides consistent shadow values throughout the application
/// to create depth and visual hierarchy.
class AppShadows {
  AppShadows._();

  // ===== Elevation Levels =====
  
  /// No shadow.
  static const List<BoxShadow> none = [];
  
  /// Extra small shadow (elevation 1).
  static const List<BoxShadow> xs = [
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];
  
  /// Small shadow (elevation 2).
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x0F000000),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];
  
  /// Medium shadow (elevation 4).
  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];
  
  /// Large shadow (elevation 8).
  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];
  
  /// Extra large shadow (elevation 16).
  static const List<BoxShadow> xl = [
    BoxShadow(
      color: Color(0x1F000000),
      offset: Offset(0, 16),
      blurRadius: 32,
      spreadRadius: 0,
    ),
  ];

  // ===== Colored Shadows =====
  
  /// Primary color shadow.
  static List<BoxShadow> primary(Color color, {double opacity = 0.2}) => [
        BoxShadow(
          color: color.withOpacity(opacity),
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ];
  
  /// Error color shadow.
  static List<BoxShadow> error(Color color, {double opacity = 0.2}) => [
        BoxShadow(
          color: color.withOpacity(opacity),
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ];

  // ===== Common Shadow Values =====
  
  /// Shadow for cards.
  static const List<BoxShadow> card = sm;
  
  /// Shadow for buttons.
  static const List<BoxShadow> button = sm;
  
  /// Shadow for dialogs.
  static const List<BoxShadow> dialog = lg;
  
  /// Shadow for floating action buttons.
  static const List<BoxShadow> fab = md;
  
  /// Shadow for navigation bars.
  static const List<BoxShadow> navbar = xs;
}

/// Extension on [BoxShadow] for common operations.
extension BoxShadowExtension on BoxShadow {
  /// Creates a copy of this shadow with a new color.
  BoxShadow withColor(Color color) => BoxShadow(
        color: color,
        offset: offset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      );
  
  /// Creates a copy of this shadow with a new opacity.
  BoxShadow withOpacity(double opacity) => BoxShadow(
        color: color.withOpacity(opacity),
        offset: offset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      );
}
