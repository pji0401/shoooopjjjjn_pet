import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/config/config.dart';

class MissionEndpoint {
  static const String _missionPath = '${Constants.baseUrl}/missions';

  static ApiRequest completeMission({
    required Map<String, dynamic> requestBody,
    required Map<String, dynamic> formData,
  }) =>
      ApiRequest(
        path: '$_missionPath/complete',
        body: requestBody,
        formData: formData,
      );

  static ApiRequest getMission(int id) => ApiRequest(
        path: '$_missionPath/:id',
        pathParams: {'id': id},
      );
}