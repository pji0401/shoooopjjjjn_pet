import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pawprints/screens/base_scaffold.dart';

final logger = Logger();

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

// 05.08 - NOTE: SingleTickerProviderStateMixin가 뭐지
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
                const Center(
                  child: Text(
                    '커뮤니티 탭 내용', // 05.08 - TODO: 커뮤니티 탭 구현 필요
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const Center(
                  child: Text(
                    'QnA 탭 내용', // 05.08 - TODO: QnA 탭 구현 필요
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
