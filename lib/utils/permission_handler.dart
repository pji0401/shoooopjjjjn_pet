import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:pawprints/push_notification/local_notification.dart';

class PermissionHandler {
  Future<void> requestPermissions() async {
    await requestNotificationPermission();
    await requestImagePermission();
    await initLocalNotification();
    await testLocalNotification();
  }

  Future<void> requestImagePermission() async {
    if (await Permission.camera.isDenied && await Permission.storage.isDenied) {
      await [Permission.camera, Permission.storage].request();
    }
  }
  Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  Future<void> initLocalNotification() async {
    await LocalNotificationService.instance.initialize();
    testLocalNotification();
  }

  Future<void> testLocalNotification() async {
    if (Platform.isIOS) {
      // LocalNotificationService.instance.showNotification(
      //   id: 0,
      //   title: '알림 기능',
      //   body: '알림 테스트',
      // );
      LocalNotificationService.instance.showScheduleNotification(
        id: 1,
        title: '예약 알림',
        body: '5초 뒤에 도착하는 예약 알림',
        seconds: 5,
      );
    }
  }
}