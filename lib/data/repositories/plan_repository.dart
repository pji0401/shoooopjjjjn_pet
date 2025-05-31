import 'package:pawprints/core/network/endpoints/plan_endpoint.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';

class PlanRepository {
  final DioClient _dioClient;

  PlanRepository(this._dioClient);

  Future<BaseResponse<PlanListResponse>> getPlanList({
    required PlanListRequest requestBody
  }) async {
    final request = PlanEndpoint.getPlanList(requestBody: requestBody.toJson());
    return _dioClient.post<PlanListResponse>(
      request: request,
      fromJson: (json) => PlanListResponse.fromJson(json as Map<String, dynamic>),
    );
  }
  Future<BaseResponse<IdResponse>> check(int id) async {
    final request = PlanEndpoint.check(id);
    return _dioClient.post<IdResponse>(
      request: request,
      fromJson: (json) => IdResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}