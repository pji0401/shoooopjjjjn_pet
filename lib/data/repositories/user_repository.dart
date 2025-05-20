import 'dart:io';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:http_parser/http_parser.dart';

class UserRepository {
  final DioClient _dioClient;

  UserRepository(this._dioClient);

  Future<BaseResponse<IdResponse>> register({
    required RegisterRequest requestBody,
    required File imageFile,
  }) async {
    final multipartFile = await MultipartFile.fromFile(
      imageFile.path,
      filename: imageFile.path.split('/').last,
      contentType: MediaType('image', 'png'),
    );

    final request = UserEndpoint.register(
      requestBody: requestBody.toJson(),
      formData: {'images': multipartFile},
    );

    return _dioClient.uploadFiles<IdResponse>(
      request: request,
      fromJson: (json) => IdResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseResponse<IdResponse>> login({
    required LoginRequest requestBody,
  }) async {
    final request = UserEndpoint.login(requestBody: requestBody.toJson());
    return _dioClient.uploadFiles<IdResponse>(
      request: request,
      fromJson: (json) => IdResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}