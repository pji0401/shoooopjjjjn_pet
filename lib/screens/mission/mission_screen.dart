import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/widgets/elevated_button.dart';
import 'package:pawprints/widgets/index.dart';

class MissionScreen extends StatefulWidget {
  const MissionScreen({super.key});

  @override
  State<MissionScreen> createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      // ---------------APP BAR------------------------
      title: '미션 인증',
      leadingItem: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,),
          child: Column(
            children: [
              const SizedBox(height: 120),

              // --------- WHITE CONTAINER ------------
              Container(
                width: double.infinity,
                // height: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ]
                ),

                // --------------- ICON --------------
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ----- SVG ------
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: -30,
                          bottom: -5,
                          child: SvgPicture.asset('assets/icons/mission_paw.svg',
                            width: 90,
                          ),
                        ),
                        SvgPicture.asset('assets/icons/mission_envelope.svg',
                        width: 180,
                        )
                      ]
                    ),

                    const SizedBox(height: 40),

                    // ---------- MISSION DAY BADGE ----------------
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Color(0xFFF0F4FF),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: const Color(0xFF4285F4)
                        )
                      ),
                      child: const Text(
                        '33번째 미션',
                        style: TextStyle(
                          color: Color(0xFF135DB2),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )
                      )
                    ),

                    const SizedBox(height: 20),


                    // --------------- MISSION TEXT ----------------------
                    const Text(
                      '벚꽃 아래서 반려견과 사진찍기',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        height: 1.45,
                        letterSpacing: -0.44,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ]
                )
              ),

              const SizedBox(height: 50),

              CustomElevatedButton(
                onPressed: () {
                  context.push(RoutePath.mission_write.value);
                },
                text: '미션 인증하기',
              ),

              const SizedBox(height: 5),

              TextButton(
                onPressed: () {},
                child: const Text(
                  '건너뛰기',
                  style: TextStyle(
                    color: Color(0xFF8D8D8D),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}