import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawprints/screens/index.dart';
import 'package:pawprints/widgets/index.dart';

// 04.25 - NOTE: MaterialApp
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootViewState();
}

// 05.08 - NOTE: root_view에 CommunityView 연결 및 community_view.dart 파일 생성 완료.
class _RootViewState extends State<RootScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CommunityScreen(),
    ChatScreen(),
    CareScreen(),
    MyScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Center(
                  child: _widgetOptions[_selectedIndex],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 83,
              margin: EdgeInsets.only(bottom: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem('assets/icons/home_off.svg',
                      'assets/icons/home_on.svg', '홈', 0),
                  _buildNavItem('assets/icons/community_off.svg',
                      'assets/icons/community_on.svg', '커뮤니티', 1),
                  SizedBox(width: 67),
                  _buildNavItem('assets/icons/care_off.svg',
                      'assets/icons/care_on.svg', '케어', 3),
                  _buildNavItem('assets/icons/my_off.svg',
                      'assets/icons/my_on.svg', '마이', 4),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 0,
            right: 0,
            child: Center(
                child: _buildNavItem('assets/icons/chatbot_off.svg',
                    'assets/icons/chatbot_on.svg', 'AI 챗봇', 2)),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      String assetNameOff, String assetNameOn, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            _selectedIndex == index ? assetNameOn : assetNameOff,
            width: index == 2 ? 67 : 20,
            height: index == 2 ? 67 : 20,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _selectedIndex == 2
                  ? Color(0xff070707)
                  : _selectedIndex == index
                      ? Color(0xff135DB2)
                      : Color(0xff070707),
            ),
          ),
        ],
      ),
    );
  }
}