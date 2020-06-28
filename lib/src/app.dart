import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarmer/src/blocs/auth_bloc.dart';
import 'package:smartfarmer/src/routes.dart';
import 'package:smartfarmer/src/screens/landing.dart';
import 'screens/login.dart';
import 'dart:io';

final authBloc = AuthBloc();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(create: (context) => authBloc),
      FutureProvider(create: (context) => authBloc.isLoggedIn())
    ], child: PlatformApp());
  }

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }
}

class PlatformApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isLoggedIn = Provider.of<bool>(context);

    if (Platform.isIOS) {
      return CupertinoApp(
          home: (isLoggedIn == null)
              ? loadingScreen(true)
              : (isLoggedIn == true) ? Landing() : Login(),
          onGenerateRoute: Routes.cupertinoRoutes,
          theme: CupertinoThemeData(scaffoldBackgroundColor: Colors.white));
    } else {
      return MaterialApp(
          home: (isLoggedIn == null)
              ? loadingScreen(false)
              : (isLoggedIn == true) ? Landing() : Login(),
          onGenerateRoute: Routes.materialRoutes,
          theme: ThemeData(scaffoldBackgroundColor: Colors.white));
    }
  }

  Widget loadingScreen(bool isIOS) {
    return (isIOS)
        ? CupertinoPageScaffold(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
        : Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
