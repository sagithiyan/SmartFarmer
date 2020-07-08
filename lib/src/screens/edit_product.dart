import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartfarmer/src/styles/base.dart';
import 'package:smartfarmer/src/styles/colors.dart';
import 'package:smartfarmer/src/styles/text.dart';
import 'package:smartfarmer/src/widgets/button.dart';
import 'package:smartfarmer/src/widgets/dropdown_button.dart';
import 'dart:io';

import 'package:smartfarmer/src/widgets/sliver_scaffold.dart';
import 'package:smartfarmer/src/widgets/textfield.dart';

class EditProduct extends StatefulWidget {
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return AppSliverScaffold.cupertinoSliverScaffold(
          navTitle: '', pageBody: pageBody(true), context: context);
    } else {
      return AppSliverScaffold.materialSliverScaffold(
          navTitle: '', pageBody: pageBody(false), context: context);
    }
  }

  Widget pageBody(bool isIOS) {
    List<String> items = List<String>();
    items.add('Kilograms');
    items.add('Grams');
    items.add('Single');

    return ListView(
      children: <Widget>[
        Text(
          'Add Product',
          style: TextStyles.title,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: BaseStyles.listPadding,
          child: Divider(
            color: AppColors.black,
          ),
        ),
        AppTextField(
            hintText: 'Product Name',
            cupertinoIcon: FontAwesomeIcons.shoppingBag,
            materialIcon: FontAwesomeIcons.shoppingBag,
            isIOS: isIOS),
        AppDropdownButton(
          hintText: 'Unit Type',
          items: items,
          materialIcon: FontAwesomeIcons.balanceScale,
          cupertinoIcon: FontAwesomeIcons.balanceScale,
        ),
        AppTextField(
            hintText: 'Unit Price',
            cupertinoIcon: FontAwesomeIcons.tag,
            materialIcon: FontAwesomeIcons.tag,
            isIOS: isIOS),
        AppTextField(
            hintText: 'Available Units',
            cupertinoIcon: FontAwesomeIcons.hashtag,
            materialIcon: FontAwesomeIcons.hashtag,
            isIOS: isIOS),
        AppButton(
          buttonType: ButtonType.DarkBlue,
          buttonText: 'Add image',
        ),
        AppButton(
          buttonType: ButtonType.black,
          buttonText: 'Save Product',
        )
      ],
    );
  }
}
