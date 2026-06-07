import 'package:flutter/material.dart';

/// Immutable border radius design tokens.
///
/// Provides consistent border radius values throughout the application
/// to ensure visual consistency.
class AppRadius {
  AppRadius._();

  // ===== Base Radius Unit =====
  
  /// Base radius unit (4px).
  static const double unit = 4.0;

  // ===== Scale =====
  
  /// No radius (sharp corners).
  static const double none = 0;
  
  /// Extra extra small radius (2px).
  static const double xxs = unit / 2;
  
  /// Extra small radius (4px).
  static const double xs = unit;
  
  /// Small radius (8px).
  static const double sm = unit * 2;
  
  /// Medium radius (12px).
  static const double md = unit * 3;
  
  /// Large radius (16px).
  static const double lg = unit * 4;
  
  /// Extra large radius (24px).
  static const double xl = unit * 6;
  
  /// Extra extra large radius (32px).
  static const double xxl = unit * 8;
  
  /// Full radius (circular).
  static const double full = 9999;

  // ===== Common Radius Values =====
  
  /// Radius for buttons.
  static const double button = lg;
  
  /// Radius for cards.
  static const double card = lg;
  
  /// Radius for dialogs.
  static const double dialog = xl;
  
  /// Radius for input fields.
  static const double input = md;
  
  /// Radius for chips.
  static const double chip = full;
  
  /// Radius for avatars.
  static const double avatar = full;
}

/// Extension on [double] to create [Radius] objects.
extension RadiusExtension on double {
  /// Creates a circular [Radius] with this value.
  Radius get circular => Radius.circular(this);
  
  /// Creates an elliptical [Radius] with this x value.
  Radius get elliptical => Radius.elliptical(this, this);
}
