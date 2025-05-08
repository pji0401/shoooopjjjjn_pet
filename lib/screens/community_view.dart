import 'package:flutter/material.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('커뮤니티'),
        ),
        body: const Center(
          child: Text(
            '커뮤니티 화면인 것',
            style: TextStyle(fontSize: 24),
          ),
        ));
  }
}
