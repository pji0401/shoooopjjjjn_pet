import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/config/config.dart';

class PlanEndpoint {
  static const String _planPath = '${Constants.baseUrl}/plans';

  static ApiRequest createPlan({
    required Map<String, dynamic> requestBody,
  }) =>
      ApiRequest(
        path: '$_planPath',
        body: requestBody,
      );

  static ApiRequest getPlanList({
    required Map<String, dynamic> requestBody,
  }) =>
      ApiRequest(
        path: '$_planPath',
        body: requestBody,
      );

  static ApiRequest check(int id) => ApiRequest(
        path: '$_planPath/:id/check',
        pathParams: {'id': id},
      );
}