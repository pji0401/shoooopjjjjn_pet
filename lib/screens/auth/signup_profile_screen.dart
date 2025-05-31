import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/viewmodels/index.dart';
import 'package:pawprints/widgets/index.dart';

class SignUpProfileScreen extends StatefulWidget {
  const SignUpProfileScreen({super.key});

  @override
  State<SignUpProfileScreen> createState() => SignUpProfileScreenState();
}

class SignUpProfileScreenState extends State<SignUpProfileScreen> {
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _statusMessageController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  Future<void> _getImage(ImageSource imageSource, UserProvider provider) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      provider.addImage(File(pickedFile.path));
    }
  }

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
          bottom: 83,
          left: 24.0,
          right: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              '2/3',
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
              '프로필 정보',
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
              '프로필 사진을 등록해 주세요',
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
            Consumer<UserProvider>(
              builder: (context, provider, child) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          _getImage(ImageSource.gallery, provider);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.main,
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                        ),
                        child: const Text(
                          '프로필 등록',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: AppColors.main,
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 20 / 16,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF4F4F4),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: ClipOval(child: Image.file(
                                    provider.image ?? File(""),
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 90,
                                        height: 90,
                                        color: Colors.grey.shade200,
                                        child: const Icon(Icons.pets, size: 36, color: Color(0xFFDDDDDD)),
                                      );
                                    },
                                  ),
                                ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(4),
                            child: InkWell(
                              onTap: () {
                                _getImage(ImageSource.camera, provider);
                              },
                              child: Icon(Icons.camera_alt, size: 20, color: Color(0xFF888888)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            ),
            const SizedBox(height: 32),
            const Text(
              '닉네임',
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
              controller: _nickNameController,
              style: const TextStyle(fontSize: 15),
              decoration: const InputDecoration(
                hintText: '닉네임 입력',
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
              controller: _statusMessageController,
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
                fillColor: AppColors.lightGrey,
                border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(12))),
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
                  if (_nickNameController.text.isNotEmpty && _statusMessageController.text.isNotEmpty) {
                    provider.name = _nickNameController.text;
                    provider.statusNote = _statusMessageController.text;
                    context.push(RoutePath.signup_pet.value);
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