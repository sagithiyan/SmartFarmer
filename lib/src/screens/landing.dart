import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:smartfarmer/src/widgets/button.dart';

class Landing extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS){
      return CupertinoPageScaffold(
        child: pageBody(context),
      );
    } else {
      return Scaffold(body:pageBody(context));
    }
  }

  Widget pageBody(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppButton(
          buttonText: 'Vendor Page',
          buttonType: ButtonType.black,
          onPressed: () => Navigator.pushNamed(context, '/vendor'),
        )
      ],
    );
  }
}