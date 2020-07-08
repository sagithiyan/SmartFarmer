import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:smartfarmer/src/styles/colors.dart';

class Products extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS){
      return CupertinoPageScaffold(
        child: pageBody(),
      );
    } else {
      return Scaffold(
        body: pageBody(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.black,
          child: Icon(Icons.add),
          onPressed: ()=>Navigator.of(context).pushNamed('/editproduct'),
        ),
      );
    }
  }

  Widget pageBody() {
    return Center(child: Text('Products'),);
  }
}