import 'package:flutter/material.dart';

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
        Key? key,
        this.textAlign = TextAlign.center,
        this.color = Colors.black,
        this.fontSize = 12,
        this.fontWeight = FontWeight.w600,
        this.height = 20,
        this.letterSpacing = 0,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: "Pretendard",
        fontWeight: fontWeight,
        height: height,
        letterSpacing: letterSpacing,
      ),
    );
  }
}