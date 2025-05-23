import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawprints/widgets/index.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/widgets/sections.dart';
import 'package:pawprints/viewmodels/index.dart';
import 'package:pawprints/data/models/index.dart';
import 'package:pawprints/utils/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WritePostScreen extends StatefulWidget {
  const WritePostScreen({super.key});

  @override
  State<WritePostScreen> createState() => _WritePostScreenState();
}

class _WritePostScreenState extends State<WritePostScreen> {
  final TextEditingController _contentController = TextEditingController();

  final GlobalKey<ImageAttachingSectionState<CommunityProvider>> _imageSectionKey =
  GlobalKey<ImageAttachingSectionState<CommunityProvider>>();

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CommunityProvider>(context);
    return Scaffold(
      appBar: buildCustomAppBar(
        title: '게시글',
        leadingItem: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이미지 업로드 영역
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: ImageAttachingSection(
              key: _imageSectionKey, // GlobalKey 할당
            ),
          ),

          const SizedBox(height: 16.0),

          // 게시물 내용 작성 영역
          SizedBox(
            height: 220,
            child: TextField(
              controller: _contentController,
              decoration: InputDecoration(
                hintText: '게시물 내용을 입력하세요',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(12.0),
                filled: true,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ),
          getSectionDivider(),
          InkWell(
            onTap: () {
              // 위치 정보 수정 화면으로 이동
              AppLogger.d('위치 정보 수정 클릭');
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/location.svg',
                    width: 22,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '안산 호수공원',
                      style: TextStyle(
                        fontSize: 18, // 글자 크기 증가
                        fontWeight: FontWeight.w600, // 세미볼드로 변경
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                    size: 26, // 아이콘 크기 증가
                  ),
                ],
              ),
            ),
          ),

          Spacer(),

          // 업로드하기 버튼 영역
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomElevatedButton(
              text: '업로드하기',
              onPressed: () async {
                final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                if (!_contentController.text.isEmpty && !(provider.imageItemCount == 0)) {
                  provider.createContent(request: ContentCreateRequest(memberId: sharedPreferences.getInt('memberId') ?? 1, body: _contentController.text)).then((_) {
                    if (provider.contentId.uiState == UIState.COMPLETED) {
                      AppLogger.d("✅ createContent: ${provider.contentId.data?.id}");
                      _showPostModal();
                    } else {
                      AppLogger.d("⚠️ data is null or wrong type");
                    }
                  });
                }
              }, // 기존 버튼의 배경색 적용
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
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
              child: Center(child: Text('이미지 로드 실패', style: TextStyle(fontSize: 12))),
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
