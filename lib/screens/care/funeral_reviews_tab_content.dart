import 'package:flutter/material.dart';

class Review {
  final String id;
  final String username;
  final String avatarUrl;
  final double rating;
  final String date;
  final String text;
  final List<String> imageUrls;
  final int likes;

  Review({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.rating,
    required this.date,
    required this.text,
    this.imageUrls = const [],
    required this.likes,
  });
}


class AppColors {
  static const Color darkGrey = Color(0xFF757575);
  static const Color textBlack = Color(0xFF333333);
  static const Color lightGrey = Color(0xFFF5F5F5); 
  static const Color starBlue = Color(0xFF4A9BF6);
  static const Color buttonBlue = Color(0xFF4A9BF6);
  static const Color borderColor = Color.fromARGB(255, 110, 110, 110); 
}

class FuneralReviewsTabContent extends StatefulWidget {
  const FuneralReviewsTabContent({super.key});

  @override
  State<FuneralReviewsTabContent> createState() => _FuneralReviewsTabContentState();
}

class _FuneralReviewsTabContentState extends State<FuneralReviewsTabContent> {
  bool _showPhotoReviewsOnly = false;
  String _sortOrder = '베스트순'; 

  final List<Review> _reviews = [
    Review(
      id: '1',
      username: 'momolove',
      avatarUrl: 'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?w=100&h=100&fit=crop', // Replace with actual avatar
      rating: 4.5,
      date: '2025.02.04',
      text: '상담부터 장례까지 너무 따뜻하고 세심하게 잘 챙겨주셨습니다. 덕분에 후회없이 마지막까지 함께 할 수 있었어요. 감사합니다. 장례 서비스나 절차에 관한 설명도 꼼꼼하게 해주시고, 충분히 고민할 시간을 주셔서 원하는 방식으로 잘 선택할 수 있었습니다. 믿고 맡길 수 있는 곳으로 추천합니다.',
      imageUrls: [
        'https://i.pinimg.com/736x/02/f1/e7/02f1e73267823b18f08aea87af113e7d.jpg',
        'https://i.pinimg.com/736x/28/3e/b2/283eb2211ef6d446dfce21e1e705445d.jpg',
        'https://i.pinimg.com/736x/fa/bb/8e/fabb8e85949196c65315da8b22d961fd.jpg',
      ],
      likes: 15,
    ),
    // Add more reviews
  ];

  List<Review> get _filteredReviews {
    List<Review> reviewsToShow = _reviews;
    if (_showPhotoReviewsOnly) {
      reviewsToShow = reviewsToShow.where((r) => r.imageUrls.isNotEmpty).toList();
    }
    return reviewsToShow;
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      // Adjusted padding: Remove horizontal padding from ListView, keep vertical.
      padding: const EdgeInsets.only(top: 16.0, bottom: 80.0),
      children: [
        // Add horizontal padding to the summary header section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _buildReviewSummaryHeader(),
        ),
        const SizedBox(height: 4),
        // This Divider will now be full-width.
        // Adjusted height to match thickness for a 16px band.
        // If you want a thin line (like in the image), set thickness to ~1.0 and choose a lighter color.
        Divider(
          color: Colors.grey.withValues(alpha: 0.15), 
          height: 16,
          thickness: 16,
          indent: 0,
          endIndent: 0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_filteredReviews.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Center(
                    child: Text(
                      _showPhotoReviewsOnly ? '사진 리뷰가 없습니다.' : '리뷰가 없습니다.',
                      style: const TextStyle(fontSize: 16, color: AppColors.darkGrey),
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _filteredReviews.length,
                  itemBuilder: (context, index) {
                    return _buildReviewItem(_filteredReviews[index]);
                  },
                  separatorBuilder: (context, index) => const Divider(height: 32, thickness: 0.5, color: AppColors.borderColor),
                ),
              const SizedBox(height: 30), // Space before action buttons
              _buildActionButtons(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewSummaryHeader() {
    // Calculate average rating - for now, using a placeholder
    double averageRating = 4.9;
    int totalReviews = _reviews.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$totalReviews개의 리뷰',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textBlack),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              averageRating.toStringAsFixed(1),
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.textBlack),
            ),
            const SizedBox(width: 8),
            ...List.generate(5, (index) {
              return Icon(
                index < averageRating.floor() ? Icons.star_rounded : (index < averageRating ? Icons.star_half_rounded : Icons.star_border_rounded),
                color: AppColors.starBlue,
                size: 28,
              );
            }),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: _showPhotoReviewsOnly,
                  onChanged: (bool? value) {
                    setState(() {
                      _showPhotoReviewsOnly = value ?? false;
                    });
                  },
                  activeColor: AppColors.starBlue,
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const Text('사진리뷰만 보기', style: TextStyle(fontSize: 14, color: AppColors.textBlack)),
              ],
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _sortOrder,
                icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.darkGrey, size: 20),
                style: const TextStyle(fontSize: 14, color: AppColors.textBlack),
                items: <String>['베스트순', '최신순']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _sortOrder = newValue!;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReviewItem(Review review) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(review.avatarUrl),
                backgroundColor: AppColors.lightGrey,
              ),
              const SizedBox(width: 10),
              Text(review.username, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ...List.generate(5, (index) {
                return Icon(
                  index < review.rating.floor() ? Icons.star_rounded : (index < review.rating ? Icons.star_half_rounded : Icons.star_border_rounded),
                  color: AppColors.starBlue,
                  size: 18,
                );
              }),
              const SizedBox(width: 8),
              Text(review.date, style: const TextStyle(fontSize: 13, color: AppColors.darkGrey)),
            ],
          ),
          if (review.imageUrls.isNotEmpty) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 100, // Adjust height as needed
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: review.imageUrls.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      review.imageUrls[index],
                      width: 100, // Adjust width as needed
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, st) => Container(width: 100, height: 100, color: AppColors.lightGrey, child: const Icon(Icons.broken_image, color: AppColors.darkGrey)),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 8),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Text(
            review.text,
            style: const TextStyle(fontSize: 14, color: AppColors.textBlack, height: 1.5),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.thumb_up_alt_outlined, size: 18, color: AppColors.darkGrey),
              const SizedBox(width: 4),
              Text(review.likes.toString(), style: const TextStyle(fontSize: 13, color: AppColors.darkGrey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(60, 50),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            side: BorderSide(color: AppColors.darkGrey.withValues(alpha: 0.5), width: 1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          child: const Icon(Icons.phone_outlined, color: Color.fromARGB(255, 29, 133, 252), size: 26),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonBlue,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            child: const Text('예약하기'),
          ),
        ),
      ],
    );
  }
}