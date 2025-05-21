import 'app/app.dart';
import 'package:flutter/material.dart';
import 'utils/index.dart';
import 'push_notification/local_notification.dart';

void main() async {
  launchNativeSplash();
  WidgetsFlutterBinding.ensureInitialized();
  await requestNotificationPermission();
  await initLocalNotification();
  runApp(const App());
}