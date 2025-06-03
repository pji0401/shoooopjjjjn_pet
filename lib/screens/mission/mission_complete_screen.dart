import 'package:flutter/material.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/widgets/index.dart'; 
import 'package:pawprints/viewmodels/index.dart';
import 'package:pawprints/utils/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:pawprints/core/network/index.dart';

class MemoryItem {
  final String imageUrl;
  final String? title;
  final String? subtitle;

  const MemoryItem({required this.imageUrl, this.title, this.subtitle});
}

class MissionCompleteScreen extends StatefulWidget {
  final int memoryId;

  const MissionCompleteScreen({super.key, required this.memoryId});

  @override
  State<MissionCompleteScreen> createState() => _MissionCompleteScreenState();
}

class _MissionCompleteScreenState extends State<MissionCompleteScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MemoryProvider>(context, listen: false).getMemory(widget.memoryId);
      if (mounted) { 
        _showMissionCompletionModal;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryTextColor = AppColors.black;
    const Color highlightColor = AppColors.main;

    return BaseScaffold(
      leadingItem: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: primaryTextColor, size: 20),
        onPressed: () => context.go(RoutePath.root.value, extra: 0),
      ),
      body: SafeArea(
        child: Consumer<MemoryProvider>(
          builder: (context, provider, child) {
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const SizedBox(height: 8),
                        Consumer<HomeProvider>(
                            builder: (context, provider, child) {
                              return Text(
                                '${provider.title.data?.pname ?? ""}와 함께 쌓은',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: primaryTextColor,
                                  fontFamily: 'Pretendard',
                                ),
                              );
                            }
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
            );
          },
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
                    _buildOverlayIconButton(Icons.ios_share, Colors.white, () {
                      _showCommunityShareModal();
                    }),
                    const SizedBox(width: 8),
                    _buildOverlayIconButton(isFavorite ? Icons.favorite : Icons.favorite_border, isFavorite ? Colors.red : Colors.white, () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
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

  Widget _buildOverlayIconButton(IconData icon, Color iconColor, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 22),
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

  void _showMissionCompletionModal() {
    ModalSheet.showModalSheetView(
      context: context,
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
            context.pop(); // Close the modal
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

  void _showCommunityShareModal() {
    ModalSheet.showModalSheetView(
      context: context,
      height: 300,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
          child: Text(
            '커뮤니에 게시글 공유',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
              fontFamily: 'Pretendard',
            ),
          ),
        ),
        const SizedBox(height: 30),
        const Padding(
          padding: EdgeInsets.only(top: 4.0, bottom: 29.0),
          child: Text(
            '커뮤니티에 공유된 게시글은 커뮤니티 유저 모두가 볼 수 있습니다. 게시물을 공유하시겠습니까?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.black,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFFB0B0B0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '취소',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 20 / 17,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Consumer3<MissionProvider, MemoryProvider, CommunityProvider>(
                builder: (context, missionProvider, memoryProvider, communityProvider, child) {
                  return Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // share memory(completedMission) to community
                        communityProvider.createContent(
                            request: ContentCreateRequest(
                                memberId: SharedPreferencesHelper().memberId,
                                body: memoryProvider.memory.data?.body ?? ""
                            ),
                            imageFiles: (missionProvider.images) // FIXME: multipart 요청 시 networkImage 말고, 직접 첨부해야 함
                        ).then((_) {
                          if (communityProvider.contentId.uiState == UIState.COMPLETED) {
                            AppLogger.d("✅ createContent: ${communityProvider.contentId.data?.id}");
                            _showPostModal();
                          } else {
                            AppLogger.d("⚠️ data is null or wrong type");
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color(0xFF3A8DFF),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text(
                        '확인',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 20 / 17,
                        ),
                      ),
                    ),
                  );
                }
            )
          ],
        ),
      ],
    );
  }

  void _showPostModal() {
    ModalSheet.showModalSheetView(
      context: context,
      children: [
        const Text(
          '커뮤니티에 등록되었어요.',
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
          'assets/datas/post.png',
          width: 184,
          height: 170,
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox(
              width: 184,
              height: 170,
              child: Center(
                  child: Text('이미지 로드 실패', style: TextStyle(fontSize: 12))),
            );
          },
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            context.pop();
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