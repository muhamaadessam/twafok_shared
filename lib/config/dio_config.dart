import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logscope_flutter/logscope_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../core/error/failure.dart';
import '../core/network/local/cache_helper.dart';
import '../core/network/remote/result_helper.dart';
import 'twafok_config.dart';

export 'package:dio/dio.dart';

class DioHelper {
  static Dio? _dio;
  static bool _initialized = false;

  static String baseUrl = '';

  static Duration connectTimeout = const Duration(seconds: 30);
  static Duration receiveTimeout = const Duration(seconds: 30);
  static Duration sendTimeout = const Duration(seconds: 30);

  static Map<String, String> defaultHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  static Dio get dio {
    if (_dio == null) {
      throw Exception('DioHelper not initialized');
    }
    return _dio!;
  }

  static Future<void> init({
    required String baseUrl,
    bool enableLogging = true,
    bool enablePrettyLogger = true,
    bool enableLogscope = true,
    Duration? connectionTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    Map<String, String>? defaultHeaders,
    List<Interceptor>? customInterceptors,
  }) async {
    if (_initialized) return;

    DioHelper.baseUrl = baseUrl;

    final finalBaseUrl = CacheHelper.get(key: 'subDomainUrl') ?? baseUrl;

    _dio = Dio(
      BaseOptions(
        baseUrl: finalBaseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
        headers: _buildHeaders(),
      ),
    );

    _dio!.interceptors.clear();

    /// 🔥 Auto token injection (FIXED)
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = CacheHelper.get(key: 'accessToken');
          if (token != null && token.toString().isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );

    if (enablePrettyLogger && kDebugMode) {
      _dio!.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );
    }

    if (enableLogscope) {
      _dio!.interceptors.add(Logscope.dioInterceptor());
    }

    if (customInterceptors != null) {
      _dio!.interceptors.addAll(customInterceptors);
    }

    _initialized = true;
  }

  static Map<String, String> _buildHeaders() {
    return Map<String, String>.from(defaultHeaders);
  }

  // ===================== CORE REQUEST =====================
  @protected
  static Future<Result<T>> request<T>({
    required String method,
    required String endpoint,
    required T Function(dynamic) fromJson,
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await dio.request(
        endpoint,
        data: data,
        queryParameters: query,
        options: Options(method: method),
      );

      final model = _handleResponse<T>(response, fromJson);

      return Success(model);
    } on DioException catch (e) {
      return Error(ServerFailure(_handleError(e)));
    } catch (e) {
      debugPrint('API Error ==> ${e.toString()}');
      return Error(ServerFailure(e.toString()));
    }
  }

  // ===================== CRUD METHODS =====================
  static Future<Result<T>> getData<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    Map<String, dynamic>? query,
  }) {
    return request<T>(
      method: 'GET',
      endpoint: endPoint,
      query: query,
      fromJson: fromJson,
    );
  }

  static Future<Result<T>> postData<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    dynamic data,
  }) {
    return request<T>(
      method: 'POST',
      endpoint: endPoint,
      data: data,
      fromJson: fromJson,
    );
  }

  static Future<Result<T>> putData<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    dynamic data,
  }) {
    return request<T>(
      method: 'PUT',
      endpoint: endPoint,
      data: data,
      fromJson: fromJson,
    );
  }

  static Future<Result<T>> patchData<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    dynamic data,
  }) {
    return request<T>(
      method: 'PATCH',
      endpoint: endPoint,
      data: data,
      fromJson: fromJson,
    );
  }

  static Future<Result<T>> deleteData<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    dynamic data,
  }) {
    return request<T>(
      method: 'DELETE',
      endpoint: endPoint,
      data: data,
      fromJson: fromJson,
    );
  }

  // ===================== RESPONSE =====================
  static T _handleResponse<T>(
    Response response,
    T Function(dynamic) fromJson,
  ) {
    final data = response.data;

    /// 1. Safety check
    if (data is! Map<String, dynamic>) {
      throw Exception('Invalid response format');
    }

    /// 2. Extract status safely (body OR HTTP fallback)
    final int? bodyStatus = data['statusCode'];
    final int httpStatus = response.statusCode ?? 0;

    final isSuccess = (httpStatus == 200 || httpStatus == 201) &&
        (bodyStatus == null || bodyStatus == 200);

    /// 3. Handle error case
    if (!isSuccess) {
      final message =
          data['data']?['message'] ?? data['message'] ?? 'Unknown error';

      throw Exception(message);
    }

    /// 4. Return normalized data
    final payload = data['data'];
    return fromJson(payload);
  }

  // ===================== ERROR =====================

  static String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        debugPrint('API Error ==> Connection Timeout');
        return 'Connection timeout';
      case DioExceptionType.connectionError:
        debugPrint('API Error ==> No Internet Connection');
        return 'No internet connection';
      case DioExceptionType.cancel:
        debugPrint('API Error ==> Request Cancelled');
        return 'Request cancelled';
      case DioExceptionType.badResponse:
        debugPrint('API Error ==> Bad Response');
        final data = error.response?.data;
        if (data is Map) {
          debugPrint(
              'API Error ==> ${data['message'] ?? data['data']?['message'] ?? 'Server error'}');
          return data['message'] ?? data['data']?['message'] ?? 'Server error';
        }
        debugPrint('API Error ==> Server error');
        return 'Server error';
      case DioExceptionType.badCertificate:
        debugPrint('API Error ==> Bad SSL Certificate');
        return 'Bad SSL Certificate';
      case DioExceptionType.unknown:
        return _handleUnknown(error);
    }
  }

  static String _handleUnknown(DioException error) {
    final err = error.error;

    if (err is SocketException) {
      debugPrint('SocketException => No internet / DNS issue');
      return 'No internet connection';
    }

    if (err is HandshakeException) {
      debugPrint('HandshakeException => SSL issue');
      return 'SSL Certificate error';
    }

    if (err is FormatException) {
      debugPrint('FormatException => Bad response format');
      return 'Bad response format';
    }

    debugPrint('Unknown root error: $err');
    return error.message ?? 'Unknown error';
  }
  // ===================== TOKEN =====================

  static Future<void> updateToken(String? token) async {
    if (token != null) {
      await CacheHelper.put(key: 'accessToken', value: token);
    } else {
      await CacheHelper.remove(key: 'accessToken');
    }
  }

  static Future<void> syncWithConfig() async {
    final token = TwafokConfig.getToken();
    if (token != null) {
      await updateToken(token);
    }
  }

  // ===================== BASE URL =====================

  static Future<void> updateBaseUrl(String url) async {
    baseUrl = url;
    await CacheHelper.put(key: 'subDomainUrl', value: url);
    await reInit();
  }

  static Future<void> reInit() async {
    _dio?.close();
    _dio = null;
    _initialized = false;

    await init(baseUrl: baseUrl);
  }

  static void dispose() {
    _dio?.close();
    _dio = null;
    _initialized = false;
  }
}
