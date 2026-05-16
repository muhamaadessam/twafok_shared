// // lib/config/dio_config.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:logscope_flutter/logscope_flutter.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'package:twafok_shared/core/error/failure.dart';
//
// import '../core/network/local/cache_helper.dart';
// import '../core/network/remote/result_helper.dart';
// import 'twafok_config.dart';
//
// export 'package:dio/dio.dart';
//
// class DioHelper {
//   static Dio? _dio;
//   static bool _isInitialized = false;
//
//   // ============ Configuration ============
//   static String baseUrl = '';
//   static Duration connectionTimeout = const Duration(seconds: 30);
//   static Duration receiveTimeout = const Duration(seconds: 30);
//   static Duration sendTimeout = const Duration(seconds: 30);
//
//   // ============ Features ============
//   static bool enableLogging = true;
//   static bool enablePrettyLogger = true;
//   static bool enableLogscope = true;
//
//   // ============ Headers ============
//   static Map<String, String> defaultHeaders = {
//     'Accept': 'application/json',
//     'Content-Type': 'application/json',
//   };
//
//   // ============ Getters ============
//   static Dio get dio {
//     if (_dio == null) {
//       throw Exception(
//           'DioHelper not initialized. Call DioConfig.init() first.');
//     }
//     return _dio!;
//   }
//
//   static bool get isInitialized => _isInitialized;
//
//   // ============ Headers with Token ============
//   static Map<String, String> get headers {
//     final headers = Map<String, String>.from(defaultHeaders);
//     final token = CacheHelper.get(key: 'accessToken');
//     if (token != null && token.toString().isNotEmpty) {
//       headers['Authorization'] = 'Bearer $token';
//     }
//     return headers;
//   }
//
//   // ============ Initialization ============
//   static Future<void> init({
//     required String baseUrl,
//     Duration? connectionTimeout,
//     Duration? receiveTimeout,
//     Duration? sendTimeout,
//     bool? enableLogging,
//     bool? enablePrettyLogger,
//     bool? enableLogscope,
//     Map<String, String>? defaultHeaders,
//     List<Interceptor>? customInterceptors,
//   }) async {
//     if (_isInitialized) return;
//
//     // Update config
//     DioHelper.baseUrl = baseUrl;
//     if (connectionTimeout != null) {
//       DioHelper.connectionTimeout = connectionTimeout;
//     }
//     if (receiveTimeout != null) DioHelper.receiveTimeout = receiveTimeout;
//     if (sendTimeout != null) DioHelper.sendTimeout = sendTimeout;
//     if (enableLogging != null) DioHelper.enableLogging = enableLogging;
//     if (enablePrettyLogger != null) {
//       DioHelper.enablePrettyLogger = enablePrettyLogger;
//     }
//     if (enableLogscope != null) DioHelper.enableLogscope = enableLogscope;
//     if (defaultHeaders != null) DioHelper.defaultHeaders.addAll(defaultHeaders);
//
//     // Get base URL from cache or use config
//     final cachedSubDomainUrl = CacheHelper.get(key: 'subDomainUrl');
//     final finalBaseUrl = cachedSubDomainUrl ?? DioHelper.baseUrl;
//
//     // Create Dio instance
//     _dio = Dio(
//       BaseOptions(
//         baseUrl: finalBaseUrl,
//         receiveDataWhenStatusError: true,
//         headers: headers,
//         connectTimeout: connectionTimeout ?? DioHelper.connectionTimeout,
//         receiveTimeout: receiveTimeout ?? DioHelper.receiveTimeout,
//         sendTimeout: sendTimeout ?? DioHelper.sendTimeout,
//       ),
//     );
//
//     // Add interceptors
//     final interceptors = <Interceptor>[];
//
//     if (enablePrettyLogger == true && kDebugMode) {
//       interceptors.add(
//         PrettyDioLogger(
//           requestHeader: true,
//           requestBody: true,
//           responseBody: true,
//           responseHeader: false,
//           error: true,
//           compact: true,
//         ),
//       );
//     }
//
//     if (enableLogscope == true) {
//       interceptors.add(Logscope.dioInterceptor());
//     }
//
//     if (customInterceptors != null) {
//       interceptors.addAll(customInterceptors);
//     }
//
//     _dio!.interceptors.addAll(interceptors);
//
//     _isInitialized = true;
//   }
//
//   // ============ Re-initialization ============
//   static Future<void> reInit() async {
//     if (!_isInitialized) {
//       await init(baseUrl: baseUrl);
//     } else {
//       final oldDio = _dio;
//       _dio = null;
//       await init(baseUrl: baseUrl);
//       if (oldDio != null) {
//         // Dispose old dio if needed
//         oldDio.close();
//       }
//     }
//   }
//
//   // ============ Update Base URL ============
//   static Future<void> updateBaseUrl(String newBaseUrl) async {
//     baseUrl = newBaseUrl;
//     await CacheHelper.put(key: 'subDomainUrl', value: newBaseUrl);
//     await reInit();
//   }
//
//   // ============ API Methods ============
//   static Future<Result<Map<String, dynamic>>> getData({
//     required String endPoint,
//     String? refreshToken,
//     Map<String, dynamic>? query,
//   }) async {
//     try {
//       final response = await _dio!.get(
//         endPoint,
//         queryParameters: query,
//       );
//
//       if (response.data['statusCode'] == 200) {
//         return Success(response.data);
//       } else {
//         final message = response.data['data']?['message'] ?? 'Unknown error';
//         if (kDebugMode) print(message);
//         return Error(ServerFailure(message));
//       }
//     } on DioException catch (e) {
//       return Error(ServerFailure(handleError(e)));
//     } catch (e) {
//       return Error(ServerFailure(e.toString()));
//     }
//   }
//
//   static Future<Result<Map<String, dynamic>>> postData({
//     required String endPoint,
//     dynamic data,
//   }) async {
//     try {
//       final response = await _dio!.post(
//         endPoint,
//         data: data,
//       );
//
//       if (response.data['statusCode'] == 200) {
//         return Success(response.data);
//       } else {
//         final message = response.data['data']?['message'] ?? 'Unknown error';
//         if (kDebugMode) print(message);
//         return Error(ServerFailure(message));
//       }
//     } on DioException catch (e) {
//       return Error(ServerFailure(handleError(e)));
//     } catch (e) {
//       return Error(ServerFailure(e.toString()));
//     }
//   }
//
//   static Future<Result<Map<String, dynamic>>> putData({
//     required String endPoint,
//     dynamic data,
//   }) async {
//     try {
//       final response = await _dio!.put(
//         endPoint,
//         data: data,
//       );
//
//       if (response.data['statusCode'] == 200) {
//         return Success(response.data);
//       } else {
//         final message = response.data['data']?['message'] ?? 'Unknown error';
//         if (kDebugMode) print(message);
//         return Error(ServerFailure(message));
//       }
//     } on DioException catch (e) {
//       return Error(ServerFailure(handleError(e)));
//     } catch (e) {
//       return Error(ServerFailure(e.toString()));
//     }
//   }
//
//   static Future<Result<Map<String, dynamic>>> patchData({
//     required String? endPoint,
//     required dynamic data,
//   }) async {
//     try {
//       final response = await _dio!.patch(
//         '$endPoint',
//         data: data,
//       );
//
//       if (response.data['statusCode'] == 200) {
//         return Success(response.data);
//       } else {
//         final message = response.data['data']?['message'] ?? 'Unknown error';
//         if (kDebugMode) print(message);
//         return Error(ServerFailure(message));
//       }
//     } on DioException catch (e) {
//       return Error(ServerFailure(handleError(e)));
//     } catch (e) {
//       return Error(ServerFailure(e.toString()));
//     }
//   }
//
//   static Future<Result<Map<String, dynamic>>> deleteData({
//     required String endPoint,
//     dynamic data,
//   }) async {
//     try {
//       final response = await _dio!.delete(
//         endPoint,
//         data: data,
//       );
//
//       if (response.data['statusCode'] == 200) {
//         return Success(response.data);
//       } else {
//         final message = response.data['data']?['message'] ?? 'Unknown error';
//         if (kDebugMode) print(message);
//         return Error(ServerFailure(message));
//       }
//     } on DioException catch (e) {
//       return Error(ServerFailure(handleError(e)));
//     } catch (e) {
//       return Error(ServerFailure(e.toString()));
//     }
//   }
//
//   // ============ Error Handling ============
//   static String handleError(DioException error) {
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//       case DioExceptionType.sendTimeout:
//       case DioExceptionType.receiveTimeout:
//         if (kDebugMode) print('Timeout error: ${error.message}');
//         return error.message ?? 'Connection timeout';
//
//       case DioExceptionType.badResponse:
//         final message = error.response?.data['data']?['message'] ??
//             error.response?.data['message'] ??
//             'Bad response from server';
//         if (kDebugMode) {
//           print('Bad response: ${error.response?.statusCode} - $message');
//         }
//         return message;
//
//       case DioExceptionType.cancel:
//         if (kDebugMode) print('Request cancelled');
//         return 'Request cancelled';
//
//       case DioExceptionType.connectionError:
//         if (kDebugMode) print('Connection error: ${error.message}');
//         return 'No internet connection';
//
//       default:
//         if (kDebugMode) print('Error: ${error.message}');
//         return error.message ?? 'Unknown error occurred';
//     }
//   }
//
//   static Future<void> updateToken(String? token) async {
//     if (token != null) {
//       await CacheHelper.put(key: 'accessToken', value: token);
//     } else {
//       await CacheHelper.remove(key: 'accessToken');
//     }
//     // Update headers for next requests
//     _dio?.options.headers['Authorization'] =
//         token != null ? 'Bearer $token' : null;
//   }
//
// // وأضف دالة جديدة:
//   static Future<void> syncWithTwafokConfig() async {
//     final token = TwafokConfig.getToken();
//     if (token != null) {
//       await updateToken(token);
//     }
//   }
//
//   // ============ Dispose ============
//   static void dispose() {
//     _dio?.close();
//     _dio = null;
//     _isInitialized = false;
//   }
// }

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
  static Future<Result<Map<String, dynamic>>> request({
    required String method,
    required String endpoint,
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

      return Success(_handleResponse(response));
    } on DioException catch (e) {
      return Error(ServerFailure(_handleError(e)));
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }

  // ===================== CRUD METHODS =====================
  static Future<Result<Map<String, dynamic>>> getData({
    required String endPoint,
    Map<String, dynamic>? query,
  }) {
    return request(
      method: 'GET',
      endpoint: endPoint,
      query: query,
    );
  }

  static Future<Result<Map<String, dynamic>>> postData({
    required String endPoint,
    dynamic data,
  }) {
    return request(
      method: 'POST',
      endpoint: endPoint,
      data: data,
    );
  }

  static Future<Result<Map<String, dynamic>>> putData({
    required String endPoint,
    dynamic data,
  }) {
    return request(
      method: 'PUT',
      endpoint: endPoint,
      data: data,
    );
  }

  static Future<Result<Map<String, dynamic>>> patchData({
    required String endPoint,
    dynamic data,
  }) {
    return request(
      method: 'PATCH',
      endpoint: endPoint,
      data: data,
    );
  }

  static Future<Result<Map<String, dynamic>>> deleteData({
    required String endPoint,
    dynamic data,
  }) {
    return request(
      method: 'DELETE',
      endpoint: endPoint,
      data: data,
    );
  }

  // ===================== RESPONSE =====================

  static Map<String, dynamic> _handleResponse(Response response) {
    final data = response.data;

    /// 1. Safety check
    if (data is! Map<String, dynamic>) {
      throw Exception('Invalid response format');
    }

    /// 2. Extract status safely (body OR HTTP fallback)
    final int? bodyStatus = data['statusCode'];
    final int httpStatus = response.statusCode ?? 0;

    final isSuccess =
        (httpStatus == 200 || httpStatus == 201) &&
            (bodyStatus == null || bodyStatus == 200);

    /// 3. Handle error case
    if (!isSuccess) {
      final message =
          data['data']?['message'] ??
              data['message'] ??
              'Unknown error';

      throw Exception(message);
    }

    /// 4. Return normalized data
    return data;
  }

  // ===================== ERROR =====================

  static String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout';

      case DioExceptionType.connectionError:
        return 'No internet connection';

      case DioExceptionType.cancel:
        return 'Request cancelled';

      case DioExceptionType.badResponse:
        final data = error.response?.data;
        if (data is Map) {
          return data['message'] ?? data['data']?['message'] ?? 'Server error';
        }
        return 'Server error';

      default:
        return error.message ?? 'Unknown error';
    }
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
