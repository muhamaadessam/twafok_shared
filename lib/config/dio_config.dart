import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logscope_flutter/logscope_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:essam_shared/core/core.dart';

import 'essam_config.dart';

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
      throw ServerFailure(
          'DioHelper not initialized. Call DioHelper.init() first.');
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

    final finalBaseUrl =
        await SecureCacheHelper.get(key: 'subDomainUrl') ?? baseUrl;

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
        onRequest: (options, handler) async {
          final token = await SecureLocalStorage.getAccessToken();
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
      return Error(_handleError(e));
    } catch (e) {
      debugPrint('API Error ==> ${e.toString()}');
      return Error(e is Failure ? e : ServerFailure(e.toString()));
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
      throw BadRequestFailure('Invalid response format');
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

      throw ServerFailure(message);
    }

    /// 4. Return normalized data
    final payload = data['data'];
    return fromJson(payload);
  }

  // ===================== ERROR =====================

  static Failure _handleError(DioException error) {
    final statusCode = error.response?.statusCode ?? 0;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        debugPrint('API Error ==> Connection Timeout');
        return TimeoutFailure('Connection timeout');
      case DioExceptionType.connectionError:
        debugPrint('API Error ==> No Internet Connection');
        return ConnectionFailure('No internet connection');
      case DioExceptionType.cancel:
        debugPrint('API Error ==> Request Cancelled');
        return ServerFailure('Request cancelled');
      case DioExceptionType.badResponse:
        debugPrint('API Error ==> Bad Response');
        return _handleBadResponse(error, statusCode);
      case DioExceptionType.badCertificate:
        debugPrint('API Error ==> Bad SSL Certificate');
        return ServerFailure('Bad SSL Certificate');
      case DioExceptionType.unknown:
        return _handleUnknown(error);
    }
  }

  static Failure _handleBadResponse(DioException error, int? statusCode) {
    final data = error.response?.data;

    final message = (data is Map)
        ? (data['message'] ?? data['data']?['message'])
        : 'Server error';
    debugPrint(
        'API Error ==> ${data['message'] ?? data['data']?['message'] ?? 'Server error'}');

    switch (statusCode) {
      case 400:
        debugPrint('API Error ==> Bad Request');
        return BadRequestFailure(message);

      case 401:
        debugPrint('API Error ==> Unauthorized');
        return UnauthorizedFailure(message);

      case 403:
        debugPrint('API Error ==> Forbidden');
        return ForbiddenFailure(message);

      case 404:
        debugPrint('API Error ==> Not Found');
        return NotFoundFailure(message);

      case 500:
      default:
        debugPrint('API Error ==> Server Failure');
        return ServerFailure(message);
    }
  }

  static Failure _handleUnknown(DioException error) {
    final err = error.error;

    if (err is SocketException) {
      debugPrint('SocketException => No internet / DNS issue');
      return ServerFailure('No internet connection');
    }

    if (err is HandshakeException) {
      debugPrint('HandshakeException => SSL issue');
      return ServerFailure('SSL Certificate error');
    }

    if (err is FormatException) {
      debugPrint('FormatException => Bad response format');
      return ServerFailure('Bad response format');
    }

    debugPrint('Unknown root error: $err');
    return ServerFailure(error.message ?? 'Unknown error');
  }
  // ===================== TOKEN =====================

  static Future<void> updateToken(String? token) async {
    if (token != null) {
      await SecureLocalStorage.saveAccessToken(token);
    } else {
      await SecureLocalStorage.clearTokens();
    }
  }

  static Future<void> syncWithConfig() async {
    final token = EssamConfig.getToken();
    if (token != null) {
      await updateToken(token);
    }
  }

  // ===================== BASE URL =====================

  static Future<void> updateBaseUrl(String url) async {
    baseUrl = url;
    await SecureCacheHelper.put(key: 'subDomainUrl', value: url);
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
