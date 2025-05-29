import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:pawprints/viewmodels/index.dart';
import 'package:pawprints/widgets/index.dart';
import 'package:pawprints/utils/index.dart';
import 'package:pawprints/core/network/index.dart';

class SignUpPetScreen extends StatefulWidget {
  const SignUpPetScreen({super.key});

  @override
  State<SignUpPetScreen> createState() => SignUpPetScreenState();
}

class SignUpPetScreenState extends State<SignUpPetScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
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
              '이름',
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
              controller: _nameController,
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
                fillColor: AppColors.lightGrey,
                border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '반려동물의 이름을 입력해 주세요.',
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
              '생년월일',
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
            GestureDetector(
              onTap: () => provider.selectDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text(
                      provider.selectedDateString,
                      style: TextStyle(
                        color: Color(0xff989898),
                        fontSize: 15,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 20 / 15,
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(width: 175),
                    SvgPicture.asset('assets/icons/schedule.svg'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '반려동물의 생년월일을 선택해 주세요.',
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
              '성별',
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
            GenderPicker(
              selectedGender: provider.pgender,
              onGenderSelected: (gender) {
                setState(() {
                  provider.pgender = gender;
                });
              },
            ),
            const SizedBox(height: 6),
            const Text(
              '반려동물의 성별을 선택해 주세요.',
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
                  if (_nameController.text.isNotEmpty && provider.pgender.isNotEmpty) {
                    final provider = Provider.of<UserProvider>(context, listen: false);
                    provider.petName = _nameController.text;
                    provider.register(request: RegisterRequest(userId: provider.userId, password: provider.password, name: provider.name, statusNote: provider.statusNote, petName: provider.petName, pbirthday: provider.pbirthday, pgender: provider.pgender)).then((_) {
                      if (provider.memberId.uiState == UIState.COMPLETED) {
                        AppLogger.d('✅ register: ${provider.memberId.data?.id}');
                        context.push(RoutePath.signup_welcome.value);
                      } else {
                        AppLogger.d('⚠️ data is null or wrong type');
                      }
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.main,
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