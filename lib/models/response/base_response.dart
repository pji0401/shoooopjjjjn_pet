import 'dart:ffi';

class BaseResponse<T> {
  Bool isSuccess;
  String message;
  String code;
  T data;

  BaseResponse({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json, BaseObject target) {
    return BaseResponse(
      isSuccess: json['isSuccess'],
      code: json['code'],
      message: json['message'],
      data: target.fromJson(json['data']),
    );
  }
}

abstract class BaseObject<T> {
  T fromJson(json);
}