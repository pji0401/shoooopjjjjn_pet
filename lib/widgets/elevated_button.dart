import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = const Color(0xFF3A8DFF),
    this.height = 50,
    this.borderRadius = 10,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF3A8DFF),
          padding: padding ?? const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xffffffff),
            fontSize: 17,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
            height: 20 / 17,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}
