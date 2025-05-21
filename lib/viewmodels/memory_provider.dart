import 'package:flutter/material.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:pawprints/data/models/response/member_memory_response.dart';
import 'package:pawprints/data/repositories/index.dart';

class MemoryProvider with ChangeNotifier {
  late final MemoryRepository _repository;

  MemoryProvider(this._repository);

  ApiResponse<MemberMemoryResponse> memory = ApiResponse.loading();
  ApiResponse<MemoryListResponse> memoryList = ApiResponse.loading();

  Future<void> getMemory(int id) async {
    memory = ApiResponse.loading();
    notifyListeners();
    await _repository.getMemory(id).then((response) {
      memory = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      memory = ApiResponse.error(error.toString());
    }).whenComplete(() {
      notifyListeners();
    });
  }

  Future<void> getMemoryList(int id) async {
    memoryList = ApiResponse.loading();
    notifyListeners();
    await _repository.getMemoryList(id).then((response) {
      memoryList = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      memoryList = ApiResponse.error(error.toString());
    }).whenComplete(() {
      notifyListeners();
    });
  }
}