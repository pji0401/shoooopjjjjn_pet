import 'package:flutter/material.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/widgets/index.dart'; 
import 'package:pawprints/viewmodels/index.dart';

class MemoryItem {
  final String imageUrl;
  final String? title;
  final String? subtitle;

  const MemoryItem({required this.imageUrl, this.title, this.subtitle});
}

class MissionCompleteScreen extends StatefulWidget {
  final int memoryId;
  final String pet = '봄이'; // FIXME: (nick)name

  const MissionCompleteScreen({Key? key, required this.memoryId}) : super(key: key);

  @override
  State<MissionCompleteScreen> createState() => _MissionCompleteScreenState();
}

class _MissionCompleteScreenState extends State<MissionCompleteScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MemoryProvider>(context, listen: false).getMemory(widget.memoryId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) { 
        _showMissionCompletionModal(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MemoryProvider>(context);

    const Color primaryTextColor = AppColors.black;
    const Color highlightColor = AppColors.main;

    return BaseScaffold(
      leadingItem: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: primaryTextColor, size: 20),
        onPressed: () => context.go(RoutePath.root.value),
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
                      '${widget.pet}와 함께 쌓은',
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
                            text: '${provider.memory.data?.count ?? ""}번째 ',
                            style: const TextStyle(color: highlightColor, fontSize: 22, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),
                          ),
                          TextSpan(
                            text: '추억',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildMainImageCard(context, MemoryItem(imageUrl: provider.memory.data?.images[0] ?? '', title: provider.memory.data?.body ?? '', subtitle: provider.memory.data?.date ?? '')),
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
                    return _buildGridImageItem(MemoryItem(imageUrl: provider.memory.data?.images[index] ?? ""));
                  },
                  childCount: (provider.memory.data?.images.length ?? 1) - 1,
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
}