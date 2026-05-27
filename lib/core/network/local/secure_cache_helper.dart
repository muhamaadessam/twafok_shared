import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureCacheHelper {
  static late FlutterSecureStorage secureStorage;

  static Future<void> init() async {
    secureStorage = const FlutterSecureStorage(
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ),
    );
  }

  static Future<void> put({
    required String key,
    required dynamic value,
  }) async {
    await secureStorage.write(
      key: key,
      value: value.toString(),
    );
  }

  static Future<String?> get({
    required String key,
  }) async {
    return await secureStorage.read(key: key);
  }

  static Future<void> putMap({
    required String key,
    required Map<String, dynamic> value,
  }) async {
    await secureStorage.write(
      key: key,
      value: jsonEncode(value),
    );
  }

  static Future<Map<String, dynamic>?> getMap({
    required String key,
  }) async {
    final value = await secureStorage.read(key: key);

    if (value == null || value.isEmpty) {
      return null;
    }

    try {
      return Map<String, dynamic>.from(
        jsonDecode(value),
      );
    } catch (_) {
      return null;
    }
  }

  static Future<void> remove({
    required String key,
  }) async {
    await secureStorage.delete(key: key);
  }

  static Future<void> clearData() async {
    await secureStorage.deleteAll();
  }
}

extension SecureLocalStorage on SecureCacheHelper {
  static Future<void> saveAccessToken(String token) async {
    await SecureCacheHelper.put(
      key: 'access_token',
      value: token,
    );
  }

  static Future<String> getAccessToken() async {
    return await SecureCacheHelper.get(
          key: 'access_token',
        ) ??
        '';
  }

  static Future<void> saveRefreshToken(String token) async {
    await SecureCacheHelper.put(
      key: 'refresh_token',
      value: token,
    );
  }

  static Future<String> getRefreshToken() async {
    return await SecureCacheHelper.get(
          key: 'refresh_token',
        ) ??
        '';
  }

  static Future<void> saveFirebaseToken(String token) async {
    await SecureCacheHelper.put(
      key: 'firebase_token',
      value: token,
    );
  }

  static Future<String> getFirebaseToken() async {
    return await SecureCacheHelper.get(
          key: 'firebase_token',
        ) ??
        '';
  }

  static Future<void> saveBiometricCredentials(
      Map<String, dynamic> credentials) async {
    await SecureCacheHelper.putMap(
      key: 'biometric_credentials',
      value: credentials,
    );
  }

  static Future<Map<String, dynamic>?> getBiometricCredentials() async {
    return await SecureCacheHelper.getMap(
      key: 'biometric_credentials',
    );
  }

  static Future<void> clearTokens() async {
    await Future.wait([
      SecureCacheHelper.remove(key: 'access_token'),
      SecureCacheHelper.remove(key: 'refresh_token'),
      SecureCacheHelper.remove(key: 'firebase_token'),
    ]);
  }
}
