import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartfarmer/src/routes.dart';
import 'screens/login.dart';
import 'dart:io';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp();
  }
}

class PlatformApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoApp();
    } else {
      return MaterialApp(
        home: Login(),
        onGenerateRoute: Routes.cupertinoRoutes,
      );
    }
  }
}
