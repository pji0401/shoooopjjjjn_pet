import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// local imports
import 'package:pawprints/widgets/index.dart';
import 'package:pawprints/services/app_logger.dart';
import 'package:pawprints/screens/community/whole_tab.dart';
import 'package:pawprints/screens/community/hot_tab.dart';
import 'package:pawprints/screens/community/qna_tab.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  final String title = '커뮤니티';

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

// 05.08 - NOTE: SingleTickerProviderStateMixin가 뭐지 : 위젯에 단일 애니메이션 컨트롤러를 효율적으로 관리하고 동기화할 수 있는 기능을 제공하는 믹스인
class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabs = <Tab>[
    const Tab(text: '전체'),
    const Tab(text: '인기'),
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
              // 05.08 - TODO: 내 정보 화면으로 이동 또는 관련 기능 구현
              AppLogger.d('내정보 아이콘 클릭');
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
                const WholeTabBody(),
                const HotTabBody(),
                const QnaTabBody(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: CreatePostButton(
        onPressed: () {
          AppLogger.d('글 작성하기 버튼 클릭');
          // Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePostScreen()));
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
    this.bottomMargin = 64.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomMargin), // 버튼을 위로 올리기 위한 패딩
      child: FloatingActionButton(
        onPressed: onPressed ??
            () {
              AppLogger.d('글 작성하기 버튼 클릭');
              // 기본 동작 구현
            },
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
