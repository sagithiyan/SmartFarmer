import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:smartfarmer/src/blocs/auth_bloc.dart';
import 'package:smartfarmer/src/styles/base.dart';
import 'package:smartfarmer/src/styles/text.dart';
import 'package:smartfarmer/src/styles/textfields.dart';
import 'package:smartfarmer/src/styles/colors.dart';
import 'package:smartfarmer/src/styles/buttons.dart';
import 'package:smartfarmer/src/widgets/social_button.dart';
import 'package:smartfarmer/src/widgets/textfield.dart';
import 'package:smartfarmer/src/widgets/button.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  void initState() {
    final authBloc = Provider.of<AuthBloc>(context, listen: false);
    authBloc.user.listen((user) {
      if (user != null) Navigator.pushReplacementNamed(context, '/landing');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: pageBody(context, authBloc),
      );
    } else {
      return Scaffold(
        body: pageBody(context, authBloc),
      );
    }
  }

  Widget pageBody(BuildContext context, AuthBloc authBloc) {
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
          height: 180.0,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/fra.jpg')),
          ),
        ),
        StreamBuilder<String>(
            stream: authBloc.email,
            builder: (context, snapshot) {
              return AppTextField(
                isIOS: Platform.isIOS,
                hintText: 'Email',
                cupertinoIcon: CupertinoIcons.mail_solid,
                materialIcon: Icons.email,
                textInputType: TextInputType.emailAddress,
                errorText: snapshot.error,
                onChanged: authBloc.changeEmail,
              );
            }),
        StreamBuilder<String>(
            stream: authBloc.password,
            builder: (context, snapshot) {
              return AppTextField(
                isIOS: Platform.isIOS,
                hintText: 'Password',
                cupertinoIcon: IconData(0xf4c9,
                    fontFamily: CupertinoIcons.iconFont,
                    fontPackage: CupertinoIcons.iconFontPackage),
                materialIcon: Icons.lock,
                obscureText: true,
                errorText: snapshot.error,
                onChanged: authBloc.changePassword,
              );
            }),
        StreamBuilder<bool>(
            stream: authBloc.isValid,
            builder: (context, snapshot) {
              return AppButton(
                buttonText: 'Signup',
                buttonType: (snapshot.data == true)
                    ? ButtonType.DarkBlue
                    : ButtonType.Disabled,
                onPressed: authBloc.signupEmail,
              );
            }),
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
