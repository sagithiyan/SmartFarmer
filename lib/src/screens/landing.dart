import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarmer/src/app.dart';
import 'package:smartfarmer/src/blocs/customer_bloc.dart';
import 'package:smartfarmer/src/models/market.dart';
import 'package:smartfarmer/src/styles/base.dart';
import 'package:smartfarmer/src/styles/colors.dart';
import 'package:smartfarmer/src/styles/text.dart';
import 'dart:io';

import 'package:smartfarmer/src/widgets/button.dart';
import 'package:smartfarmer/src/widgets/list_tile.dart';
import 'package:smartfarmer/src/widgets/sliver_scaffold.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var customerBloc = Provider.of<CustomerBloc>(context);
    if (Platform.isIOS) {
      return AppSliverScaffold.cupertinoSliverScaffold(
        navTitle: 'UpComing',
        pageBody: Scaffold(body: pageBody(context, customerBloc)),
      );
    } else {
      return AppSliverScaffold.materialSliverScaffold(
          navTitle: 'UpComing', pageBody: pageBody(context, customerBloc));
    }
  }

  Widget pageBody(BuildContext context, CustomerBloc customerBloc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //splitting the screen into 40% 60%
        Flexible(
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Image.asset('assets/images/landing.jpg'),
                bottom: 2,
              ),
              Positioned(
                bottom: 20.0,
                left: 160.0,
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.darkblue,
                        borderRadius:
                            BorderRadius.circular(BaseStyles.borderRadius)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Farmer Page',
                        style: TextStyles.buttonTextLight,
                      ),
                    ),
                  ),
                  onTap: () => Navigator.of(context).pushNamed('/vendor'),
                ),
              )
            ],
          ),
          flex: 2,
        ),
        Flexible(
          child: StreamBuilder<List<Market>>(
              stream: customerBloc.fetchUpcomingMarkets,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: (Platform.isIOS)
                        ? CupertinoActivityIndicator()
                        : CircularProgressIndicator(),
                  );
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context,int index){
                    var market=snapshot.data[index];
                    var dateEnd=DateTime.parse(market.dateEnd);
                    return AppListTile(

                      month:formatDate(dateEnd,['M']) ,
                      date:formatDate(dateEnd,['d']) ,
                      title: market.title,
                      location: '${market.location.name},${market.location.address},${market.location.city},${market.location.state}',
                      acceptingorders: market.acceptingOrders,
                    );
                  },
                );
              }),
          flex: 3,
        )
      ],
    );
  }
}
