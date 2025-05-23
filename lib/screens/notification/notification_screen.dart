import 'package:flutter/material.dart';
import 'package:pawprints/widgets/index.dart';
import 'package:pawprints/config/index.dart';
import 'package:pawprints/data/models/index.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  final String title = '알림';

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late List<TabConfig> _notificationTabs;

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
    AppNotification(
      type: '커뮤니티',
      title: '새로운 댓글이 달렸습니다: 댕댕이 사료 추천해주세요!',
      memo: '내용 미리보기 또는 추가 정보',
      timeAgo: '2시간 전',
    ),
  ];

  void addNotification(AppNotification notification) {
    setState(() {
      notifications.insert(0, notification);
      _updateTabs();
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

  void _updateTabs() {
    final scheduleNotifications =
        notifications.where((n) => n.type == '일정').toList();
    final communityNotifications =
        notifications.where((n) => n.type == '커뮤니티').toList();

    _notificationTabs = [
      TabConfig(
        label: '일정',
        content: SchedulesTabBody(
          notifications: scheduleNotifications,
          onNotificationTap: _handleNotificationTap,
        ),
      ),
      TabConfig(
        label: '커뮤니티',
        content: CommunityTabBody(
          notifications: communityNotifications,
          onNotificationTap: _handleNotificationTap,
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _updateTabs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        title: widget.title,
        leadingItem: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: 83,
        ),
        child: LeftStackTabViewSection(tabConfigs: _notificationTabs),
      ),
    );
  }
}

class SchedulesTabBody extends StatelessWidget {
  final List<AppNotification> notifications;
  final Function(AppNotification) onNotificationTap;

  const SchedulesTabBody({
    super.key,
    required this.notifications,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return const Center(
        child: Text(
          '표시할 일정 알림이 없습니다.',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: notifications.length,
      separatorBuilder: (context, idx) =>
          const Divider(height: 1, thickness: 1, color: Color(0xFFF4F4F4)),
      itemBuilder: (context, idx) {
        final n = notifications[idx];
        return InkWell(
          onTap: () => onNotificationTap(n),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                    'assets/datas/splash_image.png', // TODO: 알림 유형에 맞는 아이콘으로 변경
                    width: 50,
                    height: 50),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(n.type,
                              style: const TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(0xFF626262),
                                  height: 20 / 12,
                                  letterSpacing: 0)),
                          const Spacer(),
                          Text(n.timeAgo,
                              style: const TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xFF626262),
                                  height: 20 / 12,
                                  letterSpacing: 0)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(n.title,
                          style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xFF070707),
                              height: 20 / 16,
                              letterSpacing: 0)),
                      const SizedBox(height: 2),
                      Text(n.memo,
                          style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Color(0xFF626262),
                              height: 20 / 15,
                              letterSpacing: 0)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CommunityTabBody extends StatelessWidget {
  final List<AppNotification> notifications;
  final Function(AppNotification) onNotificationTap;

  const CommunityTabBody({
    super.key,
    required this.notifications,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return const Center(
        child: Text(
          '표시할 커뮤니티 알림이 없습니다.',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    // 05.23 - TODO: UI 수정
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: notifications.length,
      separatorBuilder: (context, idx) =>
          const Divider(height: 1, thickness: 1, color: Color(0xFFF4F4F4)),
      itemBuilder: (context, idx) {
        final n = notifications[idx];
        return InkWell(
          onTap: () => onNotificationTap(n),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                    'assets/datas/splash_image.png', // TODO: 알림 유형에 맞는 아이콘으로 변경
                    width: 50,
                    height: 50),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(n.type,
                              style: const TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(0xFF626262),
                                  height: 20 / 12,
                                  letterSpacing: 0)),
                          const Spacer(),
                          Text(n.timeAgo,
                              style: const TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xFF626262),
                                  height: 20 / 12,
                                  letterSpacing: 0)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(n.title,
                          style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xFF070707),
                              height: 20 / 16,
                              letterSpacing: 0)),
                      const SizedBox(height: 2),
                      Text(n.memo,
                          style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Color(0xFF626262),
                              height: 20 / 15,
                              letterSpacing: 0)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
