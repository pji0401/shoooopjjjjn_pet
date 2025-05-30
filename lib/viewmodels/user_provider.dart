import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:pawprints/data/repositories/index.dart';
import 'package:pawprints/data/repositories/user_repository.dart';

class UserProvider with ChangeNotifier {
  late final UserRepository _repository;

  UserProvider(this._repository);

  ApiResponse<IdResponse> memberId = ApiResponse.loading();
  ApiResponse<IdResponse> id = ApiResponse.loading();

  late File _image = File("");
  String _selectedDateString = "생년월일 입력";

  File get image => _image;
  String get selectedDateString => _selectedDateString;

  String userId = "";
  String password = "";
  String name = "";
  String statusNote = "";
  String petName = "";
  String pbirthday = "";
  String pgender = "";

  void addImage(File imageFile) {
    _image = imageFile;
    notifyListeners();
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
        _selectedDateString = "${picked.year}.${picked.month.toString().padLeft(2, '0')}.${picked.day.toString().padLeft(2, '0')}";
    }
  }

  Future<void> register({
    required RegisterRequest request,
  }) async {
    memberId = ApiResponse.loading();
    notifyListeners();
    await _repository.register(
      requestBody: request,
      imageFile: _image,
    ).then((response) {
      memberId = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      memberId = ApiResponse.error(error.toString());
    }).whenComplete(() {
      notifyListeners();
    });
  }

  Future<void> login({
    required LoginRequest request,
  }) async {
    id = ApiResponse.loading();
    notifyListeners();
    await _repository.login(
      requestBody: request,
    ).then((response) {
      id = ApiResponse.completed(response.result);
    }).onError((error, stackTrace) {
      id = ApiResponse.error(error.toString());
    }).whenComplete(() {
      notifyListeners();
    });
  }
}