import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawprints/widgets/index.dart';
import 'package:pawprints/config/index.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  final String title = '알림';

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<AppNotification> notifications = [
    AppNotification(
      type: '일정',
      title: '17일 11시 세온 동물병원 예약이 있어요.',
      memo: '작성 메모 ---',
      timeAgo: '1시간 전',
    ),
    AppNotification(
      type: '일정',
      title: '00일 00시 00병원 예약이 있어요.',
      memo: '작성 메모 ---',
      timeAgo: '1시간 전',
    ),
  ];

  void addNotification(AppNotification notification) {
    setState(() {
      notifications.insert(0, notification);
    });
  }

  void _handleNotificationTap(AppNotification notification) {
    switch (notification.type) {
      case '일정':
        context.push('/schedule');
        break;
      case '커뮤니티':
        context.push('/community');
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: widget.title,
      leadingItem: IconButton(
          icon: SvgPicture.asset('assets/icons/chevron_left.svg', width: 24, height: 24),
          onPressed: () {
            context.pop();
          }
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Color(0xFF3A8DFF),
                    unselectedLabelColor: Color(0xFFBDBDBD),
                    indicatorColor: Color(0xFF3A8DFF),
                    labelStyle: const TextStyle(
                        fontFamily: 'Pretendard', fontWeight: FontWeight.w500, fontSize: 16, height: 20/16, letterSpacing: -0.24),
                    unselectedLabelStyle: const TextStyle(
                        fontFamily: 'Pretendard', fontWeight: FontWeight.w400, fontSize: 16, height: 20/16, letterSpacing: -0.24),
                    tabs: const [
                      Tab(text: '일정'),
                      Tab(text: '커뮤니티'),
                    ],
                  ),
                ),
                const Divider(height: 1, thickness: 1, color: Color(0xFFF4F4F4)),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.separated(
                        itemCount: notifications.length,
                        separatorBuilder: (context, idx) => const Divider(height: 1, thickness: 1, color: Color(0xFFF4F4F4)),
                        itemBuilder: (context, idx) {
                          final n = notifications[idx];
                          return InkWell(
                            onTap: () => _handleNotificationTap(n),
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset('assets/datas/splash_image.png', width: 50, height: 50),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(n.type, style: const TextStyle(fontFamily: 'Pretendard', fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xFF626262), height: 20 / 12, letterSpacing: 0)),
                                            const Spacer(),
                                            Text(n.timeAgo, style: const TextStyle(fontFamily: 'Pretendard', fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF626262), height: 20 / 12, letterSpacing: 0)),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(n.title, style: const TextStyle(fontFamily: 'Pretendard', fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF070707), height: 20 / 16, letterSpacing: 0)),
                                        const SizedBox(height: 2),
                                        Text(n.memo, style: const TextStyle(fontFamily: 'Pretendard', fontWeight: FontWeight.w400, fontSize: 15, color: Color(0xFF626262), height: 20 / 15, letterSpacing: 0)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Container(color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppNotification {
  final String type;
  final String title;
  final String memo;
  final String timeAgo;
  AppNotification({
    required this.type,
    required this.title,
    required this.memo,
    required this.timeAgo,
  });
}