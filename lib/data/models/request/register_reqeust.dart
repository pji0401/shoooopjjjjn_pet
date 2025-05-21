class RegisterRequest {
  final String userId;
  final String password;
  final String name;
  final String statusNote;

  RegisterRequest({
    required this.userId,
    required this.password,
    required this.name,
    required this.statusNote,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      userId: json['userId'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      statusNote: json['statusNote'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'password': password,
    'name': name,
    'statusNote': statusNote,
  };
}