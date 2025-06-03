import 'package:flutter/material.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/widgets/index.dart';

class SignUpWelcomeScreen extends StatefulWidget {
  final String userName;

  const SignUpWelcomeScreen({super.key, required this.userName});

  @override
  State<SignUpWelcomeScreen> createState() => SignUpWelcomeScreenState();
}

class SignUpWelcomeScreenState extends State<SignUpWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 75),
            Text(
              '${widget.userName}님,\n환영합니다!',
              style: TextStyle(
                color: Color(0xff000000),
                fontSize: 30,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                height: 33 / 30,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pawprint와 함께 매일\n새로운 추억을 쌓아보세요',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff909090),
                fontSize: 18,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                height: 26 / 18,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 75),
            Center(
              child: SizedBox(
                width: 280,
                height: 305,
                child: Image.asset(
                  'assets/datas/welcome.png',
                  width: 280,
                  height: 305,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  context.push(RoutePath.root.value, extra: 0);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A9BF6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text(
                  '시작하기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 17,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 20 / 17,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}