import 'package:flutter/material.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/widgets/index.dart';

class SignUpUserScreen extends StatelessWidget {
  const SignUpUserScreen({super.key});

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
              '1/3',
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
              '가입 정보',
              style: TextStyle(
                color: Color(0xff000000),
                fontSize: 23,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                height: 20 / 23,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              '아이디',
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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(fontSize: 15),
                    decoration: const InputDecoration(
                      hintText: '아이디 입력',
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
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 44,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Color(0xFFF9583D),
                      side: const BorderSide(color: Color(0xFFF9583D)),
                      backgroundColor: Colors.white,
                      textStyle: const TextStyle(color: Color(0xFFF9583D), fontSize: 14, fontFamily: 'Pretendard', fontWeight: FontWeight.w400, height: 20 / 14, letterSpacing: 0),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('중복확인'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              '4-12자/영문 대소문자, 숫자로 입력해 주세요.',
              style: TextStyle(
                color: Color(0xff6d6d6d),
                fontSize: 11,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                height: 20 / 11,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              '비밀번호',
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
              obscureText: true,
              style: const TextStyle(fontSize: 15),
              decoration: const InputDecoration(
                hintText: '비밀번호 입력',
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
              '영문, 숫자, 특수문자 포함 8자 이상으로 입력해 주세요.',
              style: TextStyle(
                color: Color(0xff6d6d6d),
                fontSize: 11,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                height: 20 / 11,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              obscureText: true,
              style: const TextStyle(fontSize: 15),
              decoration: const InputDecoration(
                hintText: '비밀번호 재확인',
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
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  context.push(RoutePath.signup_profile.value);
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