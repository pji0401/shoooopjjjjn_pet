import 'package:flutter/material.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:pawprints/data/repositories/index.dart';

class HomeProvider with ChangeNotifier {
  late final HomeRepository _repository;

  HomeProvider(this._repository);

  ApiResponse<HomeTitleResponse> title = ApiResponse.loading();
  ApiResponse<MissionGetResponse> mission = ApiResponse.loading();

  Future<void> getTitle(int id) async {
    title = ApiResponse.loading();
    notifyListeners();
    await _repository.getTitle(id).then((response) {
      title = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      title = ApiResponse.error(error.toString());
    }).whenComplete(() {
      notifyListeners();
    });
  }

  Future<void> getMission(int id) async {
    mission = ApiResponse.loading();
    notifyListeners();
    await _repository.getMission(id).then((response) {
      mission = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      mission = ApiResponse.error(error.toString());
    }).whenComplete(() {
      notifyListeners();
    });
  }
}