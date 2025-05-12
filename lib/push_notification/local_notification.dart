import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static final LocalNotificationService _localNotificationServiceInstance = LocalNotificationService();

  static LocalNotificationService get instance => _localNotificationServiceInstance;

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings iosSettings = DarwinInitializationSettings();

    final InitializationSettings settings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _localNotificationService.initialize(settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        onSelectNotification(response.payload);
      },
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
      showWhen: true,
      autoCancel: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    return const NotificationDetails(
      android: androidDetails, 
      iOS: iosDetails
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  Future<void> showScheduleNotification({
    required int id,
    required String title,
    required String body,
    required int seconds,
  }) async {
    final details = await _notificationDetails();

    await _localNotificationService.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      details,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'Scheduled Notification',
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  void onSelectNotification(String? payload) {
    debugPrint('Notification payload: $payload');
  }
}

void initLocalNotification() async {
  await LocalNotificationService.instance.initialize();
  testLocalNotification();
}

void testLocalNotification() async {
  LocalNotificationService.instance.showNotification(
    id: 1,
    title: '알림 기능 테스트',
    body: '이 알림 테스트 기능에는 이것을 구현하느라 밤에 잠을 자지 못한 불쌍한 앱 프론트엔드 개발자의 영혼이 깃들어 있습니다.',
  );
}

// 05.09 - NOTE: 호출 예시
// LocalNotificationService.instance.showNotification(
//   id: 0,
//   title: '즉시 알림',
//   body: '즉시 뜨는 알림',
// );
// LocalNotificationService.instance.showScheduleNotification(
//   id: 0,
//   title: '예약 알림',
//   body: '5초 뒤에 도착하는 알림',
//   seconds: 5,
// );