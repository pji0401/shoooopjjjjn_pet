import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/config/config.dart';

class UserEndpoint {
  static const String _userPath = '${Constants.baseUrl}/members';

  static ApiRequest register({
    required Map<String, dynamic> requestBody,
    Map<String, dynamic>? formData,
  }) =>
      ApiRequest(
        path: '$_userPath/join',
        body: requestBody,
        formData: formData,
      );

  static ApiRequest login({
    required Map<String, dynamic> requestBody,
  }) =>
      ApiRequest(
        path: '$_userPath/login',
        body: requestBody,
      );
}