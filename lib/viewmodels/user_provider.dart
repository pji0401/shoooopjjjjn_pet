import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:pawprints/data/repositories/index.dart';
import 'package:pawprints/data/repositories/user_repository.dart';

class UserProvider with ChangeNotifier {
  late final UserRepository _repository;

  UserProvider(this._repository);

  ApiResponse<IdResponse> id = ApiResponse.loading();
  ApiResponse<IdResponse> userId = ApiResponse.loading();

  Future<void> register({
    required RegisterRequest request,
    required File imageFile,
  }) async {
    id = ApiResponse.loading();
    notifyListeners();
    _repository.register(
      requestBody: request,
      imageFile: imageFile,
    ).then((response) {
      id = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      id = ApiResponse.error(error.toString());
    }).whenComplete(() {
      notifyListeners();
    });
  }

  Future<void> login({
    required LoginRequest request,
  }) async {
    userId = ApiResponse.loading();
    notifyListeners();
    _repository.login(
      requestBody: request,
    ).then((response) {
      userId = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      userId = ApiResponse.error(error.toString());
    }).whenComplete(() {
      notifyListeners();
    });
  }
}