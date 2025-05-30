import 'package:flutter/material.dart';

class StoreTabBody extends StatelessWidget {
  const StoreTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StoreBanner(
            backgroundImage: 'assets/images/store_banner.png',
            title: '포프린트에서 만나는 초특가 사료',
            description: '신상부터 HOT 인기 상품까지  ',
            circleImage: 'assets/images/store_banner_circle.png',
            currentPage: 1,
            totalPages: 10,
          ),
        ],
      ),
    );
  }
}

class StoreBanner extends StatelessWidget {
  final String backgroundImage;
  final String title;
  final String description;
  final String circleImage;
  final int currentPage;
  final int totalPages;

  const StoreBanner({
    super.key,
    required this.backgroundImage,
    required this.title,
    required this.description,
    required this.circleImage,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5 / 3,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double circleImageSize = constraints.maxHeight * 0.7;

          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {
                  print('Error loading background image: $exception');
                },
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              description,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      ClipOval(
                        child: Image.asset(
                          circleImage,
                          width: circleImageSize,
                          height: circleImageSize,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print('Error loading circle image: $error');
                            return Container(
                              width: circleImageSize,
                              height: circleImageSize,
                              color: Colors.grey,
                              child:
                                  const Icon(Icons.error, color: Colors.white),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$currentPage/$totalPages',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
