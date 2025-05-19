import 'package:flutter/material.dart';

// 05.08 - TODO: 리팩토링 (Article 모델 관리)
// lib/models/article.dart (예시 경로)
/// 게시글 데이터 모델.
///
/// 커뮤니티 피드에 표시될 각 게시물의 정보를 저장함.
///
/// Args:
///
///     authorProfileImageUrl (String):
///         작성자 프로필 이미지 URL.
///     authorName (String):
///         작성자 이름.
///     timeAgo (String):
///         게시글 작성 시간 (예: "15분 전").
///     contentImageUrls (List<String>):
///         게시글 내용 이미지 URL 목록.
///     contentText (String):
///         게시글 텍스트 내용.
///     likeCount (int):
///         좋아요 수.
///     commentCount (int):
///         댓글 수.
///     isBookmarked (bool, optional):
///         북마크 여부. 기본값 `false`.
class Article {
  final String authorProfileImageUrl;
  final String authorName;
  final String timeAgo;
  final List<String> contentImageUrls;
  final String contentText;
  final int likeCount;
  final int commentCount;
  final bool isBookmarked; // 북마크 여부 (임의 추가)

  Article({
    required this.authorProfileImageUrl,
    required this.authorName,
    required this.timeAgo,
    required this.contentImageUrls,
    required this.contentText,
    required this.likeCount,
    required this.commentCount,
    this.isBookmarked = false,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      authorProfileImageUrl:
          json['authorProfileImageUrl'] ?? 'https://placehold.co/40x40',
      authorName: json['authorName'] ?? '익명',
      timeAgo: json['timeAgo'] ?? '방금 전',
      contentImageUrls: List<String>.from(json['contentImageUrls'] ?? []),
      contentText: json['contentText'] ?? '',
      likeCount: json['likeCount'] ?? 0,
      commentCount: json['commentCount'] ?? 0,
      isBookmarked: json['isBookmarked'] ?? false,
    );
  }
}

class ArticleItem extends StatefulWidget {
  final Article article;

  const ArticleItem({super.key, required this.article});

  @override
  State<ArticleItem> createState() => _ArticleItemState();
}

/// `ArticleItem` 위젯의 상태를 관리하는 클래스.
///
/// 게시글 아이템 내 이미지 캐러셀의 페이지 변경을 감지하고,
/// 작성자 정보, 이미지, 내용, 액션 버튼 등 UI 요소를 구성함.
class _ArticleItemState extends State<ArticleItem> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page?.round() != _currentPage) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAuthorInfo(article),
          if (article.contentImageUrls.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildImageCarousel(article, screenWidth - 32), // 32는 좌우 마진 합
          ],
          if (article.contentText.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildContentText(article),
          ],
          const SizedBox(height: 12),
          _buildActions(article),
        ],
      ),
    );
  }

  Widget _buildAuthorInfo(Article article) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[200],
            child: ClipOval(
              child: Image.network(
                article.authorProfileImageUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/default_profile.png', // 05.08 - TODO: 기본 프로필 이미지 경로 추가 필요
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.authorName,
                  style: const TextStyle(
                    color: Color(0xFF070707),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  article.timeAgo,
                  style: const TextStyle(
                    color: Color(0xFF8C8C8C),
                    fontSize: 12,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Color(0xFF8C8C8C)),
            onPressed: () {
              // TODO: 메뉴 액션 구현
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImageCarousel(Article article, double availableWidth) {
    // 05.08 - MEMO:
    // 이미지 높이를 너비에 비례하게 설정 (예: 16:9 비율)
    // Figma에서는 349x192 였으므로, 대략 1.81 : 1 비율
    // 여기서는 간단히 고정 높이 또는 화면 너비 기반 비율로 설정
    final imageHeight = availableWidth / (349 / 192);

    if (article.contentImageUrls.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: imageHeight, // 이미지 높이 동적 계산 또는 고정
          child: PageView.builder(
            controller: _pageController,
            itemCount: article.contentImageUrls.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(article.contentImageUrls[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        if (article.contentImageUrls.length > 1) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(article.contentImageUrls.length, (index) {
              return Container(
                width: 7,
                height: 7,
                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? const Color(0xFF4A9BF6)
                      : const Color(0xFFD9D9D9),
                ),
              );
            }),
          ),
        ]
      ],
    );
  }

  Widget _buildContentText(Article article) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        article.contentText,
        style: const TextStyle(
          color: Color(0xFF070707),
          fontSize: 15,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildActions(Article article) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          _buildActionButton(
              icon: Icons.favorite_border, // TODO: 좋아요 상태에 따라 아이콘 변경
              label: article.likeCount.toString(),
              onPressed: () {
                // TODO: 좋아요 액션
              }),
          const SizedBox(width: 16),
          _buildActionButton(
              icon: Icons.chat_bubble_outline,
              label: article.commentCount.toString(),
              onPressed: () {
                // TODO: 댓글 액션
              }),
          const Spacer(),
          IconButton(
            icon: Icon(
              article.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: article.isBookmarked
                  ? const Color(0xFF4A9BF6)
                  : const Color(0xFF8C8C8C),
            ),
            onPressed: () {
              // TODO: 북마크 액션
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      {required IconData icon,
      required String label,
      VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        child: Row(
          children: [
            Icon(icon, size: 20, color: const Color(0xFF505050)),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF505050),
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 05.19 - TODO: 전역화 리팩토링
// 구분 막대기를 반환하는 함수
Widget getSectionDivider() {
  return Container(
    width: double.infinity,
    height: 12.0,
    color: const Color(0xFFF5F5F9),
  );
}
