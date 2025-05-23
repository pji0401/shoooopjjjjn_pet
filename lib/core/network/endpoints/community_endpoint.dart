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

  static ApiRequest getDetailContent(int id) => ApiRequest(
        path: '$_communityPath/:id',
        pathParams: {'id': id},
      );

  static ApiRequest getMemberContent(int id) => ApiRequest(
        path: '$_communityPath/members/:id',
        pathParams: {'id': id},
      );
}