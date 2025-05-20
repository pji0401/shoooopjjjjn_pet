import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';

class MemoryRepository {
  final DioClient _dioClient;

  MemoryRepository(this._dioClient);

  Future<BaseResponse<MemberMemoryResponse>> getMemory(int id) async {
    final request = MemoryEndpoint.getMemory(id);
    return _dioClient.get<MemberMemoryResponse>(
      request.fullPath,
      queryParameters: request.queryParams,
      fromJson: (json) => MemberMemoryResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseResponse<MemoryListResponse>> getMemoryList(int id) async {
    final request = MemoryEndpoint.getMemoryList(id);
    return _dioClient.get<MemoryListResponse>(
      request.fullPath,
      queryParameters: request.queryParams,
      fromJson: (json) => MemoryListResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
