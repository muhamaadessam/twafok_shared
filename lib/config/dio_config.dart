// lib/config/dio_config.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logscope_flutter/logscope_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:twafok_shared/core/error/failure.dart';

import '../core/network/local/cache_helper.dart';
import 'twafok_config.dart';

export 'package:dio/dio.dart';

class DioHelper {
  static Dio? _dio;
  static bool _isInitialized = false;

  // ============ Configuration ============
  static String baseUrl = '';
  static Duration connectionTimeout = const Duration(seconds: 30);
  static Duration receiveTimeout = const Duration(seconds: 30);
  static Duration sendTimeout = const Duration(seconds: 30);

  // ============ Features ============
  static bool enableLogging = true;
  static bool enablePrettyLogger = true;
  static bool enableLogscope = true;

  // ============ Headers ============
  static Map<String, String> defaultHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  // ============ Getters ============
  static Dio get dio {
    if (_dio == null) {
      throw Exception(
          'DioHelper not initialized. Call DioConfig.init() first.');
    }
    return _dio!;
  }

  static bool get isInitialized => _isInitialized;

  // ============ Headers with Token ============
  static Map<String, String> get headers {
    final headers = Map<String, String>.from(defaultHeaders);
    final token = CacheHelper.get(key: 'accessToken');
    if (token != null && token.toString().isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // ============ Initialization ============
  static Future<void> init({
    required String baseUrl,
    Duration? connectionTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    bool? enableLogging,
    bool? enablePrettyLogger,
    bool? enableLogscope,
    Map<String, String>? defaultHeaders,
    List<Interceptor>? customInterceptors,
  }) async {
    if (_isInitialized) return;

    // Update config
    DioHelper.baseUrl = baseUrl;
    if (connectionTimeout != null) {
      DioHelper.connectionTimeout = connectionTimeout;
    }
    if (receiveTimeout != null) DioHelper.receiveTimeout = receiveTimeout;
    if (sendTimeout != null) DioHelper.sendTimeout = sendTimeout;
    if (enableLogging != null) DioHelper.enableLogging = enableLogging;
    if (enablePrettyLogger != null) {
      DioHelper.enablePrettyLogger = enablePrettyLogger;
    }
    if (enableLogscope != null) DioHelper.enableLogscope = enableLogscope;
    if (defaultHeaders != null) DioHelper.defaultHeaders.addAll(defaultHeaders);

    // Get base URL from cache or use config
    final cachedSubDomainUrl = CacheHelper.get(key: 'subDomainUrl');
    final finalBaseUrl = cachedSubDomainUrl ?? DioHelper.baseUrl;

    // Create Dio instance
    _dio = Dio(
      BaseOptions(
        baseUrl: finalBaseUrl,
        receiveDataWhenStatusError: true,
        headers: headers,
        connectTimeout: connectionTimeout ?? DioHelper.connectionTimeout,
        receiveTimeout: receiveTimeout ?? DioHelper.receiveTimeout,
        sendTimeout: sendTimeout ?? DioHelper.sendTimeout,
      ),
    );

    // Add interceptors
    final interceptors = <Interceptor>[];

    if (enablePrettyLogger == true && kDebugMode) {
      interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );
    }

    if (enableLogscope == true) {
      interceptors.add(Logscope.dioInterceptor());
    }

    if (customInterceptors != null) {
      interceptors.addAll(customInterceptors);
    }

    _dio!.interceptors.addAll(interceptors);

    _isInitialized = true;
  }

  // ============ Re-initialization ============
  static Future<void> reInit() async {
    if (!_isInitialized) {
      await init(baseUrl: baseUrl);
    } else {
      final oldDio = _dio;
      _dio = null;
      await init(baseUrl: baseUrl);
      if (oldDio != null) {
        // Dispose old dio if needed
        oldDio.close();
      }
    }
  }

  // ============ Update Base URL ============
  static Future<void> updateBaseUrl(String newBaseUrl) async {
    baseUrl = newBaseUrl;
    await CacheHelper.put(key: 'subDomainUrl', value: newBaseUrl);
    await reInit();
  }

  // ============ API Methods ============
  static Future<Either<Failure, Map<String, dynamic>>> getData({
    required String endPoint,
    String? refreshToken,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio!.get(
        endPoint,
        queryParameters: query,
      );

      if (response.data['statusCode'] == 200) {
        return Right(response.data);
      } else {
        final message = response.data['data']?['message'] ?? 'Unknown error';
        if (kDebugMode) print(message);
        return Left(ServerFailure(message));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(handleError(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  static Future<Either<Failure, Map<String, dynamic>>> postData({
    required String endPoint,
    dynamic data,
  }) async {
    try {
      final response = await _dio!.post(
        endPoint,
        data: data,
      );

      if (response.data['statusCode'] == 200) {
        return Right(response.data);
      } else {
        final message = response.data['data']?['message'] ?? 'Unknown error';
        if (kDebugMode) print(message);
        return Left(ServerFailure(message));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(handleError(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  static Future<Either<Failure, Map<String, dynamic>>> putData({
    required String endPoint,
    dynamic data,
  }) async {
    try {
      final response = await _dio!.put(
        endPoint,
        data: data,
      );

      if (response.data['statusCode'] == 200) {
        return Right(response.data);
      } else {
        final message = response.data['data']?['message'] ?? 'Unknown error';
        if (kDebugMode) print(message);
        return Left(ServerFailure(message));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(handleError(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  static Future<Either<Failure, Map<String, dynamic>>> patchData({
    required String? endPoint,
    required dynamic data,
  }) async {
    try {
      final response = await _dio!.patch(
        '$endPoint',
        data: data,
      );

      if (response.data['statusCode'] == 200) {
        return Right(response.data);
      } else {
        final message = response.data['data']?['message'] ?? 'Unknown error';
        if (kDebugMode) print(message);
        return Left(ServerFailure(message));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(handleError(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  static Future<Either<Failure, Map<String, dynamic>>> deleteData({
    required String endPoint,
    dynamic data,
  }) async {
    try {
      final response = await _dio!.delete(
        endPoint,
        data: data,
      );

      if (response.data['statusCode'] == 200) {
        return Right(response.data);
      } else {
        final message = response.data['data']?['message'] ?? 'Unknown error';
        if (kDebugMode) print(message);
        return Left(ServerFailure(message));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(handleError(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ============ Error Handling ============
  static String handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        if (kDebugMode) print('Timeout error: ${error.message}');
        return error.message ?? 'Connection timeout';

      case DioExceptionType.badResponse:
        final message = error.response?.data['data']?['message'] ??
            error.response?.data['message'] ??
            'Bad response from server';
        if (kDebugMode) {
          print('Bad response: ${error.response?.statusCode} - $message');
        }
        return message;

      case DioExceptionType.cancel:
        if (kDebugMode) print('Request cancelled');
        return 'Request cancelled';

      case DioExceptionType.connectionError:
        if (kDebugMode) print('Connection error: ${error.message}');
        return 'No internet connection';

      default:
        if (kDebugMode) print('Error: ${error.message}');
        return error.message ?? 'Unknown error occurred';
    }
  }

  static Future<void> updateToken(String? token) async {
    if (token != null) {
      await CacheHelper.put(key: 'accessToken', value: token);
    } else {
      await CacheHelper.remove(key: 'accessToken');
    }
    // Update headers for next requests
    _dio?.options.headers['Authorization'] =
        token != null ? 'Bearer $token' : null;
  }

// وأضف دالة جديدة:
  static Future<void> syncWithTwafokConfig() async {
    final token = TwafokConfig.getToken();
    if (token != null) {
      await updateToken(token);
    }
  }

  // ============ Dispose ============
  static void dispose() {
    _dio?.close();
    _dio = null;
    _isInitialized = false;
  }
}
