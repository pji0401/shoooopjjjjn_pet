import 'package:flutter/material.dart';
import 'package:pawprints/config/theme/colors.dart';

// class that holds image data
class CardItem {
  final String id;
  final String imageUrl;

  CardItem({required this.imageUrl}) : id = UniqueKey().toString();
}

class ImageAttachingSection extends StatefulWidget {
  const ImageAttachingSection({super.key});

  @override
  State<ImageAttachingSection> createState() => ImageAttachingSectionState();
}

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
