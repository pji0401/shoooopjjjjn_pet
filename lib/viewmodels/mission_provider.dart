import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:pawprints/data/repositories/index.dart';

class MissionProvider with ChangeNotifier {
  late final MissionRepository _repository;

  MissionProvider(this._repository);

  ApiResponse<MissionGetResponse> mission = ApiResponse.loading();
  ApiResponse<IdResponse> compeltedMissionId = ApiResponse.loading();

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

  Future<void> completeMission({
    required MissionCompleteRequest request,
    required File imageFile,
  }) async {
    compeltedMissionId = ApiResponse.loading();
    notifyListeners();
    _repository.completeMission(
      requestBody: request,
      imageFile: imageFile,
    ).then((response) {
      compeltedMissionId = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      compeltedMissionId = ApiResponse.error(error.toString());
    }).whenComplete(() {
      notifyListeners();
    });
  }
}