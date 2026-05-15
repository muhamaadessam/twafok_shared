import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_theme.dart';
import '../core/constants/colors.dart';
import '../core/error/failure.dart';
import '../core/network/local/cache_helper.dart';
import 'dio_config.dart';

class TwafokConfig {
  static bool _isInitialized = false;

  // ============ App Info ============
  static String appName = 'Twafok App';
  static String appVersion = '1.0.0';
  static String appPackage = 'com.twafok.app';

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
  static const String _isDarkKey = 'twafok_is_dark';
  static const String _tokenKey = 'twafok_token';
  static const String _userDataKey = 'twafok_user_data';
  static const String _subDomainUrlKey = 'subDomainUrl'; // key للـ sub domain

  // ============ Initialization ============
  static Future<void> init({
    // App Info
    String? appName,
    String? appVersion,
    String? appPackage,

    // API
    String? baseUrl,
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

    // Text
    String? fontFamily,

    // Dio Config
    bool? enableApiLogging,
    bool? enablePrettyLogger,
    bool? enableLogscope,
    List<Interceptor>? customInterceptors,
  }) async {
    if (_isInitialized) return;

    // Initialize CacheHelper if not already initialized
    try {
      // Check if CacheHelper is initialized by trying to access it
      CacheHelper.sharedPreferences;
    } catch (e) {
      await CacheHelper.init();
    }

    // App Info
    if (appName != null) TwafokConfig.appName = appName;
    if (appVersion != null) TwafokConfig.appVersion = appVersion;
    if (appPackage != null) TwafokConfig.appPackage = appPackage;

    // API
    if (baseUrl != null) TwafokConfig.baseUrl = baseUrl;
    if (apiTimeout != null) TwafokConfig.apiTimeout = apiTimeout;
    if (defaultHeaders != null) TwafokConfig.defaultHeaders.addAll(defaultHeaders);

    // Features
    if (enableLogging != null) TwafokConfig.enableLogging = enableLogging;
    if (enableAnalytics != null) TwafokConfig.enableAnalytics = enableAnalytics;
    if (enableCrashlytics != null) TwafokConfig.enableCrashlytics = enableCrashlytics;
    if (enablePushNotifications != null) TwafokConfig.enablePushNotifications = enablePushNotifications;

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
    );

    // Get saved sub domain URL if exists
    final savedSubDomainUrl = CacheHelper.get(key: _subDomainUrlKey);
    final finalBaseUrl = savedSubDomainUrl ?? baseUrl ?? TwafokConfig.baseUrl;

    // ============ Initialize Dio Config ============
    await DioConfig.init(
      baseUrl: finalBaseUrl.toString(),
      connectionTimeout: apiTimeout ?? const Duration(seconds: 30),
      enableLogging: enableApiLogging ?? enableLogging ?? true,
      enablePrettyLogger: enablePrettyLogger ?? true,
      enableLogscope: enableLogscope ?? true,
      defaultHeaders: defaultHeaders ?? TwafokConfig.defaultHeaders,
      customInterceptors: customInterceptors,
    );

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
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
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
    await DioConfig.updateToken(token);
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
      await DioConfig.updateBaseUrl(url);
    } else {
      await CacheHelper.remove(key: _subDomainUrlKey);
      await DioConfig.updateBaseUrl(baseUrl);
    }
  }

  static String? getSubDomainUrl() {
    final url = CacheHelper.get(key: _subDomainUrlKey);
    return url as String?;
  }

  // ============ API Base URL Management ============
  static Future<void> setBaseUrl(String newBaseUrl) async {
    baseUrl = newBaseUrl;
    await DioConfig.updateBaseUrl(newBaseUrl);
  }

  // ============ User Data Management ============
  static Future<void> setUserData(Map<String, dynamic>? userData) async {
    if (userData != null) {
      // Convert Map to JSON string
      final jsonString = userData.toString(); // TODO: Use proper JSON encoding
      await CacheHelper.put(key: _userDataKey, value: jsonString);
    } else {
      await CacheHelper.remove(key: _userDataKey);
    }
  }

  static Map<String, dynamic>? getUserData() {
    final data = CacheHelper.get(key: _userDataKey);
    if (data != null) {
      // TODO: Parse JSON properly
      return {};
    }
    return null;
  }

  // ============ Logout / Clear All ============
  static Future<void> clearAll() async {
    await CacheHelper.clearData();

    // Reset to defaults
    currentThemeMode = ThemeMode.system;
    await setThemeMode(ThemeMode.system);

    // Clear Dio
    DioConfig.dispose();
  }

  // ============ Getters ============
  static bool get isInitialized => _isInitialized;

  static ThemeData get currentTheme {
    return isDarkMode() ? AppTheme.darkMode() : AppTheme.lightMode();
  }

  // ============ API Headers ============
  static Map<String, String> getHeaders() {
    final headers = Map<String, String>.from(defaultHeaders);
    final token = getToken();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // ============ Dio Instance ============
  static Dio get dio => DioConfig.dio;

  // ============ API Methods (Shortcuts) ============
  static Future<Either<Failure, Map<String, dynamic>>> get({
    required String endPoint,
    Map<String, dynamic>? query,
  }) {
    return DioConfig.getData(endPoint: endPoint, query: query);
  }

  static Future<Either<Failure, Map<String, dynamic>>> post({
    required String endPoint,
    dynamic data,
  }) {
    return DioConfig.postData(endPoint: endPoint, data: data);
  }

  static Future<Either<Failure, Map<String, dynamic>>> put({
    required String endPoint,
    dynamic data,
  }) {
    return DioConfig.putData(endPoint: endPoint, data: data);
  }

  static Future<Either<Failure, Map<String, dynamic>>> patch({
    required String endPoint,
    required dynamic data,
  }) {
    return DioConfig.patchData(endPoint: endPoint, data: data);
  }

  static Future<Either<Failure, Map<String, dynamic>>> delete({
    required String endPoint,
    dynamic data,
  }) {
    return DioConfig.deleteData(endPoint: endPoint, data: data);
  }
}