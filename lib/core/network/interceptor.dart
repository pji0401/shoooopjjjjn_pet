import 'package:dio/dio.dart';
import 'package:pawprints/core/network/index.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.logger.i('REQUEST[${options.data}] => PATH: ${options.path}');
    return super.onRequest(options, handler); // handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.logger.d('RESPONSE[${response.data['result']}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler); // handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.logger.e('ERROR[${err.requestOptions.method}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler); // handler.next(err);
  }
}

// class AuthorizationInterceptor extends Interceptor {
//   final Future<String?> Function() getToken;
//
//   AuthorizationInterceptor({required this.getToken});
//
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     final token = await getToken();
//
//     if (token != null && token.isNotEmpty) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//
//     super.onRequest(options, handler); // handler.next(options);
//   }
// }