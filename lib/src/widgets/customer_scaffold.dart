import 'package:flutter/cupertino.dart';
import 'package:smartfarmer/src/styles/colors.dart';
import 'package:smartfarmer/src/widgets/products.dart';
import 'package:smartfarmer/src/widgets/profile.dart';

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
            icon: Icon(CupertinoIcons.shopping_cart), title: Text('Orders')),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person), title: Text('Profile')),
      ],
    );
  }

  static Widget _pageSelection(int index) {
    if (index == 0) {
      return Products();
    }

    if (index == 1) {
      return Orders();
    }

    return Profile();
  }
}
