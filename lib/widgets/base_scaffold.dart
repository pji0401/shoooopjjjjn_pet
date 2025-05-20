import 'package:flutter/material.dart';

// 05.02 - NOTE: Scaffold에 동일한 스타일의 Navigation Bar 추가 가능하도록
class BaseScaffold extends StatelessWidget {
  final String? title;
  final TextStyle? titleTextStyle;
  final Widget? leadingItem;
  final List<Widget>? trailingItems;
  final Widget body;
  final double? toolBarHeight;
  final double? leadingWidth;

  const BaseScaffold({
    super.key,
    this.title,
    this.titleTextStyle,
    this.leadingItem,
    this.trailingItems,
    required this.body,
    this.toolBarHeight,
    this.leadingWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: buildCustomAppBar(
        title: title,
        titleTextStyle: titleTextStyle,
        leadingItem: leadingItem,
        trailingItems: trailingItems,
        toolBarHeight: toolBarHeight,
        leadingWidth: leadingWidth,
      ),
      body: body,
    );
  }
}

// 05.02 - NOTE: Build Custom Top NavigationBar
/// 커스텀 앱바 생성 함수.
///
/// 앱 상단에 표시할 앱바 위젯 생성. 제목, 스타일, 아이콘 등 커스텀 가능.
///
/// Args:
///
///     title (String?):
///         앱바 중앙 제목 텍스트.
///     titleTextStyle (TextStyle?):
///         제목 텍스트 스타일 설정.
///     leadingItem (Widget?):
///         앱바 좌측 위젯.
///     trailingItems (List<Widget>?):
///         앱바 우측 위젯 목록.
///     toolBarHeight (double?):
///         앱바 높이. 기본값 34.
///     leadingWidth (double?):
///         앱바 좌측 영역 너비.
///
/// Returns:
///
///     PreferredSizeWidget?:
///         설정된 커스텀 앱바. title, leadingItem, trailingItems 모두 null이면 null 반환.
PreferredSizeWidget? buildCustomAppBar({
  final String? title,
  final TextStyle? titleTextStyle,
  final Widget? leadingItem,
  final List<Widget>? trailingItems,
  final double? toolBarHeight,
  final double? leadingWidth,
}) {
  if (title == null && leadingItem == null && trailingItems == null) {
    return null;
  }

  return AppBar(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.black,
    elevation: 0,
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    leadingWidth: leadingWidth,
    toolbarHeight: toolBarHeight ?? 34,
    leading: leadingItem != null
        ? Padding(
            padding: const EdgeInsets.only(left: 14),
            child: leadingItem,
            // 05.02 - FIXME: leadingItem
            // 05.21 - MEMO: 무슨 문제라도 있는 건지? 지워도 될까요? - 태영
            // child: Row(
            //   children: [leadingItem],
            // ),
          )
        : null,
    title: title != null ? Text(title) : null,
    titleTextStyle: titleTextStyle ??
        TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 34 / 20,
          fontFamily: 'Pretendard',
        ),
    actions: trailingItems != null
        ? [
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Row(
                children: trailingItems,
              ),
            ),
          ]
        : null,
  );
}
