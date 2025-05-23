import 'package:flutter/material.dart';
import 'package:pawprints/widgets/index.dart';

class CommunityProfileScreen extends StatefulWidget {
  const CommunityProfileScreen({super.key});

  @override
  CommunityProfileScreenState createState() => CommunityProfileScreenState();
}

class CommunityProfileScreenState extends State<CommunityProfileScreen> {
  // 05.20 - TODO: 게시글 이미지 예시 데이터 교체
  final List<String> _postImages = [
    'https://images.unsplash.com/photo-1583512603805-3cc6b41f3edb',
    'https://images.unsplash.com/photo-1596854407944-bf87f6fdd49e',
    'https://images.unsplash.com/photo-1574158622682-e40e69881006',
    'https://images.unsplash.com/photo-1533738363-b7f9aef128ce',
    'https://images.unsplash.com/photo-1598133894008-61f7fdb8cc3a',
  ];

  late final List<TabConfig> _profileTabs;

  @override
  void initState() {
    super.initState();
    // initState에서 _profileTabs 초기화
    _profileTabs = [
      TabConfig(label: '게시글', content: _buildPostsGridView()), // 게시글 탭 내용
      TabConfig(
        label: '작성 댓글',
        content: Center(
          // 작성 댓글 탭 내용
          child: Text(
            '작성한 댓글이 없습니다',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Pretendard', // 폰트 패밀리 적용
            ),
          ),
        ),
      ),
      TabConfig(
        label: '관심글',
        content: Center(
          // 관심글 탭 내용
          child: Text(
            '관심글이 없습니다',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Pretendard', // 폰트 패밀리 적용
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    const pretendardFontFamily = 'Pretendard';

    return Scaffold(
      appBar: buildCustomAppBar(
        title: '',
        leadingItem: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 28.0, horizontal: 32.0),
            child: Row(
              children: [
                // 프로필 이미지
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      AssetImage('assets/images/default_profile.png'),
                ),
                const SizedBox(width: 16),

                // 닉네임과 프로필 메시지
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'bombom',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: pretendardFontFamily,
                      ),
                    ),
                    SizedBox(height: 0.2),
                    Text(
                      '봄플루언서가 되는 그날까지',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: pretendardFontFamily,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: CenterFitTabViewSection(
              tabConfigs: _profileTabs,
            ),
          ),
        ],
      ),
    );
  }

  // 그리드형 이미지 목록뷰 위젯
  Widget _buildPostsGridView() {
    // 게시글이 없는 경우
    if (_postImages.isEmpty) {
      return Center(
        child: Text(
          '게시한 글이 없습니다',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[500],
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 가로로 3개 배치
        crossAxisSpacing: 4.0, // 가로 간격
        mainAxisSpacing: 4.0, // 세로 간격
        childAspectRatio: 1.0, // 정사각형 비율
      ),
      itemCount: _postImages.length,
      itemBuilder: (context, index) {
        return _buildGridItem(_postImages[index]);
      },
    );
  }

  // 그리드 아이템 위젯
  Widget _buildGridItem(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
