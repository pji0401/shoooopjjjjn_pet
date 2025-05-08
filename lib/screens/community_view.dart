import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pawprints/screens/base_scaffold.dart';

final logger = Logger();

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

/// 인기 게시글 섹션 표시 위젯.
///
/// "지금 가장 HOT한 글"이라는 제목과 "전체보기" 링크를 포함하는 UI를 구성함.
/// 커뮤니티 화면 등에서 인기글 목록 상단에 사용될 수 있음.
class PopularArticles extends StatelessWidget {
  const PopularArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '지금 가장 HOT한 글',
                style: TextStyle(
                  color: Color(0xFF070707),
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  height: 1.45, // 줄 간격
                  letterSpacing: -0.40,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '전체보기',
                    style: TextStyle(
                      color: Color(0xFF070707),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 4), // 텍스트와 아이콘 사이 간격
                  Container(
                    // transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14), // 180도 회전
                    // width: 14,
                    // height: 14,
                    // clipBehavior: Clip.antiAlias,
                    // decoration: BoxDecoration(),
                    // child: Stack(), // 현재 비어있음, 실제 아이콘으로 대체 필요
                    // 05.08 - MEMO: 실제 아이콘으로 대체 필요
                    child: const Icon(Icons.arrow_forward_ios,
                        size: 14, color: Color(0xFF070707)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 커뮤니티 탭의 내용을 담을 위젯
class CommunityTabBody extends StatefulWidget {
  const CommunityTabBody({super.key});

  @override
  State<CommunityTabBody> createState() => _CommunityTabBodyState();
}

class _CommunityTabBodyState extends State<CommunityTabBody> {
  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  void _loadArticles() {
    // 05.08 - TODO: 예시 데이터 실제 데이터로 변경 필요.
    setState(() {
      _articles = [
        Article(
          authorProfileImageUrl:
              "https://placehold.co/40x40/E8117F/white?text=P",
          authorName: "정태영",
          timeAgo: "방금 전",
          contentImageUrls: [],
          contentText: "안녕하세요 디벨로퍼입니다.\n#반려동물 #사료추천 #펫푸드",
          likeCount: 0,
          commentCount: 0,
          isBookmarked: false,
        ),
        Article(
          authorProfileImageUrl:
              "https://images.unsplash.com/photo-1533738363-b7f9aef128ce?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Y3V0ZSUyMGNhdHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=50&q=60",
          authorName: "냥냥펀치",
          timeAgo: "15분 전",
          contentImageUrls: [
            "https://images.unsplash.com/photo-1596854407944-bf87f6fdd49e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGN1dGUlMjBjYXR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
            "https://images.unsplash.com/photo-1574158622682-e40e69881006?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGN1dGUlMjBjYXR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60"
          ],
          contentText: "우리집 고양이 좀 보세요! 세상에서 제일 귀여워요 🥰\n#냥스타그램 #집사그램 #귀요미",
          likeCount: 128,
          commentCount: 12,
          isBookmarked: true,
        ),
        Article(
          authorProfileImageUrl:
              "https://images.unsplash.com/photo-1598133894008-61f7fdb8cc3a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y3V0ZSUyMGRvZ3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=50&q=60",
          authorName: "댕댕이사랑",
          timeAgo: "1시간 전",
          contentImageUrls: [
            "https://images.unsplash.com/photo-1583512603805-3cc6b41f3edb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y3V0ZSUyMGRvZ3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60"
          ],
          contentText:
              "산책하다 만난 귀여운 댕댕이! 사진 찍어도 되냐고 허락받고 찍었어요. 너무 순하고 착해요. 오늘 하루 힐링 제대로 했네요. 강아지는 사랑입니다 ❤️",
          likeCount: 256,
          commentCount: 34,
          isBookmarked: false,
        ),
        Article(
          authorProfileImageUrl:
              "https://placehold.co/40x40/E8117F/white?text=P",
          authorName: "펫푸드전문가",
          timeAgo: "3시간 전",
          contentImageUrls: [],
          contentText:
              "반려동물 사료 선택, 어떤 기준으로 하시나요? 영양 성분, 기호성, 알러지 유무 등 고려해야 할 점이 많죠. 궁금한 점이 있다면 댓글로 질문해주세요! #반려동물 #사료추천 #펫푸드",
          likeCount: 77,
          commentCount: 5,
          isBookmarked: false,
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_articles.isEmpty) {
      return const Center(child: CircularProgressIndicator()); // 데이터 로딩 중 표시
    }

    return Column(
      children: [
        const PopularArticles(), // 인기글 섹션
        Expanded(
          child: ListView.builder(
            itemCount: _articles.length,
            itemBuilder: (context, index) {
              return ArticleItem(article: _articles[index]);
            },
          ),
        ),
      ],
    );
  }
}

// QnA 탭의 내용을 담을 위젯
class QnATabBody extends StatelessWidget {
  const QnATabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'QnA 탭 내용',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

// 05.08 - NOTE: SingleTickerProviderStateMixin가 뭐지 : 위젯에 단일 애니메이션 컨트롤러를 효율적으로 관리하고 동기화할 수 있는 기능을 제공하는 믹스인
class _CommunityViewState extends State<CommunityView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabs = <Tab>[
    const Tab(text: '커뮤니티'),
    const Tab(text: 'QnA'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 05.08 - TODO: 글로벌 색상과 연결 필요
    const primaryColor = Colors.blue;
    const greyColor = Colors.grey;
    const pretendardFontFamily = 'Pretendard';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: buildCustomAppBar(
        title: '커뮤니티',
        trailingItems: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // 05.08 - TODO: 검색 기능 구현
              logger.d('돋보기 아이콘 클릭');
            },
          ),
          IconButton(
            icon: const Icon(
                Icons.account_circle_outlined), // 또는 Icons.person_outline
            onPressed: () {
              // 05.08 - TODO: 내 정보 화면으로 이동 또는 관련 기능 구현
              logger.d('내정보 아이콘 클릭');
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!, width: 0.5), // 구분선
              ),
            ),
            child: TabBar(
              controller: _tabController,
              tabs: _tabs,
              labelColor: primaryColor,
              unselectedLabelColor: greyColor,
              indicatorColor: primaryColor,
              indicatorWeight: 3.0,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: const TextStyle(
                fontFamily: pretendardFontFamily,
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: pretendardFontFamily,
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                const CommunityTabBody(),
                const QnATabBody(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 05.08 - TODO: 리팩토링
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
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
            backgroundImage: NetworkImage(article.authorProfileImageUrl),
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
