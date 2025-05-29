import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:pawprints/data/repositories/index.dart';
import 'package:pawprints/viewmodels/index.dart';

class CommunityProvider with ChangeNotifier implements ImageAttachProvider {
  late final CommunityRepository _repository;

  CommunityProvider(this._repository);

  ApiResponse<IdResponse> contentId = ApiResponse.loading();
  ApiResponse<ContentDetailResponse> contentDetail = ApiResponse.loading();
  ApiResponse<ContentListResponse> wholeContentList = ApiResponse.loading();
  ApiResponse<ContentMemberResponse> memberContentList = ApiResponse.loading();

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

  // FIXME: dispose
  void clearImages() {
    _imageItems.clear();
    notifyListeners();
  }

  Future<void> createContent({
    required ContentCreateRequest request,
  }) async {
    contentId = ApiResponse.loading();
    notifyListeners();
    await _repository.createContent(
      requestBody: request,
      imageFiles: _imageItems,
    ).then((response) {
      contentId = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      contentId = ApiResponse.error(error.toString());
    }).whenComplete(() {
      notifyListeners();
    });
  }

  Future<void> getContentList() async {
    wholeContentList = ApiResponse.loading();
    notifyListeners();
    await _repository.getContentList().then((response) {
      wholeContentList = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      wholeContentList = ApiResponse.error(error.toString());
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
    memberContentList = ApiResponse.loading();
    notifyListeners();
    await _repository.getMemberContent(id).then((response) {
      memberContentList = ApiResponse.completed(response.result);
      notifyListeners();
    }).onError((error, stackTrace) {
      memberContentList = ApiResponse.error(error.toString());
    }).whenComplete(() {
      notifyListeners();
    });
  }
}