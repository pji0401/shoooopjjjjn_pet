import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// local imports
import 'package:pawprints/widgets/index.dart';
import 'package:pawprints/screens/community/whole_tab.dart';
// import 'package:pawprints/screens/community/hot_tab.dart';
import 'package:pawprints/screens/community/qna_tab.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/viewmodels/index.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  final String title = '커뮤니티';

  @override
  CommunityScreenState createState() => CommunityScreenState();
}

class CommunityScreenState extends State<CommunityScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CommunityProvider>(context, listen: false).getContentList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 05.08 - TODO: 글로벌 색상과 연결 필요
    const primaryColor = Colors.blue;

    return Scaffold(
      appBar: buildCustomAppBar(
        title: '커뮤니티',
        trailingItems: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).appBarTheme.iconTheme?.color ??
                      Colors.black,
                  BlendMode.srcIn), // 아이콘 색상 적용
            ),
            onPressed: () {
              // 05.08 - TODO: 검색 기능 구현
              AppLogger.d('돋보기 아이콘 클릭');
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/my_off.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).appBarTheme.iconTheme?.color ??
                      Colors.black,
                  BlendMode.srcIn), // 아이콘 색상 적용
            ), // 또는 Icons.person_outline
            onPressed: () {
              context.push(RoutePath.community_profile.value);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: 83,
        ),
        child: LeftStackTabViewSection(tabConfigs: [
          TabConfig(label: '커뮤니티', content: WholeTabBody()),
          // TabConfig(label: '인기', content: HotTabBody()),
          TabConfig(label: 'QnA', content: QnaTabBody()),
        ]),
      ),
      floatingActionButton: CreatePostButton(
        onPressed: () {
          context.push(RoutePath.community_write.value);
        },
        backgroundColor: primaryColor,
      ),
    );
  }
}

class CreatePostButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final double elevation;
  final double bottomMargin;

  const CreatePostButton({
    super.key,
    this.onPressed,
    this.backgroundColor = Colors.blue,
    this.elevation = 4.0,
    this.bottomMargin = 74.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: bottomMargin), // 버튼을 위로 올리기 위한 패딩
        child: // FloatingActionButton을 SizedBox로 감싸서 크기 지정
            SizedBox(
          width: 56,
          height: 56,
          child: FloatingActionButton(
            onPressed: onPressed ??
                () {
                  AppLogger.d('글 작성하기 버튼 클릭');
                },
            backgroundColor: backgroundColor,
            elevation: elevation,
            shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(56.0)), // 크기에 맞춰 반경 조정
            ),
            child: SvgPicture.asset(
              'assets/icons/pen.svg',
              width: 48,
            ),
          ),
        ));
  }
}