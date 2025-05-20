import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:pawprints/data/repositories/index.dart';

class CommunityProvider with ChangeNotifier {
  late final CommunityRepository _repository;

  CommunityProvider(this._repository);

  ApiResponse<IdResponse> contentId = ApiResponse.loading();
  ApiResponse<ContentDetailResponse> contentDetail = ApiResponse.loading();
  ApiResponse<ContentListResponse> contentList = ApiResponse.loading();

  Future<void> createContent({
    required CreateContentRequest request,
    required File imageFile,
  }) async {
    contentId = ApiResponse.loading();
    notifyListeners();
    _repository.createContent(
      requestBody: request,
      imageFile: imageFile,
    ).then((response) {
      contentId = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      contentId = ApiResponse.error(error.toString());
    }).whenComplete(() {
      notifyListeners();
    });
  }

  Future<void> getDetailContent(int id) async {
    contentDetail = ApiResponse.loading();
    notifyListeners();
    await _repository.getDetailContent(id).then((response) {
      contentDetail = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      contentDetail = ApiResponse.error(error.toString());
    }).whenComplete(() {
      notifyListeners();
    });
  }

  Future<void> getMemberContent(int id) async {
    contentList = ApiResponse.loading();
    notifyListeners();
    await _repository.getMemberContent(id).then((response) {
      contentList = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      contentList = ApiResponse.error(error.toString());
    }).whenComplete(() {
      notifyListeners();
    });
  }
}