import 'package:flutter/material.dart';
import 'package:pawprints/utils/enums/ui_state.dart';
import 'package:pawprints/viewmodels/index.dart';
import 'package:pawprints/widgets/index.dart';

class CommunityProfileScreen extends StatefulWidget {
  final int memberId;

  const CommunityProfileScreen({Key? key, required this.memberId}) : super(key: key);

  @override
  CommunityProfileScreenState createState() => CommunityProfileScreenState();
}

class CommunityProfileScreenState extends State<CommunityProfileScreen> {
  late TabController _tabController;

  final List<Tab> _tabs = <Tab>[
    const Tab(text: '게시글'),
    const Tab(text: '작성 댓글'),
    const Tab(text: '관심글'),
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
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<CommunityProvider>(context, listen: false).getMemberContent(widget.memberId);
    // });
    Provider.of<CommunityProvider>(context, listen: false).getMemberContent(widget.memberId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
    return Consumer<CommunityProvider>(
      builder: (context, provider, child) {
        final contents = provider.contentList.data?.contents ?? [];

        // 게시글이 없는 경우
        if (contents.isEmpty) {
          return const Center(
            child: Text(
              '게시한 글이 없습니다',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 1.0,
          ),
          itemCount: contents.length,
          itemBuilder: (context, index) {
            return _buildGridItem(contents[index].images[0]);
          },
        );
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
