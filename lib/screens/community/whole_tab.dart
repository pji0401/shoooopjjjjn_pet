import 'package:flutter/material.dart';

// local imports
import 'package:pawprints/screens/community/common.dart';

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
                '지금 가장 HOT한 글 🔥',
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

class WholeTabBody extends StatefulWidget {
  const WholeTabBody({super.key});

  @override
  State<WholeTabBody> createState() => _WholeTabBodyState();
}

class _WholeTabBodyState extends State<WholeTabBody> {
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
