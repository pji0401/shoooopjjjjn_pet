import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawprints/widgets/index.dart';

class CareScreen extends StatefulWidget {
  const CareScreen({super.key});

  final String title = '케어';

  @override
  _CareScreenState createState() => _CareScreenState();
}

class _CareScreenState extends State<CareScreen> {

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: widget.title,
      // leadingItem: SvgPicture.asset('assets/icons/chevron_left.svg', width: 24, height: 24),
      trailingItems: [
        SvgPicture.asset('assets/icons/favorite.svg', width: 24, height: 24),
        SvgPicture.asset('assets/icons/cart.svg', width: 24, height: 24),
      ],
      body: Center(
        child: CustomText(
          '케어',
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}