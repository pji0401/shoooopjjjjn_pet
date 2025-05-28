import 'package:flutter/material.dart';
import 'package:pawprints/widgets/index.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  final String title = '마이';

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: widget.title,
      // leadingItem: SvgPicture.asset('assets/icons/chevron_left.svg'),
      trailingItems: [],
      body: Center(
        child: CustomText(
          '',
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}