import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawprints/widgets/index.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  final String title = '커뮤니티';

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: widget.title,
      // leadingItem: SvgPicture.asset('assets/icons/chevron_left.svg', width: 24, height: 24),
      trailingItems: [
        SvgPicture.asset('assets/icons/search.svg', width: 24, height: 24),
        SvgPicture.asset('assets/icons/my_off.svg', width: 24, height: 24),
      ],
      body: Center(
        child: CustomText(
          '커뮤니티',
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}