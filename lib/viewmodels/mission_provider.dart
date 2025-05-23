import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:pawprints/data/models/request/mission_create_request.dart';
import 'package:pawprints/data/repositories/index.dart';
import 'package:pawprints/viewmodels/index.dart';

class MissionProvider with ChangeNotifier implements ImageAttachProvider {
  late final MissionRepository _repository;

  MissionProvider(this._repository);

  ApiResponse<IdResponse> createdMission = ApiResponse.loading();
  ApiResponse<MissionGetResponse> mission = ApiResponse.loading();
  ApiResponse<IdResponse> compeltedMissionId = ApiResponse.loading();

  final List<File> _imageItems = [];

  List<File> get images => List.unmodifiable(_imageItems);
  int get imageItemCount => _imageItems.length;
  int get maxImageCount => 10;

  void addImage(File imageFile) {
    if (maxImageCount >= imageItemCount) {
      _imageItems.add(imageFile);
      notifyListeners();
    }
  }

  void removeImage(File? imageFile) {
    _imageItems.remove(imageFile);
    notifyListeners();
  }

  void clearImages() {
    _imageItems.clear();
    notifyListeners();
  }

  Future<void> createMission({
    required MissionCreateRequest request,
  }) async {
    createdMission = ApiResponse.loading();
    notifyListeners();
    await _repository.createMission(requestBody: request).then((response) {
      createdMission = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      createdMission = ApiResponse.error(error.toString());
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

  Future<void> completeMission({
    required MissionCompleteRequest request
  }) async {
    compeltedMissionId = ApiResponse.loading();
    notifyListeners();
    await _repository.completeMission(
      requestBody: request,
      imageFiles: _imageItems,
    ).then((response) {
      compeltedMissionId = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      compeltedMissionId = ApiResponse.error(error.toString());
    }).whenComplete(() {
      notifyListeners();
    });
  }
}