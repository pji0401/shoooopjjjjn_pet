import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawprints/core/network/index.dart';
import 'package:pawprints/widgets/index.dart';
import './store_tab.dart';
import './funeral_tab.dart';

class CareScreen extends StatefulWidget {
  const CareScreen({super.key});

  final String title = '케어';

  @override
  _CareScreenState createState() => _CareScreenState();
}

class _CareScreenState extends State<CareScreen> {
  final List<TabConfig> _careTabs = [
    TabConfig(label: '스토어', content: const StoreTabBody()),
    TabConfig(label: '굿즈', content: const GoodsTabBody()),
    TabConfig(label: '장례식', content: const FuneralTabBody()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        title: widget.title,
        trailingItems: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/favorite.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).appBarTheme.iconTheme?.color ??
                      Colors.black,
                  BlendMode.srcIn),
            ),
            onPressed: () {
              AppLogger.d('찜 아이콘 클릭');
              // TODO: 찜하기 기능 구현
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/cart.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).appBarTheme.iconTheme?.color ??
                      Colors.black,
                  BlendMode.srcIn),
            ),
            onPressed: () {
              AppLogger.d('장바구니 아이콘 클릭');
              // TODO: 장바구니 기능 구현
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: 83,
        ),
        child: LeftStackTabViewSection(tabConfigs: _careTabs),
      ),
    );
  }
}

class GoodsTabBody extends StatelessWidget {
  const GoodsTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('굿즈 탭 내용'),
    );
  }
}

