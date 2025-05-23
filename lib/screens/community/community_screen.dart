import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// local imports
import 'package:pawprints/widgets/index.dart';
import 'package:pawprints/screens/community/whole_tab.dart';
// import 'package:pawprints/screens/community/hot_tab.dart';
import 'package:pawprints/screens/community/qna_tab.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/config/index.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  final String title = '커뮤니티';

  @override
  CommunityScreenState createState() => CommunityScreenState();
}

// 05.08 - NOTE: SingleTickerProviderStateMixin가 뭐지 : 위젯에 단일 애니메이션 컨트롤러를 효율적으로 관리하고 동기화할 수 있는 기능을 제공하는 믹스인
class CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabs = <Tab>[
    const Tab(text: '커뮤니티'),
    // const Tab(text: '인기'),
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
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).appBarTheme.iconTheme?.color ??
                      Colors.black,
                  BlendMode.srcIn), // 아이콘 색상 적용
            ),
            onPressed: () {
              // 05.08 - TODO: 검색 기능 구현
              AppLogger.d('돋보기 아이콘 클릭');
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/my_off.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).appBarTheme.iconTheme?.color ??
                      Colors.black,
                  BlendMode.srcIn), // 아이콘 색상 적용
            ), // 또는 Icons.person_outline
            onPressed: () {
              context.push(RoutePath.community_profile.value);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: 83,
        ),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  bottom:
                      BorderSide(color: Colors.grey[300]!, width: 0.2), // 구분선
                ),
              ),
              child: TabBar(
                controller: _tabController,
                tabs: _tabs,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelPadding: const EdgeInsets.symmetric(horizontal: 30.0),
                labelColor: primaryColor,
                unselectedLabelColor: greyColor,
                indicatorColor: primaryColor,
                indicatorWeight: 1.0,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: const TextStyle(
                  fontFamily: pretendardFontFamily,
                  fontWeight: FontWeight.w600,
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
                  const WholeTabBody(),
                  // const HotTabBody(),
                  const QnaTabBody(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CreatePostButton(
        onPressed: () {
          context.push(RoutePath.community_write.value);
        },
        backgroundColor: primaryColor,
      ),
    );
  }
}

class CreatePostButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final double elevation;
  final double bottomMargin;

  const CreatePostButton({
    super.key,
    this.onPressed,
    this.backgroundColor = Colors.blue,
    this.elevation = 4.0,
    this.bottomMargin = 111.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: bottomMargin), // 버튼을 위로 올리기 위한 패딩
        child: // FloatingActionButton을 SizedBox로 감싸서 크기 지정
            SizedBox(
          width: 56,
          height: 56,
          child: FloatingActionButton(
            onPressed: onPressed ??
                () {
                  AppLogger.d('글 작성하기 버튼 클릭');
                },
            backgroundColor: backgroundColor,
            elevation: elevation,
            shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(56.0)), // 크기에 맞춰 반경 조정
            ),
            child: SvgPicture.asset(
              'assets/icons/pen.svg',
              width: 48,
            ),
          ),
        ));
  }
}
