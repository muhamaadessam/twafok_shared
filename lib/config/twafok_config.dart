import 'package:flutter/material.dart';

import '../core/core.dart';
import 'dio_config.dart';

class TwafokConfig {
  static bool _isInitialized = false;

  // ============ App Info ============
  static String appName = 'Twafok App';
  static String appVersion = '1.0.0';
  static String appPackage = 'com.twafok.app';
  static Widget? loginScreen;

  // ============ API ============
  static String baseUrl = '';
  static Duration apiTimeout = const Duration(seconds: 30);
  static Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // ============ Features ============
  static bool enableLogging = true;
  static bool enableAnalytics = false;
  static bool enableCrashlytics = false;
  static bool enablePushNotifications = false;

  // ============ Theme ============
  static ThemeMode currentThemeMode = ThemeMode.system;
  static bool useMaterial3 = false;

  // ============ Cache Keys ============
  static const String _themeModeKey = 'twafok_theme_mode';

  static const String _tokenKey = 'twafok_token';
  static const String _subDomainUrlKey = 'subDomainUrl'; // key للـ sub domain

  // ============ Initialization ============
  static Future<void> init({
    // App Info
    String? appName,
    String? appVersion,
    String? appPackage,
    Widget? loginScreen,

    // API
    required String baseUrl,
    Duration? apiTimeout,
    Map<String, String>? defaultHeaders,

    // Features
    bool? enableLogging,
    bool? enableAnalytics,
    bool? enableCrashlytics,
    bool? enablePushNotifications,

    // Theme
    ThemeMode? themeMode,
    bool? useMaterial3,

    // Colors
    Color? primaryColor,
    Color? secondaryColor,
    Color? errorColor,
    Color? successColor,
    Color? secondTextColor,
    Color? borderColor,
    Color? lightScaffoldBackgroundColor,
    Color? darkScaffoldBackgroundColor,
    Color? lightIconColor,
    Color? darkIconColor,
    Color? lightBackgroundColor,
    Color? darkBackgroundColor,

    // Text
    String? fontFamily,

    // Dio Config
    bool? enableApiLogging,
    bool? enablePrettyLogger,
    bool? enableLogscope,
    List<Interceptor>? customInterceptors,

    // Notifications
    bool? enableNotifications,
    String? notificationIcon,
  }) async {
    if (_isInitialized) return;

    // Initialize CacheHelper if not already initialized
    try {
      // Check if CacheHelper is initialized by trying to access it
      CacheHelper.sharedPreferences;
    } catch (e) {
      await CacheHelper.init();
    }

    try {
      SecureCacheHelper.secureStorage;
    } catch (e) {
      await SecureCacheHelper.init();
      debugPrint(e.toString());
      // Handle initialization error if needed
    }

    // App Info
    if (appName != null) TwafokConfig.appName = appName;
    if (appVersion != null) TwafokConfig.appVersion = appVersion;
    if (appPackage != null) TwafokConfig.appPackage = appPackage;
    if (loginScreen != null) TwafokConfig.loginScreen = loginScreen;

    // API
    TwafokConfig.baseUrl = baseUrl;
    if (apiTimeout != null) TwafokConfig.apiTimeout = apiTimeout;
    if (defaultHeaders != null) {
      TwafokConfig.defaultHeaders.addAll(defaultHeaders);
    }

    // Features
    if (enableLogging != null) TwafokConfig.enableLogging = enableLogging;
    if (enableAnalytics != null) TwafokConfig.enableAnalytics = enableAnalytics;
    if (enableCrashlytics != null) {
      TwafokConfig.enableCrashlytics = enableCrashlytics;
    }
    if (enablePushNotifications != null) {
      TwafokConfig.enablePushNotifications = enablePushNotifications;
    }

    // Theme
    if (useMaterial3 != null) TwafokConfig.useMaterial3 = useMaterial3;

    // Load saved theme mode from CacheHelper
    final savedThemeMode = CacheHelper.get(key: _themeModeKey);
    if (savedThemeMode != null) {
      currentThemeMode = ThemeMode.values[savedThemeMode as int];
    } else if (themeMode != null) {
      currentThemeMode = themeMode;
    }

    // Update Colors if provided
    AppColors.updateColors(
      mainColor: primaryColor,
      secondaryColor: secondaryColor,
      errorColor: errorColor,
      secondTextColor: secondTextColor,
      borderColor: borderColor,
      successColor: successColor,
      lightScaffoldBackgroundColor: lightScaffoldBackgroundColor,
      darkScaffoldBackgroundColor: darkScaffoldBackgroundColor,
      lightIconColor: lightIconColor,
      darkIconColor: darkIconColor,
      lightBackgroundColor: lightBackgroundColor,
      darkBackgroundColor: darkBackgroundColor,
    );

    // Get saved sub domain URL if exists
    final savedSubDomainUrl = CacheHelper.get(key: _subDomainUrlKey);
    final finalBaseUrl = savedSubDomainUrl ?? baseUrl ?? TwafokConfig.baseUrl;

    // ============ Initialize Dio Config ============
    await DioHelper.init(
      baseUrl: finalBaseUrl.toString(),
      connectionTimeout: apiTimeout ?? const Duration(seconds: 30),
      enableLogging: enableApiLogging ?? enableLogging ?? true,
      enablePrettyLogger: enablePrettyLogger ?? true,
      enableLogscope: enableLogscope ?? true,
      defaultHeaders: defaultHeaders ?? TwafokConfig.defaultHeaders,
      customInterceptors: customInterceptors,
    );
    if (enableNotifications ?? false) {
      await initializeNotifications(
        icon: notificationIcon,
      );
    }

    _isInitialized = true;
  }

  // ============ Theme Management ============
  static Future<void> setThemeMode(ThemeMode mode) async {
    currentThemeMode = mode;
    await CacheHelper.put(key: _themeModeKey, value: mode.index);
  }

  static ThemeMode getThemeMode() {
    return currentThemeMode;
  }

  static bool isDarkMode() {
    if (currentThemeMode == ThemeMode.system) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
    return currentThemeMode == ThemeMode.dark;
  }

  static Future<void> toggleTheme() async {
    final newMode = isDarkMode() ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newMode);
  }

  // ============ Token Management ============
  static Future<void> setToken(String? token) async {
    if (token != null) {
      await CacheHelper.put(key: _tokenKey, value: token);
    } else {
      await CacheHelper.remove(key: _tokenKey);
    }
    // Update Dio headers
    await DioHelper.updateToken(token);
  }

  static String? getToken() {
    final token = CacheHelper.get(key: _tokenKey);
    return token as String?;
  }

  static bool hasToken() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  // ============ Sub Domain URL Management ============
  static Future<void> setSubDomainUrl(String? url) async {
    if (url != null && url.isNotEmpty) {
      await CacheHelper.put(key: _subDomainUrlKey, value: url);
      await DioHelper.updateBaseUrl(url);
    } else {
      await CacheHelper.remove(key: _subDomainUrlKey);
      await DioHelper.updateBaseUrl(baseUrl);
    }
  }

  static String? getSubDomainUrl() {
    final url = CacheHelper.get(key: _subDomainUrlKey);
    return url as String?;
  }

  // ============ API Base URL Management ============
  static Future<void> setBaseUrl(String newBaseUrl) async {
    baseUrl = newBaseUrl;
    await DioHelper.updateBaseUrl(newBaseUrl);
  }

  // ============ Notifications ============
  static Future<void> initializeNotifications({String? icon}) async {
    await FirebaseNotificationHelper.init();
    await LocalNotificationHelper.init(icon: icon);
  }
}
