import 'package:pawprints/utils/index.dart';

class ApiResponse<T> {
  UIState? uiState;
  T? data;
  String? message;

  ApiResponse({this.uiState, this.data, this.message});

  ApiResponse.loading() : uiState = UIState.LOADING;

  ApiResponse.completed(this.data) : uiState = UIState.COMPLETED;

  ApiResponse.error(this.message) : uiState = UIState.ERROR;

  @override
  String toString() {
    return "Status: $uiState\nMessage: $message\nData: $data";
  }
}