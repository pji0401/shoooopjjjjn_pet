import 'package:flutter/material.dart';
import 'package:pawprints/widgets/index.dart'; 
import 'package:pawprints/config/index.dart';

// Data model
class MemoryArchiveItem {
  final String id;
  final String imageUrl;
  final String date;
  final String title;

  const MemoryArchiveItem({
    required this.id,
    required this.imageUrl,
    required this.date,
    required this.title,
  });
}

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({super.key});

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  // Sample data
  final List<MemoryArchiveItem> _memoryItems = [
    const MemoryArchiveItem(
      id: '1',
      imageUrl: 'https://images.unsplash.com/photo-1543466835-00a7907e9de1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9nJTIwZmxvd2VyfGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60',
      date: '25.03.28',
      title: '함께 즐긴 잔디밭 피크닉',
    ),
    const MemoryArchiveItem(
      id: '2',
      imageUrl: 'https://images.unsplash.com/photo-1505628346881-b72b27e84530?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fGNhdCUyMGZsb3dlcnxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=800&q=60',
      date: '25.04.15',
      title: '햇살 좋은 날 공원 산책',
    ),
    const MemoryArchiveItem(
      id: '3',
      imageUrl: 'https://images.unsplash.com/photo-1517423440428-a5a00ad493e8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8ZnVubnklMjBkb2d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60',
      date: '25.05.01',
      title: '첫 수영 도전 계곡 물놀이',
    ),
    const MemoryArchiveItem(
      id: '3',
      imageUrl: 'https://images.unsplash.com/photo-1517423440428-a5a00ad493e8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8ZnVubnklMjBkb2d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60',
      date: '25.05.01',
      title: '첫 수영 도전 계곡 물놀이',
    ),
  ];

  void _onSearchPressed() {
    // Search Icon Pressed Logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('검색 기능은 준비 중입니다.')),
    );
  }

  void _onMemoryItemTap(MemoryArchiveItem item) {
    // Click on the Image Logic
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.title}을(를) 선택했습니다.')),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: '추억 보관함',
      leadingItem: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.black, size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
      trailingItems: [
        IconButton(
          icon: const Icon(Icons.search, color: AppColors.black, size: 24),
          onPressed: _onSearchPressed,
        ),
      ],
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _memoryItems.length,
          itemBuilder: (context, index) {
            final item = _memoryItems[index];
            return _buildMemoryCard(item);
          },
        ),
      ),
    );
  }

  // Widget for memory card
  Widget _buildMemoryCard(MemoryArchiveItem item) {
    return GestureDetector(
      onTap: () => _onMemoryItemTap(item),
      child: Card(
        clipBehavior: Clip.antiAlias, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 3,
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 10, 
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Center(child: Icon(Icons.broken_image, color: Colors.grey, size: 50)),
                  );
                },
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.black.withValues(alpha: 0.1), AppColors.black.withValues(alpha: 0.6)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.2, 1.0],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 20,
              right: 20, 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.grey.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      item.date,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16, 
                        fontWeight: FontWeight.w500, 
                        fontFamily: 'Pretendard',
                      ),
                    ),
                  ),
                  const SizedBox(height: 6), 
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26, 
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                      shadows: [Shadow(blurRadius: 4, color: Colors.black38)],
                    ),
                    maxLines: 2, // title to wrap
                    overflow: TextOverflow.ellipsis, 
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}