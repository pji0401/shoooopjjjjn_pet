import 'package:flutter/material.dart';
import 'package:pawprints/widgets/index.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/widgets/sections.dart';

class WritePostScreen extends StatefulWidget {
  const WritePostScreen({super.key});

  @override
  State<WritePostScreen> createState() => _WritePostScreenState();
}

class _WritePostScreenState extends State<WritePostScreen> {
  final TextEditingController _contentController = TextEditingController();

  final GlobalKey<ImageAttachingSectionState> _imageSectionKey =
  GlobalKey<ImageAttachingSectionState>();

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  Icon(
                    Icons.location_on,
                    color: Colors.blue, // 강조 색상
                    size: 28, // 아이콘 크기 증가
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
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  '업로드하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
