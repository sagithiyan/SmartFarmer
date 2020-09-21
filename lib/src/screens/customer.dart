import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smartfarmer/src/blocs/auth_bloc.dart';
import 'package:smartfarmer/src/styles/tabbar.dart';
import 'package:smartfarmer/src/widgets/customer_scaffold.dart';
import 'dart:io';
import 'package:smartfarmer/src/widgets/navbar.dart';
import 'package:smartfarmer/src/widgets/orders.dart';
import 'package:smartfarmer/src/widgets/products_customer.dart';
import 'package:smartfarmer/src/widgets/products.dart';
import 'package:smartfarmer/src/widgets/profile.dart';
import 'package:smartfarmer/src/widgets/profile_cusomer.dart';
import 'package:smartfarmer/src/widgets/shopping_bag.dart';

class Customer extends StatefulWidget {
  final String marketId;

  Customer({@required this.marketId});

  @override
  _CustomerState createState() => _CustomerState();

  static TabBar get customerTabBar {
    return TabBar(
      unselectedLabelColor: TabBarStyles.unselectedLabelColor,
      labelColor: TabBarStyles.labelColor,
      indicatorColor: TabBarStyles.indicatorColor,
      tabs: <Widget>[
        Tab(icon: Icon(Icons.list)),
        Tab(icon: Icon(FontAwesomeIcons.shoppingBag)),
        Tab(icon: Icon(Icons.person)),
      ],
    );
  }
}

class _CustomerState extends State<Customer> {
  StreamSubscription _userSubscription;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var authBloc = Provider.of<AuthBloc>(context, listen: false);
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
                  title: 'Customer Sachin', context: context),
            ];
          },
          body: CustomerScaffold.cupertinoTabScaffold,
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
                        title: 'Customer  Sachin',
                        tabBar: Customer.customerTabBar)
                  ];
                },
                body: TabBarView(
                  children: <Widget>[
                    ProductsCustomer(),
                    ShoppingBag(),
                    ProfileCustomer(),
                  ],
                ))),
      );
    }
  }
}
