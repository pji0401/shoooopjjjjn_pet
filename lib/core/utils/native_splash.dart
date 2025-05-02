import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// 05.02 - NOTE: 임시로 util 안에 둠.
void launchNativeSplash() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
}