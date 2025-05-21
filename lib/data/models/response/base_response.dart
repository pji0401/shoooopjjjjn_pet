// import 'package:pawprints/core/network/index.dart';

class BaseResponse<T> {
  bool isSuccess;
  String message;
  String code;
  T? result;

  BaseResponse({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic) fromJson,
      ) {
    return BaseResponse(
      isSuccess: json['isSuccess'],
      code: json['code'],
      message: json['message'],
      result: json.containsKey('result') ? fromJson(json['result']) : null,
    );
  }
}