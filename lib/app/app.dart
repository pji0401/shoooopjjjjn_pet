import 'package:flutter/material.dart'; // import 'package:flutter/cupertino.dart'; // import 'package:flutter/widgets.dart';
import '../config/route/index.dart';

// 04.25 - NOTE: MaterialApp - 기본적으로 머테리얼 앱 구조를 채택합니다. 필요에 따라 내부 위젯만 Platform.isIOS/Platform.isAndroid 조건으로 분기 처리합니다.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Layout Demo',
      theme: ThemeData(
        primaryColor: Color(0xff4A9BF6), // 04.29 - NOTE : Color hex로 사용 시, Color(0xff{#hex})
      ),
      initialRoute: RouteName.root,
      routes: namedRoutes,
    );
  }
}

// 04.25 - NOTE: CupertinoApp
// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoApp(
//       title: 'CupertinoApp Example',
//       theme: const CupertinoThemeData(
//         primaryColor: CupertinoColors.activeBlue,
//       ),
//       initialRoute: RouteName.cupertinoRoot,
//       routes: namedRoutes,
//     );
//   }
// }

// 04.25 - NOTE: WidgetsApp
// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return WidgetsApp(
//       color: const Color(0xFFFFFFFF),
//       title: 'Widgets App',
//       initialRoute: RouteName.cupertinoRoot, // home: const RootView(title: 'Flutter Layout Demo'),
//       routes: namedRoutes, // { 'root': (context) => const RootView(title: 'Flutter Layout Demo'), },
//       navigatorKey: GlobalKey<NavigatorState>(),
//       pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) {
//         return PageRouteBuilder<T>(
//           pageBuilder: (_, __, ___) => builder(context),
//         );
//       },
//     );
//   }
// }