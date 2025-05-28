import 'package:flutter/material.dart';
import 'package:pawprints/utils/index.dart';
import 'package:pawprints/viewmodels/index.dart';
import 'package:pawprints/data/models/index.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
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

class WholeTabBody extends StatefulWidget {
  const WholeTabBody({super.key});

  @override
  State<WholeTabBody> createState() => _WholeTabBodyState();
}

class _WholeTabBodyState extends State<WholeTabBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommunityProvider>(
        builder: (context, provider, child) {
          final contents = provider.wholeContentList.data?.contents ?? [];
          if (provider.wholeContentList.uiState == UIState.LOADING) {
            return const Center(child: CircularProgressIndicator());
          } else if (contents.isEmpty) {
            return const Center(child: Text('게시글이 없습니다.'));
          } else {
            // NOTE: 최신순 정렬 및 매핑 (content -> article)
            final articles = (contents..sort((a, b) => b.createdAt.compareTo(a.createdAt))).map((e) => e.toArticle()).toList();
            return Column(
              children: [
                const PopularArticles(),
                Expanded(
                  child: ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return ArticleItem(article: articles[index]);
                    },
                  ),
                ),
              ],
            );
          }
        }
    );
  }
}