import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarmer/src/blocs/auth_bloc.dart';
import 'package:smartfarmer/src/blocs/customer_bloc.dart';
import 'package:smartfarmer/src/blocs/vendor_bloc.dart';
import 'package:smartfarmer/src/routes.dart';
import 'package:smartfarmer/src/screens/landing.dart';
import 'package:smartfarmer/src/services/firestore_service.dart';
import 'package:smartfarmer/src/styles/colors.dart';
import 'package:smartfarmer/src/styles/text.dart';
import 'blocs/product_bloc.dart';
import 'screens/login.dart';
import 'dart:io';

final authBloc = AuthBloc();
final productBloc = ProductBloc();
final customerBloc=CustomerBloc();
final vendorBloc=VendorBloc();
final firestoreService=FirestoreService();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(create: (context) => authBloc),
      Provider(create: (context) => productBloc),
      Provider(create: (context) => customerBloc),
      Provider(create: (context) => vendorBloc),
      FutureProvider(create: (context) => authBloc.isLoggedIn()),
      StreamProvider(create: (context) =>firestoreService.fetchUnitTypes())
    ], child: PlatformApp());
  }

  @override
  void dispose() {
    authBloc.dispose();
    productBloc.dispose();
    customerBloc.dispose();
    vendorBloc.dispose();
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
          theme: CupertinoThemeData(
              primaryColor: AppColors.black,
              scaffoldBackgroundColor: Colors.white,
              textTheme: CupertinoTextThemeData(
                tabLabelTextStyle: TextStyles.suggestion
              )
          ));
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
