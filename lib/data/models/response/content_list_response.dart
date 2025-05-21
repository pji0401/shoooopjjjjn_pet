class ContentListResponse {
  final int contentId;
  final List<String> images;
  final String body;
  final DateTime createdAt;
  final int likesCount;
  final int commentsCount;

  ContentListResponse({
    required this.contentId,
    required this.images,
    required this.body,
    required this.createdAt,
    required this.likesCount,
    required this.commentsCount,
  });

  factory ContentListResponse.fromJson(Map<String, dynamic> json) {
    return ContentListResponse(
      contentId: json['contentId'] ?? 0,
      images: List<String>.from(json['images'] ?? []),
      body: json['body'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      likesCount: json['likesCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contentId': contentId,
      'images': images,
      'body': body,
      'createdAt': createdAt.toIso8601String(),
      'likesCount': likesCount,
      'commentsCount': commentsCount,
    };
  }
}