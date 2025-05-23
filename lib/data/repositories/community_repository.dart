import 'dart:io';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:http_parser/http_parser.dart';

class CommunityRepository {
  final DioClient _dioClient;

  CommunityRepository(this._dioClient);

  Future<BaseResponse<IdResponse>> createContent({
    required ContentCreateRequest requestBody,
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

  Future<BaseResponse<ContentDetailResponse>> getDetailContent(int id) async {
    final request = CommunityEndpoint.getDetailContent(id);
    return _dioClient.get<ContentDetailResponse>(
      request: request,
      fromJson: (json) => ContentDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseResponse<ContentListResponse>> getMemberContent(int id) async {
    final request = CommunityEndpoint.getMemberContent(id);
    return _dioClient.get<ContentListResponse>(
      request: request,
      fromJson: (json) => ContentListResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
