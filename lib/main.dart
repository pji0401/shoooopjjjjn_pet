  import 'package:flutter/material.dart'; // import 'app/cupertino_app.dart'; // import 'app/widget_app.dart';
import 'app/app.dart';
import 'core/utils/native_splash.dart';

void main() {
  launchNativeSplash();
  runApp(const App());
}