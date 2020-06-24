import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:smartfarmer/src/styles/base.dart';
import 'package:smartfarmer/src/styles/text.dart';
import 'package:smartfarmer/src/styles/textfields.dart';
import 'package:smartfarmer/src/styles/colors.dart';
import 'package:smartfarmer/src/styles/buttons.dart';
import 'package:smartfarmer/src/widgets/social_button.dart';
import 'package:smartfarmer/src/widgets/textfield.dart';
import 'package:smartfarmer/src/widgets/button.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: pageBody(context),
      );
    } else {
      return Scaffold(
        body: pageBody(context),
      );
    }
  }

  Widget pageBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * .2,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/images.jpg'),
                  fit: BoxFit.fill)),
        ),
        Container(
          child: Center(
            child: Text(
              "FARMERLY",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ),
        Container(
          height: 200.0,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/fra.jpg')),
          ),
        ),
        AppTextField(
          isIOS: Platform.isIOS,
          hintText: 'Email',
          cupertinoIcon: CupertinoIcons.mail_solid,
          materialIcon: Icons.email,
          textInputType: TextInputType.emailAddress,
        ),
        AppTextField(
          isIOS: Platform.isIOS,
          hintText: 'Password',
          cupertinoIcon: IconData(0xf4c9,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage),
          materialIcon: Icons.lock,
          obscureText: true,
        ),
        AppButton(
          buttonText: 'Signup',
          buttonType: ButtonType.DarkBlue,
        ),
        Center(
          child: Text('Or', style: TextStyles.suggestion),
        ),
        Padding(
          padding: BaseStyles.listPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppSocialButton(
                socialType: SocialType.Facebook,
              ),
              AppSocialButton(socialType: SocialType.Google),
            ],
          ),
        ),
        Padding(
          padding: BaseStyles.listPadding,
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Already have an Account? ',
                  style: TextStyles.body,
                  children: [
                    TextSpan(
                        text: 'Login',
                        style: TextStyles.link,
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => Navigator.pushNamed(context, '/login'))
                  ])),
        )
      ],
    );
  }
}
