import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/config/route/route_path.dart';
import 'package:pawprints/config/theme/colors.dart';
import 'package:pawprints/widgets/base_scaffold.dart';
import 'package:pawprints/widgets/elevated_button.dart';

// class that holds image data
class CardItem {
  final String id;
  final String imageUrl;

  CardItem({required this.imageUrl}) : id = UniqueKey().toString();
}

class MissionWriteScreen extends StatefulWidget {
  const MissionWriteScreen({super.key});

  @override
  State<MissionWriteScreen> createState() => _MissionWriteScreenState();
}

class _MissionWriteScreenState extends State<MissionWriteScreen> {
  final TextEditingController _textController = TextEditingController();
  String _selectedDateString = "2025.04.17"; 

  // Sampe list of images
  final List<CardItem> _imageItems = [
    CardItem(imageUrl: 'https://images.unsplash.com/photo-1541451563641-c2bdc370f58a?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    CardItem(imageUrl: 'https://images.unsplash.com/photo-1505628346881-b72b27e84530?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fGNhdCUyMGZsb3dlcnxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60'),
  ];

  final int maxImages = 10;

  void _addImage() {
    if (_imageItems.length < 10) {
      setState(() {
        _imageItems.add(CardItem(imageUrl: 'https://images.unsplash.com/photo-1517423440428-a5a00ad493e8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8ZnVubnklMjBkb2d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'));
      });
    }
  }

  void _removeImage(String id) {
    setState(() {
      _imageItems.removeWhere((item) => item.id == id);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDateString = "${picked.year}.${picked.month.toString().padLeft(2, '0')}.${picked.day.toString().padLeft(2, '0')}";
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
    // dynamic height for images, [screen height / 3.5 or 4] 
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
              SizedBox(
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
                                    border: Border.all(color: Colors.grey.shade200, width: 4),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      item.imageUrl,
                                      fit: BoxFit.fill,
                                      loadingBuilder: (context, child, progress) {
                                        if (progress == null) return child;
                                        return const Center(child: CircularProgressIndicator());
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey.shade200,
                                          child: const Icon(Icons.broken_image, color: Colors.grey),
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
                                        color: Colors.white.withValues(alpha: 0.6),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.close, color: AppColors.black, size: 14),
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
              ),

              const SizedBox(height: 24),

              // ----- Date Picker Section ----- 
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
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
                        _selectedDateString,
                        style: const TextStyle(fontSize: 16, color: AppColors.black),
                      ),
                    ],
                  ),
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