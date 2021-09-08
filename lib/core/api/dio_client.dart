import 'dart:io';

import 'package:dio/dio.dart';
import 'package:product_hunt/core/api/endpoints.dart';
import 'package:product_hunt/core/credentials.dart';
import 'package:product_hunt/core/resources/strings.dart';
import 'package:product_hunt/core/utils/logger.dart';

import 'api_response.dart';
import 'interceptors/api_logger_interceptor.dart';

class DioClient {
  DioClient._() {
    _initialize();
  }
  static final DioClient _dioClient = DioClient._();
  static DioClient get instance => _dioClient;

  late Dio _dio;
  Dio get dio => _dio;

  void _initialize() {
    _dio = Dio(
      BaseOptions(
        baseUrl: kBasrUrl,
        headers: headers,
      ),
    )..interceptors.add(ApiLoggerInterceptor());
  }

  Map<String, String> get headers =>
      <String, String>{'Authorization': 'Bearer $kAccessToken'};

  void refresh() => _initialize();

  ApiResponse<T> handleExceptions<T>(Object exception, String className) {
    final log = getLogger(className);
    log.e(exception);

    if (exception is DioError) {
      switch (exception.type) {
        case DioErrorType.response:
          return ApiResponse.error(
              exception.response?.data['message'] as String);

        case DioErrorType.other:
          if (exception.error is SocketException)
            return ApiResponse.error(kPoorConnectivityMessage);

          break;
        default:
      }
    }

    return ApiResponse.error(kSomethingWentWrongMessage);
  }
}
