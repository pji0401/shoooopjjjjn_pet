import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/config/config.dart';

class CommunityEndpoint {
  static const String _communityPath = '${Constants.baseUrl}/contents';

  static ApiRequest createContent({
    required Map<String, dynamic> requestBody,
    required Map<String, dynamic> formData,
  }) =>
      ApiRequest(
        path: '$_communityPath',
        body: requestBody,
        formData: formData,
      );

  static ApiRequest editContent({
    required Map<String, dynamic> requestBody,
    required Map<String, dynamic> formData,
  }) =>
      ApiRequest(
        path: '$_communityPath',
        body: requestBody,
        formData: formData,
      );

  // FIXME: 오늘의 미션 (중복)
  static ApiRequest getContentList() => ApiRequest(
        path: '$_communityPath',
      );

  static ApiRequest getDetailContent(int id) => ApiRequest(
        path: '$_communityPath/:id',
        pathParams: {'id': id},
      );

  static ApiRequest getMemberContent(int id) => ApiRequest(
        path: '$_communityPath/members/:id',
        pathParams: {'id': id},
      );

  static ApiRequest deleteContent(int id) => ApiRequest(
        path: '$_communityPath/:id',
        pathParams: {'id': id},
      );
}
