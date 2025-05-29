import 'package:flutter/material.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:pawprints/data/repositories/index.dart';

class PlanProvider with ChangeNotifier {
  late final PlanRepository _repository;

  PlanProvider(this._repository);

  ApiResponse<IdResponse> isCheck = ApiResponse.loading();
  ApiResponse<PlanListResponse> planList = ApiResponse.loading();

  Future<void> check(int id) async {
    isCheck = ApiResponse.loading();
    notifyListeners();
    await _repository.check(id).then((response) {
      isCheck = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      isCheck = ApiResponse.error(error.toString());
    }).whenComplete(() {
      notifyListeners();
    });
  }

  Future<void> getPlanList({
    required PlanListRequest request,
  }) async {
    planList = ApiResponse.loading();
    notifyListeners();
    await _repository.getPlanList(requestBody: request).then((response) {
      planList = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      planList = ApiResponse.error(error.toString());
    }).whenComplete(() {
      notifyListeners();
    });
  }
}