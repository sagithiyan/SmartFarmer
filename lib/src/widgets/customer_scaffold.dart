import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartfarmer/src/styles/colors.dart';
import 'package:smartfarmer/src/widgets/products_customer.dart';
import 'package:smartfarmer/src/widgets/profile_cusomer.dart';
import 'package:smartfarmer/src/widgets/shopping_bag.dart';

import 'orders.dart';

abstract class CustomerScaffold {
  static CupertinoTabScaffold get cupertinoTabScaffold {
    return CupertinoTabScaffold(
      tabBar: _cupertinoTabBar,
      tabBuilder: (context, index) {
        return _pageSelection(index);
      },
    );
  }

  static get _cupertinoTabBar {
    return CupertinoTabBar(
      backgroundColor: AppColors.darkblue,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.create), title: Text('Products')),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.shoppingBag), title: Text('Orders')),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person), title: Text('Profile')),
      ],
    );
  }

  static Widget _pageSelection(int index) {
    if (index == 0) {
      return ProductsCustomer();
    }

    if (index == 1) {
      return ShoppingBag();
    }

    return ProfileCustomer();
  }
}
