class ContentCreateRequest {
  final int memberId;
  final String body;

  ContentCreateRequest({
    required this.memberId,
    required this.body,
  });

  factory ContentCreateRequest.fromJson(Map<String, dynamic> json) {
    return ContentCreateRequest(
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