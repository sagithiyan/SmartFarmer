import 'package:flutter/material.dart';
import 'package:smartfarmer/src/routes.dart';

import 'screens/login.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      onGenerateRoute: Routes.materialRoutes,
    );
  }
}
