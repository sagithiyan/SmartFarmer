import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartfarmer/src/styles/base.dart';
import 'package:smartfarmer/src/styles/buttons.dart';
import 'package:smartfarmer/src/styles/colors.dart';
import 'package:smartfarmer/src/styles/text.dart';
import 'dart:io';

class AppDropdownButton extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final IconData materialIcon;
  final IconData cupertinoIcon;

  AppDropdownButton(
      {@required this.items,
      @required this.hintText,
      this.materialIcon,
      this.cupertinoIcon});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Padding(
        padding: BaseStyles.listPadding,
        child: Container(
          height: ButtonStyles.buttonHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
              border: Border.all(
                  color: AppColors.black, width: BaseStyles.borderWidth)),
          child: Row(
            children: <Widget>[
              Container(
                  width: 35.0, child: BaseStyles.iconPrefix(materialIcon)),
              Expanded(
                child: Center(
                  child: DropdownButton<String>(
                    items: buildMaterialItems(items),
                    value: null,
                    hint: Text(hintText, style: TextStyles.suggestion),
                    style: TextStyles.picker,
                    underline: Container(),
                    iconEnabledColor: AppColors.black,
                    onChanged: (value) {},
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: BaseStyles.listPadding,
        child: Container(
          height: ButtonStyles.buttonHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
              border: Border.all(
                  color: AppColors.black, width: BaseStyles.borderWidth)),
          child: Row(
            children: <Widget>[
              Container(
                  width: 35.0, child: BaseStyles.iconPrefix(materialIcon)),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    child: Text(
                      hintText,
                      style: TextStyles.suggestion,
                    ),
                    onTap: () {
                      showCupertinoModalPopup(
                          context: context, builder: (BuildContext context) {
                            return _selectIOS(context, items);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  List<DropdownMenuItem<String>> buildMaterialItems(List<String> items) {
    return items
        .map((item) => DropdownMenuItem<String>(
              child: Text(
                item,
                textAlign: TextAlign.center,
              ),
              value: item,
            ))
        .toList();
  }

  List<Widget> buildCupertinoItems(List<String> items) {
    return items
        .map((item) => Text(
              item,
              textAlign: TextAlign.center,
              style: TextStyles.body,
            ))
        .toList();
  }

  _selectIOS(BuildContext context, List<String> items) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        color: Colors.white,
        height: 200.0,
        child: CupertinoPicker(
          itemExtent: 45.0,
          children: buildCupertinoItems(items),
          diameterRatio: 1.0,
          onSelectedItemChanged: (int Value) {},
        ),
      ),
    );
  }
}
