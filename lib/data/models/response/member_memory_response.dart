class MemberMemoryResponse {
  final int id;
  final String body;
  final String date;
  final int count;
  final List<String> images;

  MemberMemoryResponse({
    required this.id,
    required this.body,
    required this.date,
    required this.count,
    required this.images,
  });

  factory MemberMemoryResponse.fromJson(Map<String, dynamic> json) {
    return MemberMemoryResponse(
      id: json['id'] ?? 0,
      body: json['body'] ?? '',
      date: json['date'] ?? '',
      count: json['count'] ?? 0,
      images: List<String>.from(json['images'] ?? []),
    );
  }
}