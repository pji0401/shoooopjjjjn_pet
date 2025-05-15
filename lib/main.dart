import 'package:flutter/material.dart'; // import 'app/cupertino_app.dart'; // import 'app/widget_app.dart';
import 'app/app.dart';
import 'utils/native_splash.dart';
import 'push_notification/local_notification.dart';

void main() async {
  launchNativeSplash();
  WidgetsFlutterBinding.ensureInitialized();
  await requestNotificationPermission();
  await initLocalNotification();
  runApp(const App());
}