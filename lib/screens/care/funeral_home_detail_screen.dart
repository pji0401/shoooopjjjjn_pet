import 'package:flutter/material.dart';
import './funeral_details_tab_content.dart'; // Import new file
import './funeral_reviews_tab_content.dart'; // Import new file

// Define AppColors or import if you have a central theme file
class AppColors {
  static const Color main = Color(0xFF4A9BF6); // Example blue from image
  static const Color darkGrey = Color(0xFF757575);
  static const Color textBlack = Color(0xFF333333);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color cardBorder = Color(0xFFEEEEEE);
  static const Color semiTransparentBlack = Colors.black54;
}

class FuneralHomeDetailScreen extends StatefulWidget {
  const FuneralHomeDetailScreen({super.key});

  @override
  State<FuneralHomeDetailScreen> createState() =>
      _FuneralHomeDetailScreenState();
}

class _FuneralHomeDetailScreenState extends State<FuneralHomeDetailScreen>
    with SingleTickerProviderStateMixin {
  bool isFavorited = false;
  late TabController _tabController;

  final String _location = '경기 안산시 단원구 원시동';
  final String _hours = '매일 09:00 - 22:00';
  final List<Map<String, dynamic>> _servicePackages = [
    {
      'image': 'https://plus.unsplash.com/premium_photo-1723867426410-b889447ff4b0?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzN8fHBldCUyMHNlcnZpY2V8ZW58MHx8MHx8fDA%3D',
      'title': '기본 장례 패키지',
      'price': '200,000원',
      'description': '펫브릿지의 가장 기본적인 장례로, 화장만 진행하는 패키지입니다.',
      'items': ['장례지도사 상담', '염습', '단독 추모실', '개별 화장', '기본 유골함', '고급 보자기', '장례 증명서 제공']
    },
    {
      'image': 'https://plus.unsplash.com/premium_photo-1723867426410-b889447ff4b0?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzN8fHBldCUyMHNlcnZpY2V8ZW58MHx8MHx8fDA%3D',
      'title': '베이직 장례 패키지',
      'price': '460,000원',
      'description': '펫브릿지의 가장 기본적인 장례로, 화장만 진행하는 패키지입니다.',
      'items': ['장례지도사 상담', '염습', '단독 추모실', '개별 화장', '기본 유골함', '고급 보자기', '장례 증명서 제공']
    },
    {
      'image': 'https://plus.unsplash.com/premium_photo-1723867426410-b889447ff4b0?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzN8fHBldCUyMHNlcnZpY2V8ZW58MHx8MHx8fDA%3D',
      'title': '프리미엄 장례 패키지',
      'price': '800,000원',
      'description': '펫브릿지의 가장 기본적인 장례로, 화장만 진행하는 패키지입니다.',
      'items': ['장례지도사 상담', '염습', '단독 추모실', '개별 화장', '기본 유골함', '고급 보자기', '장례 증명서 제공']
    },
  ];

  final List<String> _photoGallery = [ // Add this list
    'https://images.unsplash.com/photo-1495464205000-94ffda5a0064?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHBsYWNlaG9sZGVyc3xlbnwwfHwwfHx8MA%3D%3D', 
    'https://plus.unsplash.com/premium_photo-1681554599686-d314d1bf684d?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGxhY2Vob2xkZXJzfGVufDB8fDB8fHww',
    'https://images.unsplash.com/photo-1585543253202-04d3d9f11961?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjN8fHBsYWNlaG9sZGVyc3xlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1559167822-7ba9c5e3f51c?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NjJ8fHBsYWNlaG9sZGVyc3xlbnwwfHwwfHx8MA%3D%3D',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: true,
            pinned: true, 
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              tooltip: 'Back',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1523217582562-09d0def993a6?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    fit: BoxFit.cover,
                  ),
                  Container( 
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.5),
                          Colors.black.withValues(alpha: 0.5),
                        ],
                        stops: const [0.4, 0.6, 1.0],
                      ),
                    ),
                  ),
                  Positioned( 
                    bottom: 20.0,
                    left: 16.0,
                    right: 16.0, 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '펫프릿지',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            shadows: <Shadow>[
                              Shadow(offset: Offset(0.0, 1.0), blurRadius: 3.0, color: Colors.black54),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.4), 
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: const Text(
                            '반려동물 장례',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned( 
                    bottom: 20.0, 
                    right: 16.0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorited = !isFavorited;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.4), 
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorited ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                labelColor: AppColors.main,
                unselectedLabelColor: AppColors.darkGrey,
                indicatorColor: AppColors.main,
                indicatorWeight: 2.5,
                tabs: const [
                  Tab(text: '상세정보'),
                  Tab(text: '리뷰'),
                ],
              ),
            ),
            pinned: true,
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                FuneralDetailsTabContent(
                  location: _location,
                  hours: _hours,
                  servicePackages: _servicePackages,
                  photoGallery: _photoGallery, 
                ),
                const FuneralReviewsTabContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

