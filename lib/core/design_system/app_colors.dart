import 'package:flutter/material.dart';

/// Immutable color design tokens for the application.
///
/// All colors are defined as constants to ensure immutability and
/// prevent runtime color changes that could cause visual inconsistencies.
class AppColors {
  AppColors._();

  // ===== Primary Colors =====
  
  /// The primary brand color of the application.
  static const Color primary = Color(0xFF1E294D);
  
  /// The secondary brand color.
  static const Color secondary = Color(0xFF1E294D);
  
  /// Success state color (e.g., for successful operations).
  static const Color success = Color(0xFF4CAF50);
  
  /// Error state color (e.g., for errors and failures).
  static const Color error = Color(0xFFE74C3C);
  
  /// Warning state color.
  static const Color warning = Color(0xFFFFC107);
  
  /// Information state color.
  static const Color info = Color(0xFF2196F3);

  // ===== Neutral Colors =====
  
  /// Pure white color.
  static const Color white = Color(0xFFFFFFFF);
  
  /// Pure black color.
  static const Color black = Color(0xFF000000);
  
  /// Transparent color.
  static const Color transparent = Color(0x00000000);
  
  /// Secondary text color for less prominent text.
  static const Color textSecondary = Color(0xFF4A5E6D);
  
  /// Border color for outlines and dividers.
  static const Color border = Color(0xFFF1F1F1);
  
  /// Light gray for backgrounds and surfaces.
  static const Color gray100 = Color(0xFFF5F5F5);
  
  /// Medium gray for disabled states.
  static const Color gray300 = Color(0xFFE0E0E0);
  
  /// Dark gray for text and icons.
  static const Color gray600 = Color(0xFF757575);
  
  /// Very dark gray for high contrast text.
  static const Color gray900 = Color(0xFF212121);

  // ===== Dark Theme Colors =====
  
  /// Scaffold background color for dark theme.
  static const Color darkScaffold = Color(0xFF272A2F);
  
  /// Background color for dark theme.
  static const Color darkBackground = Color(0xFF191D23);
  
  /// Icon color for dark theme.
  static const Color darkIcon = Color(0xFF4A5E6D);

  // ===== Light Theme Colors =====
  
  /// Scaffold background color for light theme.
  static const Color lightScaffold = Color(0xFFFFFFFF);
  
  /// Background color for light theme.
  static const Color lightBackground = Color(0xFFF1F1F1);
  
  /// Icon color for light theme.
  static const Color lightIcon = Color(0xFF4A5E6D);

  // ===== Semantic Colors =====
  
  /// Color for user-related elements.
  static const Color user = Color(0xFF2196F3);
  
  /// Color for client-related elements.
  static const Color client = Color(0xFF9C27B0);
  
  /// Color for admin-related elements.
  static const Color admin = Color(0xFFF44336);
}
