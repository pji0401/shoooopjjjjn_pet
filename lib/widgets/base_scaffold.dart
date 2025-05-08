import 'package:flutter/material.dart';

// 05.02 - NOTE: Scaffold에 동일한 스타일의 Navigation Bar 추가 가능하도록
class BaseScaffold extends StatelessWidget {
  final String? title;
  final Widget? leadingItem;
  final List<Widget>? trailingItems;
  final Widget body;
  final double? toolBarHeight;
  final double? leadingWidth;

  const BaseScaffold({
    Key? key,
    this.title,
    this.leadingItem,
    this.trailingItems,
    required this.body,
    this.toolBarHeight,
    this.leadingWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        title: title,
        leadingItem: leadingItem,
        trailingItems: trailingItems,
        toolBarHeight: toolBarHeight,
        leadingwWidth: leadingWidth,
      ),
      body: body,
    );
  }
}

// 05.02 - NOTE: Build Custom Top NavigationBar
PreferredSizeWidget? buildCustomAppBar({
  final String? title,
  final Widget? leadingItem,
  final List<Widget>? trailingItems,
  final double? toolBarHeight,
  final double? leadingwWidth,
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
    leadingWidth: leadingwWidth ?? null,
    toolbarHeight: toolBarHeight ?? 34,
    leading: leadingItem != null
        ? Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Row(
              children: [leadingItem], // 05.02 - FIXME: leadingItem
            ),
          )
        : null,
    title: title != null ? Text(title) : null,
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 34 / 20,
      fontFamily: "Pretendard",
    ),
    actions: trailingItems != null
        ? [
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: trailingItems!
                    .map((item) => Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: item,
                ))
                    .toList(),
              ),
            ),
          ]
        : null,
  );
}
