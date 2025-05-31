import 'package:flutter/material.dart';
import 'package:pawprints/screens/care/funeral_home_detail_screen.dart';

class AppColors {
  static const Color main = Color(0xff4A9BF6);
  static const Color iconBlueBackground = Color(0xFFEBF4FF);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color darkGrey = Color(0xFF757575);
  static const Color cardBorder = Color(0xFFEEEEEE);
}

class FuneralTabBody extends StatelessWidget {
  const FuneralTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> funeralHomes = [
      {
        'image': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8aG9zcGl0YWx8ZW58MHx8MHx8fDA%3D',
        'name': '펫브릿지',
        'distance': '4.7km',
        'location': '경기 안산시 단원구 원시동',
        'hours': '매일 09:00 - 22:00',
      },
      // {
      //   'image': 'https://plus.unsplash.com/premium_photo-1682130157004-057c137d96d5?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      //   'name': '펫콤',
      //   'distance': '5km',
      //   'location': '경기 안산시 단원구 목내동',
      //   'hours': '매일 24시간',
      // },
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTopBanner(context),
          _buildSearchBar(context),
          _buildSectionTitle(context, '가까운 장례식장이에요'),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: funeralHomes.length,
            itemBuilder: (context, index) {
              final home = funeralHomes[index];
              return _buildFuneralHomeCard(
                context,
                imageUrl: home['image']!,
                name: home['name']!,
                distance: home['distance']!,
                location: home['location']!,
                hours: home['hours']!,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 1,
                thickness: 1,
                color: AppColors.cardBorder,
                // indent: 16, 
                // endIndent: 16,
              );
            },
          ),
          const SizedBox(height: 20), 
        ],
      ),
    );
  }

  // Builds the top banner section.
  Widget _buildTopBanner(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const NetworkImage('https://images.unsplash.com/photo-1602936811262-9132b5735b14?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'), // Placeholder image
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.45), BlendMode.darken),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '마음을 준비하는 시간',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '갑작스러운 이별을 대처할 수 있도록\n필요한 절차를 모두 알려드려요',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.main,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 1,
            ),
            child: const Text(
              '장례 가이드 보러가기 >',
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  // Builds the search bar section.
  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: '검색어를 입력해 주세요.',
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15),
          prefixIcon: const Icon(Icons.search, color: AppColors.main, size: 24),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: AppColors.main, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: AppColors.main, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: AppColors.main, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
          filled: true,
          fillColor: Colors.white,
        ),
        onSubmitted: (value) {
        },
      ),
    );
  }

  // Builds the section title.
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0, bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Builds a card for a single funeral home.
  Widget _buildFuneralHomeCard(
    BuildContext context, {
    required String imageUrl,
    required String name,
    required String distance,
    required String location,
    required String hours,
    // Map<String, String> funeralHomeData, // REMOVED
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FuneralHomeDetailScreen(), 
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 0), 
        padding: const EdgeInsets.all(16.0), 
        color: Colors.white, 
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 90,
                    height: 90,
                    color: AppColors.lightGrey,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.main),
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(Icons.business_outlined, color: AppColors.darkGrey, size: 40),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$distance $location',
                    style: const TextStyle(fontSize: 13, color: AppColors.darkGrey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hours,
                    style: const TextStyle(fontSize: 13, color: AppColors.darkGrey),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildActionButton(
                        context,
                        icon: Icons.call,
                        onPressed: () {
                          // print('Call $name');
                        },
                      ),
                      const SizedBox(width: 10),
                      _buildActionButton(
                        context,
                        icon: Icons.favorite_border,
                        onPressed: () {
                          // print('Favorite $name');
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, required VoidCallback onPressed}) {
    return GestureDetector( 
      onTap: onPressed,
      child: Container(
        width: 40, 
        height: 40, 
        decoration: BoxDecoration(
          color: AppColors.iconBlueBackground,
          borderRadius: BorderRadius.circular(20.0), 
        ),
        child: Icon(
          icon,
          size: 20,
          color: AppColors.main,
        ),
      ),
    );
  }
}