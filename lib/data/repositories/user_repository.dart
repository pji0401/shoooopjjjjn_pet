import 'dart:io';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';

class UserRepository {
  final DioClient _dioClient;

  UserRepository(this._dioClient);

  Future<BaseResponse<IdResponse>> register({
    required RegisterRequest requestBody,
    required File? imageFile,
  }) async {
    final formDataMap = <String, dynamic>{
      'joinDto': jsonEncode(requestBody.toJson()),
    };

    if (imageFile != null) {
      final multipartFile = await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
        contentType: MediaType('image', 'png'),
      );
      formDataMap['profileImage'] = multipartFile;
    }

    final request = UserEndpoint.register(
      requestBody: null,
      formData: formDataMap,
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
    return _dioClient.post<IdResponse>(
      request: request,
      fromJson: (json) => IdResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}