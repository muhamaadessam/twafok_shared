import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logscope_flutter/logscope_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../error/failure.dart';
import '../local/cache_helper.dart';

export 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static Future<void> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl:
            CacheHelper.get(key: 'subDomainUrl') ?? 'https://twafok.com/api/',
        receiveDataWhenStatusError: true,
        headers: headers,
      ),
    )..interceptors.addAll([
        if (kDebugMode)
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            // maxWidth: 90,
          ),
        Logscope.dioInterceptor()
      ]);
  }

  static void reInit() {
    init();
  }

  static Map<String, String> get headers => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${CacheHelper.get(key: 'accessToken')}",
      };

  static Future<Either<Failure, Map<String, dynamic>>> getData({
    required String endPoint,
    String? refreshToken,
    Map<String, dynamic>? query,
  }) async {
    final response = await dio!.get(
      endPoint,
      queryParameters: query,
    );
    if (response.data['statusCode'] == 200) {
      return Right(response.data);
    } else {
      debugPrint(response.data['data']['message']);
      return Left(ServerFailure(response.data['data']['message']));
    }
  }

  static Future<Either<Failure, Map<String, dynamic>>> patchData({
    required String? endPoint,
    required dynamic data,
  }) async {
    final response = await dio!.patch(
      '$endPoint',
      data: data,
    );
    if (response.data['statusCode'] == 200) {
      return Right(response.data);
    } else {
      debugPrint(response.data['data']['message']);
      return Left(ServerFailure(response.data['data']['message']));
    }
  }

  static Future<Either<Failure, Map<String, dynamic>>> postData({
    required String endPoint,
    dynamic data,
  }) async {
    final response = await dio!.post(
      endPoint,
      data: data,
    );
    if (response.data['statusCode'] == 200) {
      return Right(response.data);
    } else {
      debugPrint(response.data['data']['message']);
      return Left(ServerFailure(response.data['data']['message']));
    }
  }

  static Future<Either<Failure, Map<String, dynamic>>> putData({
    required String endPoint,
    dynamic data,
  }) async {
    final response = await dio!.put(
      endPoint,
      data: data,
    );

    if (response.data['statusCode'] == 200) {
      return Right(response.data);
    } else {
      debugPrint(response.data['data']['message']);
      return Left(ServerFailure(response.data['data']['message']));
    }
  }

  static Future<Either<Failure, Map<String, dynamic>>> deleteData({
    required String endPoint,
    dynamic data,
  }) async {
    final response = await dio!.delete(
      endPoint,
      data: data,
    );

    if (response.data['statusCode'] == 200) {
      return Right(response.data);
    } else {
      debugPrint(response.data['data']['message']);
      return Left(ServerFailure(response.data['data']['message']));
    }
  }

  /// Centralized error handling
  static String handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        debugPrint('Timeout error: ${error.message}');
        return error.message ?? 'Timeout error';
      case DioExceptionType.badResponse:
        debugPrint('Bad response: ${error.response?.statusCode}');
        return error.response?.data['data']?['data']['message'] ??
            'Bad response';
      case DioExceptionType.cancel:
        debugPrint('Request cancelled');
        return 'Request cancelled';
      default:
        debugPrint('Error: ${error.message}');
        return 'Error: ${error.message}';
    }
  }
}
