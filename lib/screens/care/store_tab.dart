import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4A9BF6);
  static const Color secondaryText = Color(0xFF757575);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color darkGrey = Color(0xFF333333); 
  static const Color accentRed = Color(0xFFE53935); 
  static const Color iconBlueBackground = Color(0xFFEBF4FF); 
  static const Color chipBackground = Color(0xFFE0E0E0);
  static const Color chipSelectedBackground = Color(0xFF4A9BF6);
  static const Color chipSelectedText = Colors.white;
  static const Color chipText = Color(0xFF333333);
}

class StoreTabBody extends StatefulWidget {
  const StoreTabBody({super.key});

  @override
  State<StoreTabBody> createState() => _StoreTabBodyState();
}

class _StoreTabBodyState extends State<StoreTabBody> {
  String _selectedCategory = '전체'; // To keep track of selected filter

  // Placeholder data for products - Using local asset paths
  final List<Map<String, dynamic>> _popularProducts = [
    {
      'id': '1',
      'name': '프라마 프르메스 치킨 트릿',
      'originalPrice': '19,900원',
      'discountedPrice': '15,900원',
      'discountPercentage': '20%',
      'rating': 4.8,
      'reviews': 115,
      'imageUrl': 'assets/datas/pet_product1.png', // Local asset path
      'number': '1',
    },
    {
      'id': '2',
      'name': '하이프로 치킨앤덴 프리미엄 사료',
      'originalPrice': null, // No discount
      'discountedPrice': '12,960원',
      'rating': 4.8,
      'reviews': 115,
      'imageUrl': 'assets/datas/pet_product2.png', // Local asset path
      'number': '2',
    },
    {
      'id': '3',
      'name': 'FRESH KISSES 치석케어 덴탈껌',
      'originalPrice': '15,000원',
      'discountedPrice': '12,500원',
      'discountPercentage': '17%',
      'rating': 4.9,
      'reviews': 203,
      'imageUrl': 'assets/datas/pet_product1.png', // Local asset path
      'number': '3',
    },
    {
      'id': '4',
      'name': '강아지 습식사료 100g x 12개',
      'originalPrice': '22,000원',
      'discountedPrice': '18,900원',
      'discountPercentage': '14%',
      'rating': 4.7,
      'reviews': 98,
      'imageUrl': 'assets/datas/pet_product2.png', // Local asset path
      'number': '4',
    },
  ];

  final List<String> _categories = ['전체', '간식', '영양제', '미용용품', '장난감'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const StoreBanner(
            backgroundImage: 'assets/images/store_banner.png', 
            title: '포프린트에서 만나는\n초특가 사료',
            description: '신상부터 HOT 인기 상품까지',
            circleImage: 'assets/images/store_banner_circle.png',
            currentPage: 1,
            totalPages: 10,
          ),
          _buildStoreSearchBar(),
          _buildSectionHeader("실시간 인기 상품", () {
            // print("View All Popular Tapped");
          }),
          _buildCategoryFilters(),
          _buildProductGrid(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStoreSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: '상품을 검색해 보세요!',
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15),
          prefixIcon: const Icon(Icons.search, color: AppColors.primary, size: 24),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: AppColors.primary, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
          filled: true,
          fillColor: Colors.white,
        ),
        onSubmitted: (value) {
          // print('Search submitted: $value');
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onViewAll) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGrey,
            ),
          ),
          TextButton(
            onPressed: onViewAll,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "전체보기",
                  style: TextStyle(fontSize: 13, color: AppColors.secondaryText),
                ),
                Icon(Icons.chevron_right, color: AppColors.secondaryText, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;
          return ChoiceChip(
            label: Text(category),
            selected: isSelected,
            showCheckmark: false,
            onSelected: (selected) {
              if (selected) {
                setState(() {
                  _selectedCategory = category;
                });
                // print('Selected category: $category');
              }
            },
            backgroundColor: Colors.white,
            selectedColor: AppColors.chipSelectedBackground,
            labelStyle: TextStyle(
              color: isSelected ? AppColors.chipSelectedText : AppColors.chipText,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(
                color: Colors.white,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8),
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 0.60, 
      ),
      itemCount: _popularProducts.length,
      itemBuilder: (context, index) {
        final product = _popularProducts[index];
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1, 
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    product['imageUrl'], 
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // print('Error loading product asset: ${product['imageUrl']} $error');
                      return Container(color: AppColors.lightGrey, child: const Icon(Icons.broken_image_outlined, color: AppColors.secondaryText));
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      product['number'],
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1, // Changed from 4 to 1 (or remove flex for default 1)
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product['name'],
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.darkGrey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (product['originalPrice'] != null)
                        Text(
                          product['originalPrice'],
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.secondaryText,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Row(
                        children: [
                           if (product['discountPercentage'] != null)
                            Text(
                              "${product['discountPercentage']} ",
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.accentRed),
                            ),
                          Text(
                            product['discountedPrice'],
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.darkGrey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 2),
                          Text(
                            '${product['rating']} (${product['reviews']})',
                            style: const TextStyle(fontSize: 11, color: AppColors.secondaryText),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildSmallActionButton(Icons.shopping_cart_outlined, () {
                        // print('Add to cart: ${product['name']}');
                      }),
                      const SizedBox(width: 6),
                      _buildSmallActionButton(Icons.favorite_border, () {
                        // print('Favorite: ${product['name']}');
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

   Widget _buildSmallActionButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: const BoxDecoration(
          color: AppColors.iconBlueBackground,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: 18,
        ),
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
      aspectRatio: 16 / 9,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double circleImageSize = constraints.maxHeight * 0.55;
          final double horizontalPadding = constraints.maxWidth * 0.05;
          final double verticalPadding = constraints.maxHeight * 0.1;

          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage), // Uses AssetImage
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {
                  // print('Error loading background image: $backgroundImage - $exception');
                },
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2,
                                shadows: [
                                  Shadow(offset: Offset(1,1), blurRadius: 2, color: Colors.black54)
                                ]
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              description,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                height: 1.3,
                                shadows: [
                                  Shadow(offset: Offset(1,1), blurRadius: 2, color: Colors.black54)
                                ]
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ClipOval(
                            child: Image.asset( // Uses AssetImage
                              circleImage,
                              width: circleImageSize,
                              height: circleImageSize,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                // print('Error loading circle image: $circleImage - $error');
                                return Container(
                                  width: circleImageSize,
                                  height: circleImageSize,
                                  color: Colors.grey.withValues(alpha: 0.5),
                                  child: const Icon(Icons.pets, color: Colors.white70, size: 40),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: horizontalPadding,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$currentPage/$totalPages',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
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
