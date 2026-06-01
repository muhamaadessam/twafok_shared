import 'package:flutter/foundation.dart';

class AppLogger {
  static void info(dynamic message) {
    _print('INFO', message);
  }

  static void success(dynamic message) {
    _print('SUCCESS', message);
  }

  static void warning(dynamic message) {
    _print('WARNING', message);
  }

  static void error(dynamic message) {
    _print('ERROR', message);
  }

  static void debug(dynamic message) {
    _print('DEBUG', message);
  }

  static void custom(
    dynamic message, {
    String type = 'CUSTOM',
  }) {
    _print(type, message);
  }

  static void _print(
    String type,
    dynamic message,
  ) {
    if (!kDebugMode) return;

    final time = DateTime.now().toIso8601String();

    debugPrint(
      '[$type][$time] $message',
    );
  }
}
