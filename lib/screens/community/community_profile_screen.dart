import 'package:flutter/material.dart';
import 'package:pawprints/widgets/index.dart';

class CommunityProfileScreen extends StatelessWidget {
  const CommunityProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        title: '',
        leadingItem: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // 프로필 이미지
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    'https://via.placeholder.com/80', // 실제 이미지로 교체 필요
                  ),
                ),
                const SizedBox(width: 16),

                // 닉네임과 프로필 메시지
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '사용자닉네임',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '안녕하세요! 반갑습니다.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
