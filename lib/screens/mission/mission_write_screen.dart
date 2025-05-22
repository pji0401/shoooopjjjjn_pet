import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/config/route/route_path.dart';
import 'package:pawprints/config/theme/colors.dart';
import 'package:pawprints/services/app_logger.dart';
import 'package:pawprints/widgets/base_scaffold.dart';
import 'package:pawprints/widgets/elevated_button.dart';
import 'package:pawprints/widgets/sections.dart';

class MissionWriteScreen extends StatefulWidget {
  const MissionWriteScreen({super.key});

  @override
  State<MissionWriteScreen> createState() => _MissionWriteScreenState();
}

class _MissionWriteScreenState extends State<MissionWriteScreen> {
  final TextEditingController _textController = TextEditingController();
  String _selectedDateString = "2025.04.17";

  // ImageAttachingSection의 상태에 접근하기 위한 GlobalKey
  final GlobalKey<ImageAttachingSectionState> _imageSectionKey =
      GlobalKey<ImageAttachingSectionState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDateString =
            "${picked.year}.${picked.month.toString().padLeft(2, '0')}.${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: '미션 인증',
      leadingItem: IconButton(
        icon:
            const Icon(Icons.arrow_back_ios, size: 20, color: AppColors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),

      // ----- BODY -----
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Image Gallery Section ---
              ImageAttachingSection(
                key: _imageSectionKey,
              ),

              const SizedBox(height: 24),

              // ----- Date Picker Section -----
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/schedule.svg'),
                      const SizedBox(width: 12),
                      Text(
                        _selectedDateString,
                        style: const TextStyle(
                            fontSize: 16, color: AppColors.black),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Text Input Section
              Container(
                height: 250,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _textController,
                  maxLines: null, // Allows for multi-line input
                  expands: true, // Makes TextField fill the container
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    hintText: '텍스트를 남기세요~',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: AppColors.grey),
                  ),
                ),
              ),

              const Spacer(),

              // Submit Button
              CustomElevatedButton(
                text: '인증하기',
                onPressed: () {
                  final List<CardItem> attachedImages =
                      _imageSectionKey.currentState?.currentImages ?? [];
                  final String missionText = _textController.text;
                  final String selectedDate = _selectedDateString;

                  // 여기서 attachedImages, missionText, selectedDate를 사용하여
                  // 서버 전송 또는 다른 필요한 로직을 수행합니다.
                  AppLogger.i('첨부된 이미지 수: ${attachedImages.length}');
                  AppLogger.i('입력된 텍스트: $missionText');
                  AppLogger.i('선택된 날짜: $selectedDate');

                  context.push(RoutePath.mission_complete.value);
                },
                backgroundColor: const Color(0xFF4A80F0),
                height: 56,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
