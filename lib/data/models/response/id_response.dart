class IdResponse {
  final int id;

  IdResponse({
    required this.id,
  });

  factory IdResponse.fromJson(Map<String, dynamic> json) {
    return IdResponse(
      id: json['id'] as int,
    );
  }
}