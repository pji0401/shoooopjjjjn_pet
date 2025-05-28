import 'app/app.dart';
import 'package:flutter/material.dart';
import 'utils/index.dart';

void main() async {
  launchNativeSplash();
  await PermissionHandler().requestPermissions();
  await SharedPreferencesHelper().init();
  runApp(const App());
}