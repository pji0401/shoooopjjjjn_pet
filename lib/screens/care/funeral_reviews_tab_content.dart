import 'package:flutter/material.dart';

// Assuming AppColors is accessible
class AppColors {
  static const Color darkGrey = Color(0xFF757575);
}

class FuneralReviewsTabContent extends StatelessWidget {
  const FuneralReviewsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          '리뷰 정보가 곧 업데이트 될 예정입니다.',
          style: TextStyle(fontSize: 16, color: AppColors.darkGrey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}