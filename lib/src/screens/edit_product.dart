import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smartfarmer/src/blocs/product_bloc.dart';
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
    var productBloc = Provider.of<ProductBloc>(context);

    if (Platform.isIOS) {
      return AppSliverScaffold.cupertinoSliverScaffold(
          navTitle: '', pageBody: pageBody(true,productBloc,context), context: context);
    } else {
      return AppSliverScaffold.materialSliverScaffold(
          navTitle: '', pageBody: pageBody(false,productBloc,context), context: context);
    }
  }

  Widget pageBody(bool isIOS, ProductBloc productBloc,BuildContext context) {
    var items=Provider.of<List<String>>(context);
    return ListView(
      children: <Widget>[
        Text(
          'Add Product',
          style: TextStyles.subtitle,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: BaseStyles.listPadding,
//  child: Divider(color: AppColors.darkblue),
        ),
        SizedBox(height: 20),
        StreamBuilder<String>(
            stream: productBloc.productName,
            builder: (context, snapshot) {
              return AppTextField(
                hintText: 'Product Name',
                cupertinoIcon: FontAwesomeIcons.shoppingBasket,
                materialIcon: FontAwesomeIcons.shoppingBasket,
                isIOS: isIOS,
                errorText: snapshot.error,
                onChanged: productBloc.changeProductName,
              );
            }
        ),
        StreamBuilder<String>(
          stream: productBloc.unitType,
          builder: (context, snapshot) {
            return AppDropdownButton(
              hintText: 'Unit Type',
              items: items,
              value:snapshot.data ,
              materialIcon: FontAwesomeIcons.balanceScale,
              cupertinoIcon: FontAwesomeIcons.balanceScale,
              onChanged: productBloc.changeUnitType,
            );
          }
        ),
        StreamBuilder<double>(
            stream: productBloc.unitPrice,
            builder: (context, snapshot) {
              return AppTextField(
                hintText: 'Unit Price',
                cupertinoIcon: FontAwesomeIcons.tag,
                materialIcon: FontAwesomeIcons.tag,
                isIOS: isIOS,
                textInputType: TextInputType.number,
                errorText: snapshot.error,
                onChanged: productBloc.changeUnitPrice,
              );
            }
        ),
        StreamBuilder<int>(
            stream: productBloc.availableUnits,
            builder: (context, snapshot) {
              return AppTextField(
                hintText: 'Available Units',
                cupertinoIcon: FontAwesomeIcons.cubes,
                materialIcon: FontAwesomeIcons.cubes,
                isIOS: isIOS,
                textInputType: TextInputType.number,
                errorText: snapshot.error,
                onChanged: productBloc.changeAvailableUnits,
              );
            }
        ),
        AppButton(buttonType: ButtonType.black, buttonText: 'Add Image'),
        StreamBuilder<bool>(
          stream: productBloc.isValid,
          builder: (context, snapshot) {
            return AppButton(
              buttonType:(snapshot.data==true) ? ButtonType.DarkBlue : ButtonType.Disabled,
              buttonText: 'Save Product',
            );
          }
        ),
      ],
    );
  }
}