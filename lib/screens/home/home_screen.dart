import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawprints/widgets/index.dart';
import 'package:pawprints/config/index.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      leadingWidth: 100, // 05.08 - NOTE: AppBar leadingItem width overflow 해결 (temp)
      leadingItem: SvgPicture.asset('assets/icons/pawprint.svg'),
      trailingItems: [
        IconButton(
          icon: SvgPicture.asset('assets/icons/notification_on.svg', width: 24, height: 24),
          onPressed: () {
            context.push(RoutePath.notification.value);
          }
        ),
        IconButton(
          icon: SvgPicture.asset('assets/icons/schedule.svg', width: 24, height: 24),
          onPressed: () {
            context.push(RoutePath.schedule.value);
          }
        ),
      ],
      body: Center(
        child: CustomText(
          '홈',
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}