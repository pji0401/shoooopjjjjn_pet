import 'package:flutter/material.dart';
// Assuming you might want to use an SVG for the call icon if you have one
// import 'package:flutter_svg/flutter_svg.dart';

class AppColors {
  static const Color main = Color(0xFF4A9BF6);
  static const Color darkGrey = Color(0xFF757575);
  static const Color textBlack = Color(0xFF333333);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color cardBorder = Color(0xFFEEEEEE);
  static const Color buttonBlue = Color(0xFF4A9BF6); // Color for the reserve button
}

class FuneralDetailsTabContent extends StatelessWidget {
  final String location;
  final String hours;
  final List<Map<String, dynamic>> servicePackages;
  final List<String> photoGallery;

  // Placeholder text for directions - consider making these parameters
  final String drivingInstructions =
      "티맵 : '신안산비즈스타 주차장' 검색하신 후 7층으로 올라오시면, 장례식장 바로 앞에 주차공간이 마련되어 있어 편리하게 주차하실 수 있습니다.\n\n카카오내비 : '펫브릿지' 또는 '신안산 비즈스타' 검색하신 후 골목으로 들어오면 좌측에 주차장 입구가 있습니다. 7층으로 올라오시면, 장례식장 바로 앞에 주차공간이 마련되어 있어 편리하게 주차하실 수 있습니다.";
  final String publicTransportInstructions = "시우역 3번 출구에서 737m";

  const FuneralDetailsTabContent({
    super.key,
    required this.location,
    required this.hours,
    required this.servicePackages,
    required this.photoGallery,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(label: "위치", value: location, showDropdown: true),
          const SizedBox(height: 12),
          _buildInfoRow(label: "시간", value: hours),
          const SizedBox(height: 24),
          _buildSectionTitle('장례 서비스'),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: servicePackages.length,
            itemBuilder: (context, index) {
              return _buildServicePackageCard(servicePackages[index]);
            },
            separatorBuilder: (context, index) => const Divider(height: 32, thickness: 0.5, color: AppColors.cardBorder),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('사진'),
          _buildPhotoGrid(context),
          const SizedBox(height: 24),
          _buildSectionTitle('오시는 길'),
          Center(
            child: Container(
              height: 180, 
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/datas/map.png', 
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.map_outlined, color: AppColors.darkGrey, size: 50, semanticLabel: 'Map image not found'),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row( 
            children: [
              Expanded(
                child: Text(
                  location,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textBlack),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: AppColors.darkGrey, size: 24),
            ],
          ),
          const SizedBox(height: 20),
          _buildDirectionDetailItem("자동차 이용 시", drivingInstructions),
          const SizedBox(height: 20),
          _buildDirectionDetailItem("대중교통 이용 시", publicTransportInstructions),
          const SizedBox(height: 30), 
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildDirectionDetailItem(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textBlack),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(fontSize: 14, color: AppColors.darkGrey, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {
          },
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(60, 50), 
            padding: const EdgeInsets.symmetric(horizontal: 12),
            side: BorderSide(color: AppColors.darkGrey.withValues(alpha: 0.5), width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Icon(Icons.phone_outlined, color: Color.fromARGB(255, 19, 122, 240), size: 26),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonBlue,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50), 
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            child: const Text('예약하기'),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoGrid(BuildContext context) {
    if (photoGallery.isEmpty) {
      return const SizedBox.shrink();
    }
    int gridItemCount = photoGallery.length >= 4 ? 4 : photoGallery.length;
    bool showMoreButton = photoGallery.length > 3;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: gridItemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        if (showMoreButton && index == gridItemCount - 1) {
          return GestureDetector(
            onTap: () {},
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    photoGallery[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Icon(Icons.broken_image, color: AppColors.darkGrey, size: 40),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                const Center(
                  child: Text(
                    '+ 더보기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            photoGallery[index],
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(8.0),
                ),
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
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(Icons.broken_image, color: AppColors.darkGrey, size: 40),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildInfoRow({required String label, required String value, bool showDropdown = false}) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(label, style: const TextStyle(fontSize: 15, color: AppColors.darkGrey, fontWeight: FontWeight.w500)),
        ),
        Expanded(
          child: Text(value, style: const TextStyle(fontSize: 15, color: AppColors.textBlack, fontWeight: FontWeight.w500)),
        ),
        if (showDropdown) const Icon(Icons.keyboard_arrow_down, color: AppColors.darkGrey, size: 20),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textBlack),
      ),
    );
  }

  Widget _buildServicePackageCard(Map<String, dynamic> package) {
    List<String> items = List<String>.from(package['items'] ?? []);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            package['image'] ?? 'assets/datas/pet_service.png',
            width: 80, height: 80, fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(width: 80, height: 80, color: AppColors.lightGrey, child: const Icon(Icons.image_not_supported, color: AppColors.darkGrey)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(package['title'] ?? '서비스명', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
              const SizedBox(height: 4),
              Text(package['price'] ?? '가격', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
              const SizedBox(height: 6),
              Text(package['description'] ?? '설명', style: const TextStyle(fontSize: 13, color: AppColors.darkGrey, height: 1.3)),
              if (items.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(items.join(' + '), style: const TextStyle(fontSize: 12, color: AppColors.darkGrey, height: 1.3)),
              ]
            ],
          ),
        ),
      ],
    );
  }
}