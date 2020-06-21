import 'package:flutter/material.dart';
import 'package:smartfarmer/src/styles/base.dart';
import 'package:smartfarmer/src/styles/buttons.dart';
import 'package:smartfarmer/src/styles/text.dart';
import 'package:smartfarmer/src/styles/colors.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final ButtonType buttonType;

  AppButton({@required this.buttonText, this.buttonType});

  @override
  Widget build(BuildContext context) {
    TextStyle fontStyle;
    Color buttonColor;

    switch (buttonType) {
      case ButtonType.black:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColors.black;
        break;
      case ButtonType.DarkBlue:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColors.darkblue;
        break;
      case ButtonType.DarkBlue:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColors.darkblue;
        break;
      case ButtonType.LightGray:
        fontStyle = TextStyles.buttonTextDark;
        buttonColor = AppColors.lightgray;
        break;
      case ButtonType.DarkGray:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColors.darkgray;
        break;
      default:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColors.darkblue;
        break;
    }

    return Padding(
      padding: BaseStyles.listPadding,
      child: Container(
        height: ButtonStyles.buttonHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
            boxShadow: BaseStyles.boxShadow),
        child: Center(
            child: Text(
          buttonText,
          style: fontStyle,
        )),
      ),
    );
  }
}

enum ButtonType { LightBlue, black, LightGray, DarkGray, DarkBlue }
