import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    if (Platform.isIOS) {
      return AppSliverScaffold.cupertinoSliverScaffold(
        navTitle: 'UpComing',
        pageBody: Scaffold(body: pageBody(context)),
      );
    } else {
      return AppSliverScaffold.materialSliverScaffold(
          navTitle: 'UpComing', pageBody: pageBody(context));
    }
  }

  Widget pageBody(BuildContext context) {
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
          child: ListView(
            children: <Widget>[
              AppListTile(
                date: '08',
                month: 'july',
                title: 'Sachin Products',
                location: 'Hatton,Kotagala',
                acceptingorders: true,
              ),
              AppListTile(
                date: '09',
                month: 'july',
                title: 'JonSnow Products',
                location: 'Hatton,Kotagala',
                acceptingorders: true,
              ),
              AppListTile(
                date: '10',
                month: 'july',
                title: 'SachinSagi Products',
                location: 'Hatton,Kotagala',
              ),
              AppListTile(
                  date: '11',
                  month: 'july',
                  title: 'Sagithiyan Products',
                  location: 'Hatton,Kotagala'),
              AppListTile(
                  date: '12',
                  month: 'july',
                  title: 'Dark Products',
                  location: 'Hatton,Kotagala'),
            ],
          ),
          flex: 3,
        )
      ],
    );
  }
}
