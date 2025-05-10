abstract final class Constants {
  static const baseUrl = "https://localhost:{PORT}/";
  static const someEndPoint = '$baseUrl/some';
  static const pretendard = "Pretendard";
  static const timeout = Duration(seconds: 7);
  static const connectTimeout = Duration(seconds: 10);
  static const receiveTimeout = Duration(seconds: 15);
  static const sendTimeout = Duration(seconds: 5);
}