class LoginRequest {
  final String userId;
  final String password;

  LoginRequest({
    required this.userId,
    required this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      userId: json['userId'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'password': password,
  };
}