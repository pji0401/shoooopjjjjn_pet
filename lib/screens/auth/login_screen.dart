import 'package:flutter/material.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/widgets/index.dart';
import 'package:pawprints/utils/index.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:pawprints/viewmodels/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _autoLogin = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    return BaseScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                '로그인',
                style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 23,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  height: 20 / 23,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '아이디',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 20 / 13,
                    letterSpacing: 0,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _idController,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: '영문 아이디를 입력하세요',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Pretendard',
                  ),
                  filled: true,
                  fillColor: Color(0xfff5f5f9),
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '비밀번호',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 20 / 13,
                    letterSpacing: 0,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: '비밀번호를 입력하세요',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Pretendard',
                  ),
                  filled: true,
                  fillColor: AppColors.lightGrey,
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: _autoLogin,
                      onChanged: (value) {
                        setState(() {
                          _autoLogin = value ?? false;
                        });
                      },
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    const Text('자동로그인'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!_idController.text.isEmpty && !_passwordController.text.isEmpty) {
                      provider.login(request: LoginRequest(userId: _idController.text, password: _passwordController.text)).then((_) {
                        if (provider.id.uiState == UIState.COMPLETED) {
                          AppLogger.d("✅ login: ${provider.id.data?.id}");
                          if (provider.id.data != null)
                          SharedPreferencesHelper().setMemberId(provider.id.data!.id);
                          context.push(RoutePath.root.value);
                        } else {
                          AppLogger.d("⚠️ data is null or wrong type");
                        }
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.main,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    splashFactory: NoSplash.splashFactory,
                    elevation: 0,
                  ),
                  child: const Text(
                    '로그인하기',
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
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('아이디 찾기', style: TextStyle(color: Color(0xff626262))),
                    ),
                    const Text('|', style: TextStyle(color: Color(0xff626262))),
                    TextButton(
                      onPressed: () {},
                      child: const Text('비밀번호 찾기', style: TextStyle(color: Color(0xff626262))),
                    ),
                    const Text('|', style: TextStyle(color: Color(0xff626262))),
                    TextButton(
                      onPressed: () {
                        context.push(RoutePath.signup_user.value);
                      },
                      child: const Text('회원가입', style: TextStyle(color: Color(0xff626262))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
