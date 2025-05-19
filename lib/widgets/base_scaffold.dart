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
