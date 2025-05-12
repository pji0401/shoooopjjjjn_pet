import 'package:flutter/material.dart';
import 'app/app.dart';
import 'utils/native_splash.dart';
import 'push_notification/local_notification.dart';

void main() {
  launchNativeSplash();
  WidgetsFlutterBinding.ensureInitialized();
  initLocalNotification();
  runApp(const App());
}