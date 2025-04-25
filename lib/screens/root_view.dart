import 'package:flutter/material.dart'; // import 'package:flutter/cupertino.dart'; // import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

// MARK: Material
class RootView extends StatefulWidget {
  const RootView({super.key, required this.title});

  final String title;

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home View'),
    Text('Community View'),
    Text('AIChatBot View'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/home_off.svg",
              width: 20,
              height: 20,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/home_off.svg",
              width: 20,
              height: 20,
            ),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/community_off.svg",
              width: 20,
              height: 20,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/community_off.svg",
              width: 20,
              height: 20,
            ),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'AI 챗봇',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/care_off.svg",
              width: 20,
              height: 20,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/care_off.svg",
              width: 20,
              height: 20,
            ),
            label: '케어',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/my_off.svg",
              width: 20,
              height: 20,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/my_off.svg",
              width: 20,
              height: 20,
            ),
            label: '마이',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

// MARK: CupertinoApp
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
//                     "assets/icons/home_off.svg",
//                     width: 20,
//                     height: 20,
//                   ),
//                   activeIcon: SvgPicture.asset(
//                     "assets/icons/home_off.svg",
//                     width: 20,
//                     height: 20,
//                   ),
//                   label: "홈",
//                 ),
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     "assets/icons/community.svg",
//                     width: 20,
//                     height: 20,
//                   ),
//                   activeIcon: SvgPicture.asset(
//                     "assets/icons/community.svg",
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
//                     "assets/icons/care_off.svg",
//                     width: 20,
//                     height: 20,
//                   ),
//                   activeIcon: SvgPicture.asset(
//                     "assets/icons/care_off.svg",
//                     width: 20,
//                     height: 20,
//                   ),
//                   label: '케어',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     "assets/icons/my_off.svg",
//                     width: 20,
//                     height: 20,
//                   ),
//                   activeIcon: SvgPicture.asset(
//                     "assets/icons/my_off.svg",
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

// MARK: WidgetsApp
// class WidgetsRootView extends StatelessWidget {
//   const WidgetsRootView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('WidgetsApp Home'),
//     );
//   }
// }