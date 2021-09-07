import 'package:dio/dio.dart';

import '../../utils/logger.dart';

final _logger = getLogger('API');

class ApiLoggerInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    _logger.e('RESPONSE ${err.type}');
    _logger.e(err.message);
    _logger.e(err.response);

    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger
        .i('REQUEST ${options.method.toUpperCase()} ${options.uri.toString()}');
    _logger.i('${options.data}');

    return handler.next(options);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    _logger.i(
        'RESPONSE, Status: ${response.statusCode}, ${response.statusMessage}');
    _logger.i(response.data);

    return handler.next(response);
  }
}
