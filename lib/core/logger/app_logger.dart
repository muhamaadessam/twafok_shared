import 'package:flutter/foundation.dart';

class AppLogger {
  static const _reset = '\x1B[0m';

  static const _red = '\x1B[31m';
  static const _green = '\x1B[32m';
  static const _yellow = '\x1B[33m';
  static const _blue = '\x1B[34m';
  static const _magenta = '\x1B[35m';
  static const _cyan = '\x1B[36m';

  static void info(dynamic message) {
    _print('INFO', message, _blue);
  }

  static void success(dynamic message) {
    _print('SUCCESS', message, _green);
  }

  static void warning(dynamic message) {
    _print('WARNING', message, _yellow);
  }

  static void error(dynamic message) {
    _print('ERROR', message, _red);
  }

  static void debug(dynamic message) {
    _print('DEBUG', message, _cyan);
  }

  static void custom(
    dynamic message, {
    String type = 'CUSTOM',
    String color = _magenta,
  }) {
    _print(type, message, color);
  }

  static void _print(
    String type,
    dynamic message,
    String color,
  ) {
    if (!kDebugMode) return;

    final time = DateTime.now().toIso8601String();

    debugPrint(
      '$color[$type][$time] $message$_reset',
    );
  }
}
