import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  @override
  Widget build(BuildContext context) {
    // 05.08 - NOTE: AppBar 텍스트 색상 설정 관련. 테마 또는 직접 지정 가능하며, 현재는 Colors.black 사용. 디자인 시스템에 맞춰 수정 필요.
    const appBarTextColor = Colors.black;

    return Scaffold(
      // 05.08 - NOTE: RootView 탭이므로 leading의 Navigator.pop 동작은 부적절할 수 있어 주석 처리함. 추후 네비게이션 흐름에 따라 수정 필요.
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new), // 또는 Icons.arrow_back
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text('커뮤니티'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
          color: appBarTextColor,
        ),
        actions: <Widget>[
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
      body: const Center(
        child: Text(
          '커뮤니티 화면 내용입니다.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
