class CreateContentRequest {
  final int memberId;
  final String body;

  CreateContentRequest({
    required this.memberId,
    required this.body,
  });

  factory CreateContentRequest.fromJson(Map<String, dynamic> json) {
    return CreateContentRequest(
      memberId: json['memberId'] ?? 0,
      body: json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'body': body,
    };
  }
}