import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/widgets/base_scaffold.dart';
import 'package:pawprints/widgets/elevated_button.dart';
import 'package:pawprints/widgets/sections.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:pawprints/utils/index.dart';
import 'package:pawprints/viewmodels/index.dart';
import 'package:pawprints/core/network/index.dart';

class MissionWriteScreen extends StatefulWidget {
  const MissionWriteScreen({super.key});

  @override
  State<MissionWriteScreen> createState() => _MissionWriteScreenState();
}

class _MissionWriteScreenState extends State<MissionWriteScreen> {
  final TextEditingController _textController = TextEditingController();

  // ImageAttachingSection의 상태에 접근하기 위한 GlobalKey
  final GlobalKey<ImageAttachingSectionState<MissionProvider>> _imageSectionKey =
  GlobalKey<ImageAttachingSectionState<MissionProvider>>();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MissionProvider>(context);
    return BaseScaffold(
      title: '미션 인증',
      leadingItem: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/chevron_left.svg',
          colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
        ),
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
              ImageAttachingSection<MissionProvider>(
                key: _imageSectionKey,
              ),

              const SizedBox(height: 24),

              // ----- CurrentDate Section -----
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/schedule.svg'),
                    const SizedBox(width: 12),
                    Text(
                      getCurrentDate(),
                      style: const TextStyle(fontSize: 16, color: AppColors.black),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Text Input Section
              Container(
                height: 250, 
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  if (!_textController.text.isEmpty && !(provider.imageItemCount == 0)) {
                    provider.completeMission(request: MissionCompleteRequest(missionId: provider.mission.data?.id ?? 1, memberId: SharedPreferencesHelper().memberId, body: "success", date: "2025-05-22")).then((_) {
                      if (provider.compeltedMissionId.uiState == UIState.COMPLETED) {
                        AppLogger.d("✅ missionComplete: ${provider.compeltedMissionId.data?.id}");
                        context.go(RoutePath.mission_complete.value, extra: provider.compeltedMissionId.data?.id);
                      } else {
                        AppLogger.d("⚠️ data is null or wrong type");
                      }
                    });
                  }
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