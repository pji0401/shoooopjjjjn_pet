import 'package:flutter/material.dart';
import 'package:pawprints/config/theme/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final double letterSpacing;

  const CustomText(
    this.text, {
    super.key,
    this.textAlign = TextAlign.center,
    this.color = Colors.black,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w600,
    this.height = 20,
    this.letterSpacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: 'Pretendard',
        fontWeight: fontWeight,
        height: height,
        letterSpacing: letterSpacing,
      ),
    );
  }
}

// Blue Colored Text at HomeScreen
class BlueColoredText extends StatelessWidget {
  final String text;
  final double fontSize;

  const BlueColoredText({
    required this.text,
    this.fontSize = 26.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          fontSize: fontSize,
          color: AppColors.main,
          fontWeight: FontWeight.bold,
        ));
  }

  // Helper method to get a TextSpan with the same styling
  static TextSpan toTextSpan(String text, {double fontSize = 16.0}) {
    return TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          color: AppColors.main,
          fontWeight: FontWeight.bold,
        ));
  }
}

/// 홈 섹션 헤더 위젯.
///
/// 섹션 제목 표시.
///
/// Args:
///
///     text (String):
///          표시할 제목 문자열.
class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ));
  }
}
