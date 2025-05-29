import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/config/config.dart';

class HomeEndpoint {
  static const String _homePath = '${Constants.baseUrl}/home';

  static ApiRequest getTitle(int id) => ApiRequest(
        path: '$_homePath/:id',
        pathParams: {'id': id},
      );

  static ApiRequest getMission(int id) => ApiRequest(
        path: '$_homePath/:id/missions',
        pathParams: {'id': id},
      );
}