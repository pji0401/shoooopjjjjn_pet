import 'dart:io';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pawprints/data/models/request/mission_create_request.dart';

class MissionRepository {
  final DioClient _dioClient;

  MissionRepository(this._dioClient);

  Future<BaseResponse<IdResponse>> completeMission({
    required MissionCompleteRequest requestBody,
    required List<File> imageFiles,
  }) async {
    final List<MultipartFile> multipartFiles = await Future.wait(
      imageFiles.map((file) async {
        return await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType('image', 'png'),
        );
      }).toList(),
    );
    final formDatas = {'images': multipartFiles};

    final request = MissionEndpoint.completeMission(
      requestBody: requestBody.toJson(),
      formData: formDatas,
    );

    return _dioClient.uploadFiles<IdResponse>(
      request: request,
      fromJson: (json) => IdResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseResponse<MissionGetResponse>> getMission(int id) async {
    final request = MissionEndpoint.getMission(id);
    return _dioClient.get<MissionGetResponse>(
      request: request,
      fromJson: (json) => MissionGetResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseResponse<IdResponse>> createMission({
    required MissionCreateRequest requestBody,
  }) async {
    final request = MissionEndpoint.createMission(requestBody: requestBody.toJson());
    return _dioClient.post<IdResponse>(
      request: request,
      fromJson: (json) => IdResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}