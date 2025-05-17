import 'package:flutter/material.dart';
import 'package:pawprints/widgets/base_scaffold.dart';
import 'package:pawprints/widgets/elevated_button.dart';
import 'package:go_router/go_router.dart';
import 'package:pawprints/config/theme/colors.dart';

class MissionWriteScreen extends StatefulWidget {
  const MissionWriteScreen({super.key});

  @override
  State<MissionWriteScreen> createState() => _MissionWriteScreenState();
}

class _MissionWriteScreenState extends State<MissionWriteScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<String> images = ['assets/images/dog_home_test.jpg', 'assets/images/dog_home_test.jpg'];
  String selectedDate = '2025.04.17';

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
        icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      // !!!!!!!! 이부분 다시 할 예정 05/17 !!!!!!!!!!!!!!!!
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Image gallery row
              SizedBox(
                height: 300,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add button and counter
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4285F4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: IconButton(
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                // Image picker logic here
                              },
                            )
                          )
                        ),
                        
                        const SizedBox(height: 5),
                        
                        Text(
                          '${images.length}/10',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(width: 12),
                    
                    // Image scrollable list
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: images.map((image) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Stack(
                                children: [
                                  // Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(
                                      image,
                                      width: 220,
                                      height: 300,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  
                                  // Delete button
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Remove image logic
                                        setState(() {
                                          images.remove(image);
                                        });
                                      },
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: const BoxDecoration(
                                          color: Colors.black38,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Date selector
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
                    const SizedBox(width: 12),
                    Text(
                      selectedDate,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Text input
              Container(
                width: double.infinity,
                height: 180,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _textController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: '봄이랑 벚꽃 보기 미션 완료!',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              
              const Spacer(),
              
              // Submit button
              CustomElevatedButton(
                onPressed: () {
                  // Submission logic here
                },
                text: '인증하기',
                backgroundColor: const Color(0xFF4285F4),
                height: 56,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
