import 'dart:io';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:http_parser/http_parser.dart';

class MissionRepository {
  final DioClient _dioClient;

  MissionRepository(this._dioClient);

  Future<BaseResponse<IdResponse>> completeMission({
    required MissionCompleteRequest requestBody,
    required File imageFile,
  }) async {
    final multipartFile = await MultipartFile.fromFile(
      imageFile.path,
      filename: imageFile.path.split('/').last,
      contentType: MediaType('image', 'png'),
    );

    final request = MissionEndpoint.completeMission(
      requestBody: requestBody.toJson(),
      formData: {'images': multipartFile},
    );

    return _dioClient.uploadFiles<IdResponse>(
      request: request,
      fromJson: (json) => IdResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseResponse<MissionGetResponse>> getMission(int id) async {
    final request = MissionEndpoint.getMission(id);
    return _dioClient.get<MissionGetResponse>(
      request.fullPath,
      queryParameters: request.queryParams,
      fromJson: (json) => MissionGetResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}