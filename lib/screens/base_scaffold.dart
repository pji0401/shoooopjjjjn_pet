import 'package:flutter/material.dart';

// 05.02 - NOTE: Scaffold에 동일한 스타일의 Navigation Bar 추가 가능하도록
class BaseScaffold extends StatelessWidget {
  final String? title;
  final List<Widget>? leadingItems;
  final List<Widget>? trailingItems;
  final Widget body;

  const BaseScaffold({
    Key? key,
    this.title,
    this.leadingItems,
    this.trailingItems,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        title: title,
        leadingItems: leadingItems,
        trailingItems: trailingItems,
      ),
      body: body,
    );
  }
}

// 05.02 - NOTE: Build Custom Top NavigationBar
PreferredSizeWidget? buildCustomAppBar({
  final String? title,
  final List<Widget>? leadingItems,
  final List<Widget>? trailingItems,
}) {
  if (title == null && leadingItems == null && trailingItems == null) {
    return null;
  }

  return AppBar(
    elevation: 0,
    leading: leadingItems != null
        ? Row(mainAxisSize: MainAxisSize.min, children: leadingItems)
        : null,
    title: title != null
        ? Text(
      title,
      style: const TextStyle(
        color: Color(0xff070707),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    )
        : null,
    actions: trailingItems,
  );
}

