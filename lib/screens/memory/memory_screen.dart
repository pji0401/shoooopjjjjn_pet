import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawprints/utils/index.dart';
import 'package:pawprints/widgets/index.dart'; 
import 'package:pawprints/config/index.dart';
import 'package:pawprints/viewmodels/index.dart';
import 'package:pawprints/data/models/index.dart';

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
  void _onSearchPressed() {
    // Search Icon Pressed Logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('검색 기능은 준비 중입니다.')),
    );
  }

  void _onMemoryItemTap(MemoryListResponse item) {
    // Click on the Image Logic
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.body}을(를) 선택했습니다.')),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MemoryProvider>(context, listen: false).getMemoryList(
          SharedPreferencesHelper().memberId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: '추억 보관함',
      leadingItem: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/chevron_left.svg',
          colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
          ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      trailingItems: [
        IconButton(
           icon: SvgPicture.asset(
          'assets/icons/search.svg',
          colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
          ),
          onPressed: _onSearchPressed,
        ),
      ],
      body: SafeArea(
        child: Consumer<MemoryProvider>(builder: (context, provider, child) {
          final items = provider.memoryList.data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildMemoryCard(item);
            },
          );
        }),
      ),
    );
  }

  // Widget for memory card
  Widget _buildMemoryCard(MemoryListResponse item) {
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
                item.media,
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
                    item.body,
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