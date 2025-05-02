import 'package:flutter/material.dart'; // import 'package:flutter/cupertino.dart'; // import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawprints/screens/base_scaffold.dart';
import 'package:pawprints/screens/chat_view.dart';
import 'package:pawprints/screens/login_view.dart';

// 04.25 - NOTE: MaterialApp
class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home View'),
    Text('Community View'),
    ChatScreen(), // Text('AIChatBot View'),
    Text('Care View'),
    Text('My View'),
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
                  _buildNavItem('assets/icons/home_off.svg', 'assets/icons/home_on.svg', '홈', 0),
                  _buildNavItem('assets/icons/community_off.svg', 'assets/icons/community_on.svg', '커뮤니티', 1),
                  SizedBox(width: 67),
                  _buildNavItem('assets/icons/care_off.svg', 'assets/icons/care_on.svg', '케어', 3),
                  _buildNavItem('assets/icons/my_off.svg', 'assets/icons/my_on.svg', '마이', 4),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 0,
            right: 0,
            child: Center(
              child: _buildNavItem('assets/icons/chatbot_off.svg', 'assets/icons/chatbot_on.svg', 'AI 챗봇', 2)
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String assetNameOff, String assetNameOn, String label, int index) {
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
              color: _selectedIndex == 2 ? Color(0xff070707) : _selectedIndex == index ? Color(0xff135DB2) : Color(0xff070707),
            ),
          ),
        ],
      ),
    );
  }
}

// 04.25 - NOTE: CupertinoApp
// class CupertinoRootView extends StatefulWidget {
//   const CupertinoRootView({super.key, required this.title});

//   final String title;

//   @override
//   State<CupertinoRootView> createState() => _CupertinoRootViewState();
// }

// class _CupertinoRootViewState extends State<CupertinoRootView> {
//   int _selectedIndex = 0;

//   static const List<Widget> _widgetOptions = <Widget>[
//     Text('Home View'),
//     Text('Community View'),
//     Text('AIChatBot View'),
//     Text('Care View'),
//     Text('My View'),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         middle: Text(widget.title),
//       ),
//       child: SafeArea(
//         top: false,
//         bottom: false,
//         child: Column(
//           children: [
//             Expanded(
//               child: _widgetOptions[_selectedIndex],
//             ),
//             CupertinoTabBar(
//               currentIndex: _selectedIndex,
//               onTap: _onItemTapped,
//               items: <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     'assets/icons/home_off.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   activeIcon: SvgPicture.asset(
//                     'assets/icons/home_off.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   label: '홈',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     'assets/icons/community.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   activeIcon: SvgPicture.asset(
//                     'assets/icons/community.svg',
//                     width: 25,
//                     height: 25,
//                   ),
//                   label: '커뮤니티',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(CupertinoIcons.ellipsis),
//                   label: 'AI 챗봇',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     'assets/icons/care_off.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   activeIcon: SvgPicture.asset(
//                     'assets/icons/care_off.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   label: '케어',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     'assets/icons/my_off.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   activeIcon: SvgPicture.asset(
//                     'assets/icons/my_off.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   label: '마이',
//                 ),
//               ],
//               activeColor: CupertinoColors.activeBlue,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// 04.25 - NOTE: WidgetsApp
// class WidgetsRootView extends StatelessWidget {
//   const WidgetsRootView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('WidgetsApp Home'),
//     );
//   }
// }