class MemoryListResponse {
  final int id;
  final String body;
  final String date;
  final int count;
  final String media;

  MemoryListResponse({
    required this.id,
    required this.body,
    required this.date,
    required this.count,
    required this.media,
  });

  factory MemoryListResponse.fromJson(Map<String, dynamic> json) {
    return MemoryListResponse(
      id: json['id'] ?? 0,
      body: json['body'] ?? '',
      date: json['date'] ?? '',
      count: json['count'] ?? 0,
      media: json['media'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'date': date,
      'count': count,
      'media': media,
    };
  }
}