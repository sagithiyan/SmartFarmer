import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartfarmer/src/screens/customer.dart';
import 'package:smartfarmer/src/screens/edit_product.dart';
import 'package:smartfarmer/src/screens/landing.dart';
import 'package:smartfarmer/src/screens/login.dart';
import 'package:smartfarmer/src/screens/signup.dart';
import 'package:smartfarmer/src/screens/vendor.dart';

abstract class Routes {
  static MaterialPageRoute materialRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/landing":
        return MaterialPageRoute(builder: (context) => Landing());
      case "/signup":
        return MaterialPageRoute(builder: (context) => Signup());
      case "/login":
        return MaterialPageRoute(builder: (context) => Login());
      case "/vendor":
        return MaterialPageRoute(builder: (context) => Vendor());
      case "/editproduct":
        return MaterialPageRoute(builder: (context) => EditProduct());
      default:
        var routeArray = settings.name.split('/');
        if (settings.name.contains('/editproduct/')) {
          return MaterialPageRoute(
              builder: (context) => EditProduct(
                    productId: routeArray[2],
                  ));
        } else if (settings.name.contains('/customer/')) {
          return MaterialPageRoute(
              builder: (context) => Customer(
                    marketId: routeArray[2],
                  ));
        }

        return MaterialPageRoute(builder: (context) => Login());
    }
  }

  static CupertinoPageRoute cupertinoRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/landing":
        return CupertinoPageRoute(builder: (context) => Landing());
      case "/signup":
        return CupertinoPageRoute(builder: (context) => Signup());
      case "/login":
        return CupertinoPageRoute(builder: (context) => Login());
      case "/vendor":
        return CupertinoPageRoute(builder: (context) => Vendor());
      case "/editproduct":
        return CupertinoPageRoute(builder: (context) => EditProduct());
      default:
        var routeArray = settings.name.split('/');
        if (settings.name.contains('/editproduct/')) {
          return CupertinoPageRoute(
              builder: (context) => EditProduct(
                    productId: routeArray[2],
                  ));
        } else if (settings.name.contains('/customer/')) {
          return CupertinoPageRoute(
              builder: (context) => Customer(
                    marketId: routeArray[2],
                  ));
        }
        return CupertinoPageRoute(builder: (context) => Login());
    }
  }
}
