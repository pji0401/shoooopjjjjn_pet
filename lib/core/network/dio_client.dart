import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/config/index.dart';

class DioClient {
  late final Dio _dio;
  final Connectivity _connectivity;

  DioClient() : _connectivity = Connectivity() {
    _dio = Dio(BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: Constants.connectTimeout,
      receiveTimeout: Constants.receiveTimeout,
      headers: {'Accept': '*/*'},
      contentType: 'application/json',
      responseType: ResponseType.json,
    ));
    _dio.interceptors.addAll([
      LoggerInterceptor(),
      // FIXME: 토큰 인터셉터 추가 (인증 절차 필요)
      // AuthorizationInterceptor(getToken: () async => 'token')
    ]);
  }

  Future<bool> _checkInternetConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult.any((result) => result != ConnectivityResult.none);
    // return connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi);
  }

  Future<BaseResponse<T>> get<T>({
    required ApiRequest request,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      await _ensureInternet();
      final response = await _dio.get(
        request.fullPath,
        queryParameters: request.queryParams,
        options: Options(contentType: 'application/json'),
      );
      return _handleBaseResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleDioError<T>(e, fromJson);
    }
  }

  Future<BaseResponse<T>> post<T>({
    required ApiRequest request,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      await _ensureInternet();
      final response = await _dio.post(
        request.fullPath,
        data: request.body,
        queryParameters: request.queryParams,
        options: Options(contentType: 'application/json'),
      );
      return _handleBaseResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleDioError<T>(e, fromJson);
    }
  }

  Future<BaseResponse<T>> put<T>({
    required ApiRequest request,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      await _ensureInternet();
      final response = await _dio.put(
        request.fullPath,
        data: request.body,
        queryParameters: request.queryParams,
        options: Options(contentType: 'application/json'),
      );
      return _handleBaseResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleDioError<T>(e, fromJson);
    }
  }

  Future<BaseResponse<T>> patch<T>({
    required ApiRequest request,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      await _ensureInternet();
      final response = await _dio.patch(
        request.fullPath,
        data: request.body,
        queryParameters: request.queryParams,
        options: Options(contentType: 'application/json'),
      );
      return _handleBaseResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleDioError<T>(e, fromJson);
    }
  }

  Future<BaseResponse<T>> delete<T>({
    required ApiRequest request,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      await _ensureInternet();
      final response = await _dio.delete(
        request.fullPath,
        queryParameters: request.queryParams,
        options: Options(contentType: 'application/json'),
      );
      return _handleBaseResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleDioError<T>(e, fromJson);
    }
  }

  Future<void> _ensureInternet() async {
    if (!await _checkInternetConnection()) {
      AppLogger.logger.w('No internet connection');
      throw NoInternetException('인터넷 연결이 없습니다.');
    }
  }

  BaseResponse<T> _handleBaseResponse<T>(
    Response response,
    T Function(dynamic) fromJson,
  ) {
    final data = response.data;
    final parsed = BaseResponse<T>.fromJson(data, fromJson);
    if (!parsed.isSuccess) {
      throw FetchDataException(parsed.message);
    }
    return parsed;
  }

  BaseResponse<T> _handleDioError<T>(
    DioException e,
    T Function(dynamic) fromJson,
  ) {
    AppLogger.logger.e('Dio Error: ${e.message}');
    if (e.response != null) {
      final errorData = e.response!.data;
      try {
        final errorParsed = BaseResponse<T>.fromJson(errorData, fromJson);
        throw FetchDataException(errorParsed.message);
      } catch (_) {
        throw _handleError(e);
      }
    } else {
      throw _handleError(e);
    }
  }

  // TODO: 임시 에러 상태 처리
  ApiException _handleError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode ?? 500;
      final message = e.response!.data.toString();
      switch (statusCode) {
        case 400:
          return BadRequestException(message);
        case 401:
          return UnauthorisedException(message);
        case 403:
          return ForbiddenException(message);
        case 404:
          return NotFoundException(message);
        case 500:
          return InternalServerError(message);
        default:
          return FetchDataException('서버 통신 중 오류가 발생했습니다.');
      }
    } else {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return FetchDataException('요청 시간이 초과되었습니다.');
        case DioExceptionType.cancel:
          return FetchDataException('요청이 취소되었습니다.');
        case DioExceptionType.connectionError:
          return FetchDataException('서버에 연결할 수 없습니다.');
        default:
          return FetchDataException('알 수 없는 오류가 발생했습니다.');
      }
    }
  }
}

extension DioClientMultipart on DioClient {
  Future<BaseResponse<T>> uploadFiles<T>({
    required ApiRequest request,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      await _ensureInternet();
      final formDataMap = <String, dynamic>{};
      if (request.body != null) {
        formDataMap['request'] = jsonEncode(request.body);
      }
      if (request.formData != null) {
        formDataMap.addAll(request.formData!);
      }
      final formData = FormData.fromMap(formDataMap);
      final response = await _dio.post(
        request.fullPath,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      return _handleBaseResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleDioError<T>(e, fromJson);
    }
  }
}