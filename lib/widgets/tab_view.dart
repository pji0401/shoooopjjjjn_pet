import 'package:flutter/material.dart';

/// 탭 구성 정보.
///
/// 탭의 라벨 문자열과 해당 탭에 표시될 내용 위젯을 정의.
///
/// Args:
///
///     label (String):
///         탭에 표시될 텍스트 라벨.
///     content (Widget):
///         탭 선택 시 표시될 내용 위젯.
class TabConfig {
  final String label;
  final Widget content;

  TabConfig({required this.label, required this.content});
}

/// `LeftStackTabViewSection` 위젯의 상태 관리.
///
/// `TabController`를 초기화하고 관리하며, 전달받은 `tabConfigs`를 기반으로
/// 왼쪽 정렬 스타일의 탭 바 및 탭 뷰 UI를 구성.
///
/// Args:
///
///     tabConfigs (List<TabConfig>):
///         탭 라벨과 내용을 포함하는 설정 목록.
class LeftStackTabViewSection extends StatefulWidget {
  final List<TabConfig> tabConfigs;

  const LeftStackTabViewSection({
    super.key,
    required this.tabConfigs,
  });

  @override
  State<LeftStackTabViewSection> createState() =>
      _LeftStackTabViewSectionState();
}

/// 위젯의 UI를 구성.
///
/// `Column`을 사용하여 상단에는 `TabBar`를, 하단에는 `TabBarView`를 배치.
/// `TabBar`는 `widget.tabConfigs`의 라벨을 사용하여 탭들을 생성하고,
/// `TabBarView`는 `widget.tabConfigs`의 컨텐츠 위젯을 사용하여 각 탭의 내용을 표시.
/// 탭 스타일은 미리 정의된 색상과 폰트 설정을 따름.
///
/// Args:
///
///     context (BuildContext):
///         위젯 트리의 현재 빌드 컨텍스트.
///
/// Returns:
///
///     Widget:
///         구성된 탭 뷰 위젯.
class _LeftStackTabViewSectionState extends State<LeftStackTabViewSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 05.08 - TODO: 글로벌 색상과 연결 필요
  final Color primaryColor = Colors.blue;
  final Color greyColor = Colors.grey;
  final String pretendardFontFamily = 'Pretendard';

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.tabConfigs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            tabs: widget.tabConfigs
                .map((config) => Tab(text: config.label))
                .toList(), // TabConfig에서 라벨 사용
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelPadding: const EdgeInsets.symmetric(horizontal: 30.0),
            labelColor: primaryColor,
            unselectedLabelColor: greyColor,
            indicatorColor: primaryColor,
            indicatorWeight: 3.0,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(
              fontFamily: pretendardFontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: pretendardFontFamily,
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabConfigs
                .map((config) => config.content)
                .toList(), // TabConfig에서 내용 위젯 사용
          ),
        ),
      ],
    );
  }
}

/// `CenterFitTabViewSection` 위젯의 상태 관리.
///
/// `TabController`를 초기화하고 관리하며, 전달받은 `tabConfigs`를 기반으로
/// 중앙 정렬 스타일의 탭 바 및 탭 뷰 UI를 구성.
///
/// Args:
///
///     tabConfigs (List<TabConfig>):
///         탭 라벨과 내용을 포함하는 설정 목록.
class CenterFitTabViewSection extends StatefulWidget {
  final List<TabConfig> tabConfigs;

  const CenterFitTabViewSection({
    super.key,
    required this.tabConfigs,
  });

  @override
  State<CenterFitTabViewSection> createState() =>
      _CenterFitTabViewSectionState();
}

/// 위젯의 UI를 구성.
///
/// `Column`을 사용하여 상단에는 `TabBar`를, 하단에는 `TabBarView`를 배치.
/// `TabBar`는 `widget.tabConfigs`의 라벨을 사용하여 탭들을 생성하고,
/// `TabBarView`는 `widget.tabConfigs`의 컨텐츠 위젯을 사용하여 각 탭의 내용을 표시.
/// 탭 스타일은 중앙 정렬에 맞춰진 미리 정의된 색상과 폰트 설정을 따름.
///
/// Args:
///
///     context (BuildContext):
///         위젯 트리의 현재 빌드 컨텍스트.
///
/// Returns:
///
///     Widget:
///         구성된 탭 뷰 위젯.
class _CenterFitTabViewSectionState extends State<CenterFitTabViewSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // CommunityProfileScreen에서 사용된 스타일 상수
  final Color primaryColor = Colors.blue;
  final Color greyColor = Colors.grey;
  final String pretendardFontFamily = 'Pretendard';

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.tabConfigs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!, width: 0.2), // 구분선
            ),
          ),
          child: TabBar(
            controller: _tabController,
            tabs: widget.tabConfigs
                .map((config) => Tab(text: config.label))
                .toList(), // TabConfig에서 라벨 사용
            padding: const EdgeInsets.symmetric(
                horizontal: 0.0), // CommunityProfileScreen 스타일
            // isScrollable: false, // 기본값 (중앙/분산 정렬 효과)
            // tabAlignment: TabAlignment.fill, // 기본값 (중앙/분산 정렬 효과)
            labelPadding: const EdgeInsets.symmetric(
                horizontal: 0.0), // CommunityProfileScreen 스타일
            labelColor: primaryColor,
            unselectedLabelColor: greyColor,
            indicatorColor: primaryColor,
            indicatorWeight: 1.0, // CommunityProfileScreen 스타일
            indicatorSize:
                TabBarIndicatorSize.label, // CommunityProfileScreen 스타일
            indicatorPadding: EdgeInsets.symmetric(
                horizontal: -20.0), // CommunityProfileScreen 스타일
            labelStyle: TextStyle(
              fontFamily: pretendardFontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: pretendardFontFamily,
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabConfigs
                .map((config) => config.content)
                .toList(), // TabConfig에서 내용 위젯 사용
          ),
        ),
      ],
    );
  }
}
