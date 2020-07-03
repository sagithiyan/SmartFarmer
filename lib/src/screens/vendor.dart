import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartfarmer/src/styles/tabbar.dart';
import 'dart:io';
import 'package:smartfarmer/src/widgets/navbar.dart';
import 'package:smartfarmer/src/widgets/orders.dart';
import 'package:smartfarmer/src/widgets/products.dart';
import 'package:smartfarmer/src/widgets/profile.dart';
import 'package:smartfarmer/src/widgets/vendor_scaffold.dart';

class Vendor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
              return <Widget> [
                AppNavbar.cupertinoNavBar(title: 'Vendor - Sachin', context:context),
              ];
            },
            body: Center(child: Text('Placeholder'),)),
      );
    } else {
      return DefaultTabController(
        length: 3,
        child: Scaffold(
            body: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
                  return <Widget> [
                    AppNavbar.materialNavBar(title: 'Vendor - Sachin', tabBar: vendorTabBar)
                  ];
                },
                body: TabBarView(children: <Widget>[
                  Products(),
                  Orders(),
                  Profile(),
                ],)
            )
        ),
      );
    }
  }

  static TabBar get vendorTabBar {
    return TabBar(
      unselectedLabelColor: TabBarStyles.unselectedLabelColor ,
      labelColor: TabBarStyles.labelColor ,
      indicatorColor: TabBarStyles.indicatorColor ,
      tabs: <Widget>[
        Tab(icon: Icon(Icons.list)),
        Tab(icon: Icon(Icons.shopping_cart)),
        Tab(icon: Icon(Icons.person)),
      ],
    );
  }
}