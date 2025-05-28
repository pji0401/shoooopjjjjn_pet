import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawprints/config/theme/colors.dart';
import 'package:pawprints/viewmodels/index.dart';

/// 이미지 카드 아이템 데이터 모델.
///
/// 각 카드의 고유 ID와 이미지 URL 정보를 저장.
///
/// 필드:
///
///      id (String):         고유 식별자. [UniqueKey]를 문자열로 변환하여 자동 생성.
///      imageUrl (String):   표시할 이미지의 URL.
///
/// 생성자:
///
///      CardItem ({required String imageUrl}):
///           [imageUrl]을 필수로 받아 객체 생성. [id]는 내부적으로 자동 할당.
class CardItem {
  final String id;
  final String imageUrl;

  CardItem({required this.imageUrl}) : id = UniqueKey().toString();
}

/// 이미지 첨부 UI 섹션.
///
/// 사용자가 이미지를 선택하여 첨부하고, 기존 이미지를 제거하는 기능을 제공.
/// 상태 관리는 [ImageAttachingSectionState]에서 수행.
class ImageAttachingSection<T extends ImageAttachProvider> extends StatefulWidget {
  const ImageAttachingSection({super.key});

  @override
  State<ImageAttachingSection<T>> createState() => ImageAttachingSectionState<T>();
}
class ImageAttachingSectionState<T extends ImageAttachProvider> extends State<ImageAttachingSection<T>> {
  final ImagePicker picker = ImagePicker();

  Future<void> _getImage(ImageSource imageSource, T provider) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      provider.addImage(File(pickedFile.path));
    }
  }

  void _removeImage(File? item, T provider) {
    provider.removeImage(item);
  }

  @override
  Widget build(BuildContext context) {
    // dynamic height for images, [screen height / 3.5 or 4]
    final double imageHeight =
        MediaQuery.of(context).size.height / 3.4; // Adjust this ratio as needed
    final double imageWidth = imageHeight * 0.8; // To make it slightly portrait

    return SizedBox(
      height: imageHeight + 30,
      child: Consumer<T>(
        builder: (context, provider, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Add Button ---
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _getImage(ImageSource.gallery, provider),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.main,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 35),
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: "${provider.imageItemCount}",
                          style: const TextStyle(
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "/",
                          style: const TextStyle(
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "${provider.maxImageCount}",
                          style: const TextStyle(
                            color: AppColors.main,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ])),
                ],
              ),
              const SizedBox(width: 16),
              // --- Horizontally Scrollable Images ---
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.imageItemCount,
                  itemBuilder: (context, index) {
                    final item = provider.images[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Stack(
                        children: [
                          Container(
                            width: imageWidth,
                            height: imageHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              border:
                              Border.all(color: Colors.grey.shade200, width: 4),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(item.path),
                                fit: BoxFit.fill,
                                // loadingBuilder: (context, child, progress) {
                                //   if (progress == null) return child;
                                //   return const Center(child: CircularProgressIndicator());
                                // },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey.shade200,
                                    child: const Icon(Icons.broken_image,
                                        color: Colors.grey),
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () => _removeImage(item, provider),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.6),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close,
                                    color: AppColors.black, size: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      )
    );
  }
}
