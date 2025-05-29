import 'dart:io';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:http_parser/http_parser.dart';

class CommunityRepository {
  final DioClient _dioClient;

  CommunityRepository(this._dioClient);

  Future<BaseResponse<IdResponse>> createContent({
    required ContentCreateRequest requestBody,
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

    final request = CommunityEndpoint.createContent(
      requestBody: requestBody.toJson(),
      formData: formDatas,
    );

    return _dioClient.uploadFiles<IdResponse>(
      request: request,
      fromJson: (json) => IdResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseResponse<ContentListResponse>> getContentList() async {
    final request = CommunityEndpoint.getContentList();
    return _dioClient.get<ContentListResponse>(
      request: request,
      fromJson: (json) => ContentListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseResponse<ContentDetailResponse>> getDetailContent(int id) async {
    final request = CommunityEndpoint.getDetailContent(id);
    return _dioClient.get<ContentDetailResponse>(
      request: request,
      fromJson: (json) => ContentDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseResponse<ContentMemberResponse>> getMemberContent(int id) async {
    final request = CommunityEndpoint.getMemberContent(id);
    return _dioClient.get<ContentMemberResponse>(
      request: request,
      fromJson: (json) => ContentMemberResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
