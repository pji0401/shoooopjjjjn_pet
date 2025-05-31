class RegisterRequest {
  final String userId;
  final String password;
  final String name;
  final String statusNote;
  final String petName;
  final String petBirthday;
  final String petGender;

  RegisterRequest({
    required this.userId,
    required this.password,
    required this.name,
    required this.statusNote,
    required this.petName,
    required this.petBirthday,
    required this.petGender,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      userId: json['userId'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      statusNote: json['statusNote'] as String,
      petName: json['petName'] as String,
      petBirthday: json['petBirthday'] as String,
      petGender: json['petGender'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'password': password,
    'name': name,
    'statusNote': statusNote,
    'petName': petName,
    'petBirthday': petBirthday,
    'petGender': petGender,
  };
}