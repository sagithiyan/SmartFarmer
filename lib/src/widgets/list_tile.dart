import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartfarmer/src/styles/base.dart';
import 'package:smartfarmer/src/styles/colors.dart';
import 'package:smartfarmer/src/styles/text.dart';

//after getting data from firebase convert this into stateful
class AppListTile extends StatelessWidget {
  final String month;
  final String date;
  final String title;
  final String location;
  final bool acceptingorders;
  final String marketId;

  AppListTile(
      {@required this.month,
      @required this.date,
      @required this.title,
      @required this.location,
      @required this.marketId,
      this.acceptingorders = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: AppColors.darkblue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  month,
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
                Text(
                  date,
                  style: TextStyles.buttonTextLight,
                )
              ],
            ),
          ),
          title: Text(
            title,
            style: TextStyles.subtitle,
          ),
          subtitle: Text(location),
          trailing: (acceptingorders)
              ? Icon(
                  FontAwesomeIcons.shoppingBasket,
                  color: AppColors.darkblue,
                )
              : Text(''),

        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: BaseStyles.listFieldHorizontal),
          child: Divider(
            color: AppColors.lightgray,
          ),
        )
      ],
    );
  }
}
