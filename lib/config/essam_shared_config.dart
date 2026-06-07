import 'package:flutter/material.dart';

import '../core/design_system/design_system.dart';
import '../core/network/local/cache_helper.dart';
import '../core/network/local/secure_cache_helper.dart';

/// Immutable configuration for the Essam Shared package.
///
/// This class holds all configuration values in an immutable way,
/// preventing runtime mutations and ensuring thread safety.
class EssamSharedConfig {
  /// Creates a new immutable configuration instance.
  const EssamSharedConfig({
    required this.baseUrl,
    this.primaryColor = AppColors.primary,
    this.secondaryColor = AppColors.secondary,
    this.errorColor = AppColors.error,
    this.successColor = AppColors.success,
    this.textSecondaryColor = AppColors.textSecondary,
    this.borderColor = AppColors.border,
    this.lightScaffoldBackgroundColor = AppColors.lightScaffold,
    this.darkScaffoldBackgroundColor = AppColors.darkScaffold,
    this.lightBackgroundColor = AppColors.lightBackground,
    this.darkBackgroundColor = AppColors.darkBackground,
    this.lightIconColor = AppColors.lightIcon,
    this.darkIconColor = AppColors.darkIcon,
    this.fontFamily,
    this.apiTimeout = const Duration(seconds: 30),
    this.enableLogging = true,
    this.enableAnalytics = false,
    this.enableCrashlytics = false,
    this.enablePushNotifications = false,
    this.themeMode = ThemeMode.system,
    this.useMaterial3 = false,
    this.loginScreen,
    this.defaultHeaders = const {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    this.enableApiLogging,
    this.enablePrettyLogger = true,
    this.enableLogscope = true,
    this.customInterceptors,
    this.notificationIcon,
  });

  /// The base URL for all API requests.
  final String baseUrl;

  /// Primary brand color.
  final Color primaryColor;

  /// Secondary brand color.
  final Color secondaryColor;

  /// Error state color.
  final Color errorColor;

  /// Success state color.
  final Color successColor;

  /// Secondary text color.
  final Color textSecondaryColor;

  /// Border color.
  final Color borderColor;

  /// Light theme scaffold background color.
  final Color lightScaffoldBackgroundColor;

  /// Dark theme scaffold background color.
  final Color darkScaffoldBackgroundColor;

  /// Light theme background color.
  final Color lightBackgroundColor;

  /// Dark theme background color.
  final Color darkBackgroundColor;

  /// Light theme icon color.
  final Color lightIconColor;

  /// Dark theme icon color.
  final Color darkIconColor;

  /// Optional custom font family.
  final String? fontFamily;

  /// Timeout duration for API requests.
  final Duration apiTimeout;

  /// Enable logging.
  final bool enableLogging;

  /// Enable analytics.
  final bool enableAnalytics;

  /// Enable crashlytics.
  final bool enableCrashlytics;

  /// Enable push notifications.
  final bool enablePushNotifications;

  /// Theme mode (light, dark, or system).
  final ThemeMode themeMode;

  /// Whether to use Material 3 design.
  final bool useMaterial3;

  /// Login screen widget for unauthorized navigation.
  final Widget? loginScreen;

  /// Default headers for API requests.
  final Map<String, String> defaultHeaders;

  /// Enable API logging (overrides [enableLogging] for API only).
  final bool? enableApiLogging;

  /// Enable pretty Dio logger.
  final bool enablePrettyLogger;

  /// Enable Logscope logger.
  final bool enableLogscope;

  /// Custom Dio interceptors.
  final List<dynamic>? customInterceptors;

  /// Notification icon resource name.
  final String? notificationIcon;

  /// Creates a copy of this configuration with the given fields replaced.
  EssamSharedConfig copyWith({
    String? baseUrl,
    Color? primaryColor,
    Color? secondaryColor,
    Color? errorColor,
    Color? successColor,
    Color? textSecondaryColor,
    Color? borderColor,
    Color? lightScaffoldBackgroundColor,
    Color? darkScaffoldBackgroundColor,
    Color? lightBackgroundColor,
    Color? darkBackgroundColor,
    Color? lightIconColor,
    Color? darkIconColor,
    String? fontFamily,
    Duration? apiTimeout,
    bool? enableLogging,
    bool? enableAnalytics,
    bool? enableCrashlytics,
    bool? enablePushNotifications,
    ThemeMode? themeMode,
    bool? useMaterial3,
    Widget? loginScreen,
    Map<String, String>? defaultHeaders,
    bool? enableApiLogging,
    bool? enablePrettyLogger,
    bool? enableLogscope,
    List<dynamic>? customInterceptors,
    String? notificationIcon,
  }) {
    return EssamSharedConfig(
      baseUrl: baseUrl ?? this.baseUrl,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      errorColor: errorColor ?? this.errorColor,
      successColor: successColor ?? this.successColor,
      textSecondaryColor: textSecondaryColor ?? this.textSecondaryColor,
      borderColor: borderColor ?? this.borderColor,
      lightScaffoldBackgroundColor:
          lightScaffoldBackgroundColor ?? this.lightScaffoldBackgroundColor,
      darkScaffoldBackgroundColor:
          darkScaffoldBackgroundColor ?? this.darkScaffoldBackgroundColor,
      lightBackgroundColor: lightBackgroundColor ?? this.lightBackgroundColor,
      darkBackgroundColor: darkBackgroundColor ?? this.darkBackgroundColor,
      lightIconColor: lightIconColor ?? this.lightIconColor,
      darkIconColor: darkIconColor ?? this.darkIconColor,
      fontFamily: fontFamily ?? this.fontFamily,
      apiTimeout: apiTimeout ?? this.apiTimeout,
      enableLogging: enableLogging ?? this.enableLogging,
      enableAnalytics: enableAnalytics ?? this.enableAnalytics,
      enableCrashlytics: enableCrashlytics ?? this.enableCrashlytics,
      enablePushNotifications:
          enablePushNotifications ?? this.enablePushNotifications,
      themeMode: themeMode ?? this.themeMode,
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      loginScreen: loginScreen ?? this.loginScreen,
      defaultHeaders: defaultHeaders ?? this.defaultHeaders,
      enableApiLogging: enableApiLogging ?? this.enableApiLogging,
      enablePrettyLogger: enablePrettyLogger ?? this.enablePrettyLogger,
      enableLogscope: enableLogscope ?? this.enableLogscope,
      customInterceptors: customInterceptors ?? this.customInterceptors,
      notificationIcon: notificationIcon ?? this.notificationIcon,
    );
  }
}

/// Main entry point for initializing the Essam Shared package.
///
/// This class manages the package initialization and provides access
/// to the current configuration.
class EssamShared {
  EssamShared._();

