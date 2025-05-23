import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/widgets/index.dart';

class SignUpPetScreen extends StatelessWidget {
  const SignUpPetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      leadingItem: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          onPressed: () {
            context.pop();
          }
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 34,
          bottom: 83,
          left: 24.0,
          right: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              '3/3',
              style: TextStyle(
                color: Color(0xff848484),
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                height: 20 / 13,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '반려동물 정보',
              style: TextStyle(
                color: Color(0xff000000),
                fontSize: 23,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                height: 20 / 23,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 150),
            const Text(
              '반려동물 이름 입력',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                height: 20 / 16,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(fontSize: 15),
              decoration: const InputDecoration(
                hintText: '반려동물 이름 입력',
                hintStyle: TextStyle(
                  color: Color(0xff989898),
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  height: 20 / 15,
                  letterSpacing: 0,
                ),
                filled: true,
                fillColor: Color(0xFFF4F4F4),
                border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(8))),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              '한글, 영어, 숫자만 입력해 주세요.',
              style: TextStyle(
                color: Color(0xff6d6d6d),
                fontSize: 11,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                height: 20 / 11,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '상태 메시지',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                height: 20 / 16,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(fontSize: 15),
              decoration: const InputDecoration(
                hintText: '상태 메시지 입력',
                hintStyle: TextStyle(
                  color: Color(0xff989898),
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  height: 20 / 15,
                  letterSpacing: 0,
                ),
                filled: true,
                fillColor: Color(0xFFF4F4F4),
                border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(8))),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              '상태 메세지를 입력해 주세요.',
              style: TextStyle(
                color: Color(0xff6d6d6d),
                fontSize: 11,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                height: 20 / 11,
                letterSpacing: 0,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  context.push(RoutePath.signup_welcome.value);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A8DFF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text(
                  '다음으로',
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
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}