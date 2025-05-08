import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

// 05.08 - NOTE: 커뮤니티 뷰용 _CommunityAppBar 추가. 재사용성 고려 설계, 향후 표준 채택 여부 미정.
/// 커뮤니티 화면 등에 사용하기 위한 재사용 가능한 앱바(AppBar) 위젯.
///
/// `PreferredSizeWidget` 구현으로 `Scaffold`의 `appBar` 속성에 바로 사용 가능.
/// 제목, 액션 버튼 목록, 리딩 위젯 및 주요 스타일(글꼴, 색상 등) 설정 가능.
///
/// Args:
///
///     titleText (String):
///          앱바 중앙 표시 제목 문자열.
///     appBarActions (List<Widget>?, optional):
///          앱바 우측 표시 위젯 목록 (주로 아이콘 버튼).
///     appBarLeading (Widget?, optional):
///          앱바 좌측 표시 위젯 (주로 뒤로가기/메뉴 아이콘 버튼).
///     centerAppBarTitle (bool, optional):
///          제목 중앙 정렬 여부. 기본값 `true`.
///     appBarTitleTextStyle (TextStyle?, optional):
///          제목 텍스트 스타일.
///          미지정 시 'Pretendard', `FontWeight.w600`, `fontSize: 20.0` 기본 스타일 적용.
///     appBarBackgroundColor (Color?, optional):
///          앱바 배경색.
///     appBarForegroundColor (Color?, optional):
///          앱바 아이콘 및 기본 텍스트 요소 전경색.
class _CommunityAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final List<Widget>? appBarActions;
  final Widget? appBarLeading;
  final bool centerAppBarTitle;
  final TextStyle? appBarTitleTextStyle;
  final Color? appBarBackgroundColor;
  final Color? appBarForegroundColor;
  final PreferredSizeWidget? bottom;

  const _CommunityAppBar({
    // super.key, // StatelessWidget에는 key가 이미 있음
    required this.titleText,
    this.appBarActions,
    this.appBarLeading,
    this.centerAppBarTitle = true,
    this.appBarTitleTextStyle,
    this.appBarBackgroundColor,
    this.appBarForegroundColor,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveForegroundColor = appBarForegroundColor ??
        Theme.of(context).appBarTheme.foregroundColor ??
        Colors.black;
    final defaultTitleTextStyle = TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w600,
      fontSize: 20.0,
      color: effectiveForegroundColor,
    );

    return AppBar(
      leading: appBarLeading,
      title: Text(titleText),
      centerTitle: centerAppBarTitle,
      titleTextStyle: appBarTitleTextStyle ?? defaultTitleTextStyle,
      actions: appBarActions,
      backgroundColor: appBarBackgroundColor,
      foregroundColor: effectiveForegroundColor,
      elevation: 0.5,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      kToolbarHeight + (bottom?.preferredSize.height ?? 0.0)); // AppBar의 표준 높이
}

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
      appBar: _CommunityAppBar(
        // 05.08 - NOTE: RootView 탭이므로 leading의 Navigator.pop 동작은 부적절할 수 있어 주석 처리함. 추후 네비게이션 흐름에 따라 수정 필요.
        // appBarLeading: IconButton(
        //   // leading을 사용하려면 appBarLeading 파라미터로 전달
        //   icon: Icon(Icons.arrow_back_ios_new), // 또는 Icons.arrow_back
        //   onPressed: () {
        //     if (Navigator.canPop(context)) {
        //       Navigator.pop(context);
        //     }
        //   },
        // ),
        titleText: '커뮤니티',
        appBarActions: <Widget>[
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
        bottom: TabBar(
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
      body: TabBarView(
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
    );
  }
}