  static EssamSharedConfig? _config;
  static bool _isInitialized = false;

  /// Gets the current configuration.
  ///
  /// Throws [StateError] if the package has not been initialized.
  static EssamSharedConfig get config {
    if (_config == null) {
      throw StateError(
        'EssamShared has not been initialized. '
        'Call EssamShared.initialize() before using the package.',
      );
    }
    return _config!;
  }

  /// Checks if the package has been initialized.
  static bool get isInitialized => _isInitialized;

  /// Initializes the Essam Shared package with the given configuration.
  ///
  /// This method must be called before using any package features.
  /// It initializes the cache helpers, Dio configuration, and optionally
  /// the notification system.
  ///
  /// Example:
  /// ```dart
  /// await EssamShared.initialize(
  ///   config: EssamSharedConfig(
  ///     baseUrl: 'https://api.example.com',
  ///     primaryColor: Colors.blue,
  ///   ),
  /// );
  /// ```
  static Future<void> initialize({
    required EssamSharedConfig config,
  }) async {
    if (_isInitialized) {
      return;
    }

    _config = config;

    // Initialize CacheHelper if not already initialized
    try {
      CacheHelper.sharedPreferences;
    } catch (e) {
      await CacheHelper.init();
    }

    // Initialize SecureCacheHelper if not already initialized
    try {
      SecureCacheHelper.secureStorage;
    } catch (e) {
      await SecureCacheHelper.init();
    }

    // Initialize Dio configuration
    await _initializeDio();

    // Initialize notifications if enabled
    if (config.enablePushNotifications) {
      await _initializeNotifications();
    }

    _isInitialized = true;
  }

  /// Resets the package to its uninitialized state.
  ///
  /// This is primarily useful for testing purposes.
  static void reset() {
    _config = null;
    _isInitialized = false;
  }

  static Future<void> _initializeDio() async {
    // Note: Dio initialization will be handled by refactoring dio_config.dart
    // to use the new config system
    // This is a placeholder for the actual implementation
  }

  static Future<void> _initializeNotifications() async {
    // Note: Notification initialization will be handled by refactoring
    // the notification helper to use the new config system
    // This is a placeholder for the actual implementation
  }
}
