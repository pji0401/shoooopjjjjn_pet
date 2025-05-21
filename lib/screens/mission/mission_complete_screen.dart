import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/widgets/index.dart'; 


class MemoryItem {
  final String imageUrl;
  final String? title;
  final String? subtitle;

  const MemoryItem({required this.imageUrl, this.title, this.subtitle});
}

class MissionCompleteScreen extends StatefulWidget {
  const MissionCompleteScreen({super.key});

  // Sample data
  static const String memoryTitle = '봄이와 함께 쌓은';
  static const String memoryCount = '33번째';
  static const String memorySuffix = '추억';

  static const MemoryItem mainMemory = MemoryItem(
    imageUrl: 'https://images.unsplash.com/photo-1543466835-00a7907e9de1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9nJTIwZmxvd2VyfGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60',
    title: '벚꽃 아래서',
    subtitle: '봄이와 함께 사진',
  );

  static const List<MemoryItem> otherMemories = [
    MemoryItem(imageUrl: 'https://images.unsplash.com/photo-1505628346881-b72b27e84530?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fGNhdCUyMGZsb3dlcnxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=400&q=60'),
    MemoryItem(imageUrl: 'https://images.unsplash.com/photo-1517423440428-a5a00ad493e8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8ZnVubnklMjBkb2d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=400&q=60'),
    MemoryItem(imageUrl: 'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHBldHxlbnwwfHx8fHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60'),
    MemoryItem(imageUrl: 'https://images.unsplash.com/photo-1598133894008-61f7fdb8cc3a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cGV0fGVufDB8fHx8fHww&auto=format&fit=crop&w=400&q=60'),
    MemoryItem(imageUrl: 'https://images.unsplash.com/photo-1552053831-71594a27632d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cGV0fGVufDB8fHx8fHww&auto=format&fit=crop&w=400&q=60'),
    MemoryItem(imageUrl: 'https://images.unsplash.com/photo-1560807707-8cc77767d783?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cGV0fGVufDB8fHx8fHww&auto=format&fit=crop&w=400&q=60'),
  ];

  @override
  State<MissionCompleteScreen> createState() => _MissionCompleteScreenState();
}

class _MissionCompleteScreenState extends State<MissionCompleteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) { 
        _showMissionCompletionModal(context);
      }
    });
  }

  void _showMissionCompletionModal(BuildContext buildContext) {
    ModalSheet.showModalSheetView(
      context: buildContext, 
      children: [
        const Text(
          '오늘의 미션을 완료했어요.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w800,
            height: 20 / 17,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 20),
        Image.asset(
          'assets/datas/welcome.png', 
          width: 184,
          height: 170,
          errorBuilder: (context, error, stackTrace) { 
            return const SizedBox(
              width: 184,
              height: 170,
              child: Center(child: Text('이미지 로드 실패', style: TextStyle(fontSize: 12))),
            );
          },
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            Navigator.of(buildContext).pop(); // Close the modal
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: const Color(0xFF3A8DFF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          
          ),
          child: const Text(
            '확인',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffffffff),
              fontSize: 17,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              height: 20 / 17,
              letterSpacing: 0,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryTextColor = AppColors.black;
    const Color highlightColor = AppColors.main;

    return BaseScaffold(
      leadingItem: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/chevron_left.svg',
          colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
          ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), 
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 8),
                    Text(
                      MissionCompleteScreen.memoryTitle,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: primaryTextColor,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: primaryTextColor,
                          fontFamily: 'Pretendard',
                        ),
                        children: [
                          TextSpan(
                            text: MissionCompleteScreen.memoryCount,
                            style: const TextStyle(color: highlightColor, fontSize: 22, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),
                          ),
                          TextSpan(
                            text: MissionCompleteScreen.memorySuffix,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildMainImageCard(context, MissionCompleteScreen.mainMemory),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return _buildGridImageItem(MissionCompleteScreen.otherMemories[index]);
                  },
                  childCount: MissionCompleteScreen.otherMemories.length,
                ),
              ),
            ),
             const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainImageCard(BuildContext context, MemoryItem memory) {
    return AspectRatio(
      aspectRatio: 1, 
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2), 
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                memory.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey));
                },
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.1), 
                        Colors.black.withValues(alpha: 0.6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.5, 0.7, 1.0], 
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (memory.title != null)
                      Text(
                        memory.title!,
                        style: const TextStyle(
                          color: Colors.white, 
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pretendard', 
                          shadows: [Shadow(blurRadius: 2, color: Colors.black38)], 
                        ),
                      ),
                    if (memory.subtitle != null)
                      Text(
                        memory.subtitle!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14, 
                          fontFamily: 'Pretendard',
                          shadows: [Shadow(blurRadius: 2, color: Colors.black38)], 
                        ),
                      ),
                  ],
                ),
              ),
              Positioned(
                bottom: 12,
                right: 12,
                child: Row( 
                  children: [
                    _buildOverlayIconButton(Icons.ios_share, () {
                      // logic
                    }),
                    const SizedBox(width: 8),
                    _buildOverlayIconButton(Icons.favorite_border, () {
                      // logic
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverlayIconButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration( 
          color: Colors.white.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 22), 
      ),
    );
  }

  Widget _buildGridImageItem(MemoryItem memory) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        memory.imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator(strokeWidth: 2.0)),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[200],
            child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
          );
        },
      ),
    );
  }
}