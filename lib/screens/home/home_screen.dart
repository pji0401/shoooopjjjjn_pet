import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawprints/widgets/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      leadingWidth: 100,
      leadingItem: SvgPicture.asset('assets/icons/pawprint.svg'),
      trailingItems: [
        SvgPicture.asset('assets/icons/notification.svg', width: 24, height: 24),
        SvgPicture.asset('assets/icons/schedule.svg', width: 24, height: 24),
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