class MissionCreateRequest {
  final String memberId;
  final String title;
  final String description;

  MissionCreateRequest({
    required this.memberId,
    required this.title,
    required this.description,
  });

  factory MissionCreateRequest.fromJson(Map<String, dynamic> json) {
    return MissionCreateRequest(
      memberId: json['memberId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'memberId': memberId,
    'title': title,
    'description': description,
  };
}