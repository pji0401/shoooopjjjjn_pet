import 'package:flutter/material.dart';
import 'package:pawprints/config/theme/colors.dart';

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
class ImageAttachingSection extends StatefulWidget {
  /// {@macro image_attaching_section}
  const ImageAttachingSection({super.key});

  @override
  State<ImageAttachingSection> createState() => ImageAttachingSectionState();
}

/// {@template image_attaching_section_state}
/// [ImageAttachingSection] 위젯의 상태 관리 클래스.
///
/// 이미지 목록, 최대 이미지 수, 이미지 추가/제거 로직 및 UI 렌더링 담당.
/// {@endtemplate}
///
/// 필드:
///
///      _imageItems (List<CardItem>):     내부 이미지 아이템 목록.
///      maxImages (int):                  첨부 가능한 최대 이미지 개수.
///
/// 게터:
///
///      currentImages (List<CardItem>):   현재 첨부된 이미지 목록 반환.
///
/// 메서드:
///
///      _addImage ():                     새로운 샘플 이미지 추가.
///      _removeImage (String id):         제공된 ID와 일치하는 이미지 제거.
///      build (BuildContext context):     이미지 첨부 섹션 UI 구성 및 반환.
class ImageAttachingSectionState extends State<ImageAttachingSection> {
  final List<CardItem> _imageItems = [
    CardItem(
        imageUrl:
            'https://images.unsplash.com/photo-1541451563641-c2bdc370f58a?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    CardItem(
        imageUrl:
            'https://images.unsplash.com/photo-1505628346881-b72b27e84530?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fGNhdCUyMGZsb3dlcnxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60'),
  ];

  final int maxImages = 10;

  List<CardItem> get currentImages => _imageItems;

  void _addImage() {
    if (_imageItems.length < maxImages) {
      setState(() {
        _imageItems.add(CardItem(
            imageUrl:
                'https://images.unsplash.com/photo-1517423440428-a5a00ad493e8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8ZnVubnklMjBkb2d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'));
      });
    }
  }

  void _removeImage(String id) {
    setState(() {
      _imageItems.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // dynamic height for images, [screen height / 3.5 or 4]
    final double imageHeight =
        MediaQuery.of(context).size.height / 3.4; // Adjust this ratio as needed
    final double imageWidth = imageHeight * 0.8; // To make it slightly portrait

    return SizedBox(
      height: imageHeight + 30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Add Button ---
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _addImage,
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
              Text(
                "${_imageItems.length}/$maxImages",
                style: const TextStyle(
                  color: AppColors.main,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // --- Horizontally Scrollable Images ---
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _imageItems.length,
              itemBuilder: (context, index) {
                final item = _imageItems[index];
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
                          child: Image.network(
                            item.imageUrl,
                            fit: BoxFit.fill,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
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
                          onTap: () => _removeImage(item.id),
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
      ),
    );
  }
}
