import 'package:pawprints/screens/community/common.dart';
import 'package:pawprints/utils/index.dart';

class ContentListResponse {
  final List<Content> contents;

  ContentListResponse({required this.contents});

  factory ContentListResponse.fromJson(Map<String, dynamic> json) {
    return ContentListResponse(
      contents: (json['contents'] as List<dynamic>?)?.map((item) => Content.fromJson(item)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contents': contents.map((item) => item.toJson()).toList(),
    };
  }
}

class Content {
  final int memberId;
  final String name;
  final String profile;
  final int contentId;
  final List<String> images;
  final String body;
  final DateTime createdAt;
  final int likesCount;
  final int commentsCount;

  Content({
    required this.memberId,
    required this.name,
    required this.profile,
    required this.contentId,
    required this.images,
    required this.body,
    required this.createdAt,
    required this.likesCount,
    required this.commentsCount,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      memberId: json['memberId'] ?? 0,
      name: json['name'] ?? '',
      profile: json['profile'] ?? '',
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
      'memberId': memberId,
      'name': name,
      'profile': profile,
      'contentId': contentId,
      'images': images,
      'body': body,
      'createdAt': createdAt.toIso8601String(),
      'likesCount': likesCount,
      'commentsCount': commentsCount,
    };
  }
}

// Note: Mapper
extension ContentMapper on Content {
  Article toArticle() {
    return Article(
      authorProfileImageUrl: profile,
      authorName: name,
      timeAgo: formatTimeAgo(createdAt),
      contentImageUrls: images,
      contentText: body,
      likeCount: likesCount,
      commentCount: commentsCount,
    );
  }
}