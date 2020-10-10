import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarmer/src/app.dart';
import 'package:smartfarmer/src/blocs/auth_bloc.dart';
import 'package:smartfarmer/src/blocs/vendor_bloc.dart';
import 'package:smartfarmer/src/styles/tabbar.dart';
import 'dart:io';
import 'package:smartfarmer/src/widgets/navbar.dart';
import 'package:smartfarmer/src/widgets/orders.dart';
import 'package:smartfarmer/src/widgets/products.dart';
import 'package:smartfarmer/src/widgets/profile.dart';
import 'package:smartfarmer/src/widgets/vendor_scaffold.dart';

class Vendor extends StatefulWidget {
  @override
  _VendorState createState() => _VendorState();

  static TabBar get vendorTabBar {
    return TabBar(
      unselectedLabelColor: TabBarStyles.unselectedLabelColor,
      labelColor: TabBarStyles.labelColor,
      indicatorColor: TabBarStyles.indicatorColor,
      tabs: <Widget>[
        Tab(icon: Icon(Icons.list)),
        Tab(icon: Icon(Icons.shopping_cart)),
        Tab(icon: Icon(Icons.person)),
      ],
    );
  }
}

class _VendorState extends State<Vendor> {
  StreamSubscription _userSubscription;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final authBloc = Provider.of<AuthBloc>(context, listen: false);
      final vendorBloc = Provider.of<VendorBloc>(context, listen: false);
      vendorBloc
          .fetchVendor(authBloc.userId)
          .then((vendor) => vendorBloc.changeVendor(vendor));
      _userSubscription = authBloc.user.listen((user) {
        if (user == null)
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', (route) => false);
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              AppNavbar.cupertinoNavBar(
                  title: 'Vendor Sachin', context: context),
            ];
          },
          body: VendorScaffold.cupertinoTabScaffold,
        ),
      );
    } else {
      return DefaultTabController(
        length: 3,
        child: Scaffold(
            body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    AppNavbar.materialNavBar(
                        title: 'Vendor Sachin', tabBar: Vendor.vendorTabBar)
                  ];
                },
                body: TabBarView(
                  children: <Widget>[
                    Products(),
                    Orders(),
                    Profile(),
                  ],
                ))),
      );
    }
  }
}
