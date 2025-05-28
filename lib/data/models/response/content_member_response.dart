class ContentMemberResponse {
  final String name;
  final String? profile;
  final String statusNote;
  final List<ContentListItem> contents;

  ContentMemberResponse({
    required this.name,
    required this.profile,
    required this.statusNote,
    required this.contents,
  });

  factory ContentMemberResponse.fromJson(Map<String, dynamic> json) {
    return ContentMemberResponse(
      name: json['name'],
      profile: json['profile'],
      statusNote: json['statusNote'],
      contents: (json['contents'] as List<dynamic>)
          .map((e) => ContentListItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profile': profile,
      'statusNote': statusNote,
      'contents': contents.map((e) => e.toJson()).toList(),
    };
  }
}

class ContentListItem {
  final int contentId;
  final List<String> images;
  final String body;
  final DateTime createdAt;
  final int likesCount;
  final int commentsCount;

  ContentListItem({
    required this.contentId,
    required this.images,
    required this.body,
    required this.createdAt,
    required this.likesCount,
    required this.commentsCount,
  });

  factory ContentListItem.fromJson(Map<String, dynamic> json) {
    return ContentListItem(
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