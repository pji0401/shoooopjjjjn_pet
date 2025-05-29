import 'package:pawprints/core/network/endpoints/home_endpoint.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';

class HomeRepository {
  final DioClient _dioClient;

  HomeRepository(this._dioClient);

  Future<BaseResponse<HomeTitleResponse>> getTitle(int id) async {
    final request = HomeEndpoint.getTitle(id);
    return _dioClient.get<HomeTitleResponse>(
      request: request,
      fromJson: (json) => HomeTitleResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseResponse<MissionGetResponse>> getMission(int id) async {
    final request = HomeEndpoint.getMission(id);
    return _dioClient.get<MissionGetResponse>(
      request: request,
      fromJson: (json) => MissionGetResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}