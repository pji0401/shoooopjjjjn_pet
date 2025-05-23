import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/config/route/route_path.dart';
import 'package:pawprints/config/theme/colors.dart';
import 'package:pawprints/widgets/base_scaffold.dart';
import 'package:pawprints/widgets/elevated_button.dart';
import 'package:pawprints/widgets/sections.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final GlobalKey<ImageAttachingSectionState> _imageSectionKey =
  GlobalKey<ImageAttachingSectionState>();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MissionProvider>(context);
    final double imageHeight = MediaQuery.of(context).size.height / 3.4; // Adjust this ratio as needed
    final double imageWidth = imageHeight * 0.8; // To make it slightly portrait

    return BaseScaffold(
      title: '미션 인증',
      leadingItem: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20, color: AppColors.black), 
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
              // SizedBox(
              //   height: imageHeight + 30,
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       // --- Add Button ---
              //       Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           GestureDetector(
              //             onTap: () => _getImage(ImageSource.gallery, provider),
              //             child: Container(
              //               width: 60,
              //               height: 60,
              //               decoration: BoxDecoration(
              //                 color: AppColors.main,
              //                 borderRadius: BorderRadius.circular(6),
              //               ),
              //               child: const Icon(Icons.add, color: Colors.white, size: 35),
              //             ),
              //           ),
              //
              //           const SizedBox(height: 8),
              //
              //           RichText(
              //               text: TextSpan(
              //                   children: <TextSpan>[
              //                     TextSpan(
              //                       text: "${provider.imageItemCount}",
              //                       style: const TextStyle(
              //                         color: AppColors.black,
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.w500,
              //                       ),
              //                     ),
              //                     TextSpan(
              //                       text: "/",
              //                       style: const TextStyle(
              //                         color: AppColors.black,
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.w500,
              //                       ),
              //                     ),
              //                     TextSpan(
              //                       text: "${provider.maxImageCount}",
              //                       style: const TextStyle(
              //                         color: AppColors.main,
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.w500,
              //                       ),
              //                     ),
              //                   ]
              //               )
              //           ),
              //           // Text(
              //           //   "${_imageItems.length}/$maxImages",
              //           //   style: const TextStyle(
              //           //     color: AppColors.main,
              //           //     fontSize: 14,
              //           //     fontWeight: FontWeight.w500,
              //           //   ),
              //           // ),
              //         ],
              //       ),
              //
              //       const SizedBox(width: 16),
              //
              //       // --- Horizontally Scrollable Images ---
              //       Expanded(
              //         child: ListView.builder(
              //           scrollDirection: Axis.horizontal,
              //           itemCount: provider.imageItemCount,
              //           itemBuilder: (context, index) {
              //             final item = provider.images[index];
              //             return Padding(
              //               padding: const EdgeInsets.only(right: 12.0),
              //               child: Stack(
              //                 children: [
              //                   item != null
              //                       ? Container(
              //                     width: imageWidth,
              //                     height: imageHeight,
              //                     decoration: BoxDecoration(
              //                       borderRadius:
              //                       BorderRadius.circular(18),
              //                       border: Border.all(
              //                           color: Colors.grey.shade200,
              //                           width: 4),
              //                     ),
              //                     child: ClipRRect(
              //                       borderRadius:
              //                       BorderRadius.circular(10),
              //                       child: Image.file(
              //                         File(item.path),
              //                         fit: BoxFit.fill,
              //                         // loadingBuilder: (context, child, progress) {
              //                         //   if (progress == null) return child;
              //                         //   return const Center(child: CircularProgressIndicator());
              //                         // },
              //                         errorBuilder:
              //                             (context, error, stackTrace) {
              //                           return Container(
              //                             color: Colors.grey.shade200,
              //                             child: const Icon(
              //                                 Icons.broken_image,
              //                                 color: Colors.grey),
              //                           );
              //                         },
              //                       ),
              //                     ),
              //                   )
              //                       : Container(
              //                     color: Colors.grey.shade200,
              //                     child: const Icon(Icons.broken_image,
              //                         color: Colors.grey),
              //                   ),
              //                   Positioned(
              //                     top: 8,
              //                     right: 8,
              //                     child: GestureDetector(
              //                       onTap: () => _removeImage(item, provider),
              //                       child: Container(
              //                         padding: const EdgeInsets.all(4),
              //                         decoration: BoxDecoration(
              //                           color: Colors.white.withValues(alpha: 0.6),
              //                           shape: BoxShape.circle,
              //                         ),
              //                         child: const Icon(Icons.close, color: AppColors.black, size: 14),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             );
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

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
                onPressed: () async {
                  // API 호출
                  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  if (!_textController.text.isEmpty && !(provider.imageItemCount == 0)) {
                    provider.completeMission(request: MissionCompleteRequest(missionId: provider.mission.data?.id ?? 1, memberId: sharedPreferences.getInt('memberId') ?? 1, body: "success", date: "2025-05-22")).then((_) {
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