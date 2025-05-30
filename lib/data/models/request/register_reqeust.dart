class RegisterRequest {
  final String userId;
  final String password;
  final String name;
  final String statusNote;
  final String petName;
  final String pbirthday;
  final String pgender;

  RegisterRequest({
    required this.userId,
    required this.password,
    required this.name,
    required this.statusNote,
    required this.petName,
    required this.pbirthday,
    required this.pgender,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      userId: json['userId'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      statusNote: json['statusNote'] as String,
      petName: json['petName'] as String,
      pbirthday: json['pbirthday'] as String,
      pgender: json['pgender'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'password': password,
    'name': name,
    'statusNote': statusNote,
    'petName': petName,
    'pbirthday': pbirthday,
    'pgender': pgender,
  };
}