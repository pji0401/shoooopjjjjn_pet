import 'package:flutter/material.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/viewmodels/index.dart';
import 'package:pawprints/data/repositories/index.dart';
import 'package:pawprints/core/network/index.dart';

// 04.25 - NOTE: MaterialApp - 기본적으로 머테리얼 앱 구조를 채택합니다. 필요에 따라 내부 위젯만 Platform.isIOS/Platform.isAndroid 조건으로 분기 처리합니다.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final dioClient = DioClient();
    return MultiProvider(
      providers: [
        // NOTE: Dependency Injection (Provider default)
        ChangeNotifierProvider(create: (context) => UserProvider(UserRepository(dioClient))),
        ChangeNotifierProvider(create: (context) => MissionProvider(MissionRepository(dioClient))),
        ChangeNotifierProvider(create: (context) => MemoryProvider(MemoryRepository(dioClient))),
        ChangeNotifierProvider(create: (context) => CommunityProvider(CommunityRepository(dioClient))),
        ChangeNotifierProvider(create: (context) => ChatProvider(ChatRepository())),
      ],
      child: MaterialApp.router(
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}