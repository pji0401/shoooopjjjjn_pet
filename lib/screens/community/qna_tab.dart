import 'package:flutter/material.dart';

// local imports
import 'package:pawprints/screens/community/common.dart';

// 05.18 - TODO: 아이콘 적용

class QnaBox extends StatelessWidget {
  final String title;
  final int commentCount;
  final int likeCount;
  final int viewCount;
  final String timeAgo;

  const QnaBox({
    super.key,
    required this.title,
    required this.commentCount,
    required this.likeCount,
    required this.viewCount,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF070707),
                fontFamily: 'Pretendard',
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
            const SizedBox(height: 12.0),
            Row(
              children: <Widget>[
                _buildMetaInfo(
                    Icons.chat_bubble_outline, commentCount.toString()),
                const SizedBox(width: 12.0),
                _buildMetaInfo(Icons.favorite_border, likeCount.toString()),
                const SizedBox(width: 12.0),
                _buildMetaInfo(Icons.visibility_outlined, viewCount.toString()),
                const SizedBox(width: 12.0),
                Text(
                  timeAgo,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF8C8C8C),
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaInfo(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          icon,
          size: 14.0,
          color: const Color(0xFF505050),
        ),
        const SizedBox(width: 4.0),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12.0,
            color: Color(0xFF505050),
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class QnaTabBody extends StatefulWidget {
  const QnaTabBody({super.key});

  @override
  State<QnaTabBody> createState() => _QnaTabBodyState();
}

/// 많이 찾는 질문 섹션 표시 위젯.
///
/// "많이 찾는 질문"이라는 제목과 "전체보기" 링크를 포함하는 UI를 구성함.
class MostQnaArticles extends StatelessWidget {
  const MostQnaArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '많이 찾는 질문',
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

class _QnaTabBodyState extends State<QnaTabBody> {
  late PageController _pageController;
  int _currentPage = 0;

  // QnaBox에 표시할 데이터
  final List<Map<String, dynamic>> _qnaItems = [
    {
      'title': '강쥐 눈물자국 없애는 좋은방법 아시는 분',
      'commentCount': 88,
      'likeCount': 37,
      'viewCount': 891,
      'timeAgo': '4일 전',
    },
    {
      'title': '고양이 사료 어떤게 좋을까요? 샘플 테스트 해보고 싶은데 어디서 구하나요?',
      'commentCount': 12,
      'likeCount': 5,
      'viewCount': 102,
      'timeAgo': '1일 전',
    },
    {
      'title': '산책 시 강아지가 자꾸 짖어요. 훈련 방법 공유 부탁드립니다.',
      'commentCount': 45,
      'likeCount': 22,
      'viewCount': 543,
      'timeAgo': '2주 전',
    },
    {
      'title': '새로운 고양이 입양했어요. 처음 키우는데 조언 부탁드려요.',
      'commentCount': 67,
      'likeCount': 31,
      'viewCount': 420,
      'timeAgo': '3일 전',
    },
    {
      'title': '강아지 털 빠짐이 심한데 좋은 브러쉬 추천해주세요.',
      'commentCount': 23,
      'likeCount': 18,
      'viewCount': 310,
      'timeAgo': '1주 전',
    },
    {
      'title': '고양이가 화장실을 안 써요. 어떻게 훈련시키나요?',
      'commentCount': 56,
      'likeCount': 27,
      'viewCount': 489,
      'timeAgo': '5일 전',
    },
    // 더 많은 데이터를 추가할 수 있습니다.
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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

  // 페이지 수 계산 (3개씩 표시할 경우)
  int get _pageCount => (_qnaItems.length / 3).ceil();

  @override
  Widget build(BuildContext context) {
    final double qnaBoxHeight = 105.0;
    final double pageViewHeight = qnaBoxHeight * 3 + 24.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const MostQnaArticles(),
        SizedBox(
          height: pageViewHeight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _pageCount,
            itemBuilder: (context, pageIndex) {
              final startIndex = pageIndex * 3;
              final itemCount = startIndex + 3 <= _qnaItems.length
                  ? 3
                  : _qnaItems.length - startIndex;

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  itemCount,
                  (index) {
                    final itemIndex = startIndex + index;
                    final item = _qnaItems[itemIndex];
                    return QnaBox(
                      title: item['title'],
                      commentCount: item['commentCount'],
                      likeCount: item['likeCount'],
                      viewCount: item['viewCount'],
                      timeAgo: item['timeAgo'],
                    );
                  },
                ),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16.0, top: 0.0),
          height: 24,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pageCount,
              (index) => _buildPageIndicator(index == _currentPage),
            ),
          ),
        ),
        getSectionDivider()
      ],
    );
  }

  // 페이지 인디케이터 개별 점 생성 메서드
  Widget _buildPageIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      height: 6.0,
      width: 6.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFF4A9BF6) : const Color(0xFFD9D9D9),
      ),
    );
  }
}
