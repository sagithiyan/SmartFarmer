import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smartfarmer/src/blocs/auth_bloc.dart';
import 'package:smartfarmer/src/styles/base.dart';
import 'package:smartfarmer/src/styles/text.dart';
import 'package:smartfarmer/src/styles/textfields.dart';
import 'package:smartfarmer/src/styles/colors.dart';
import 'package:smartfarmer/src/styles/buttons.dart';
import 'package:smartfarmer/src/widgets/alert.dart';
import 'package:smartfarmer/src/widgets/social_button.dart';
import 'package:smartfarmer/src/widgets/textfield.dart';
import 'package:smartfarmer/src/widgets/button.dart';

class Login extends StatefulWidget {
  StreamSubscription _userSubscription;
  StreamSubscription _errorMessageSubscription;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  StreamSubscription _userSubscription;
  StreamSubscription _errorMessageSubscription;

  @override
  void initState() {
    final authBloc = Provider.of<AuthBloc>(context, listen: false);
    _userSubscription = authBloc.user.listen((user) {
      if (user != null) Navigator.pushReplacementNamed(context, '/landing');
    });
    _errorMessageSubscription =
        authBloc.errorMessage.listen((errorMessage) {
      if (errorMessage != '') {
        AppAlerts.showErrorDialog(Platform.isIOS, context, errorMessage)
            .then((_) => authBloc.clearErrorMessage());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    _errorMessageSubscription.cancel();
    super.dispose();
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
//        ClipPath(
//          clipper: MyClipper(),
//          child: Container(
//            height:130,
//            decoration: BoxDecoration(
//              color: Colors.teal[900]
//            ),
//            child: Center(
//              child: Text("FARMERLY",style: TextStyle(
//                color: Colors.white,
//                fontWeight: FontWeight.bold,
//                fontStyle: FontStyle.italic,
//                fontSize:45
//              ),),
//            ),
//          ),
//        ),
//        Container(
//          height: MediaQuery.of(context).size.height * .2,
//          decoration: BoxDecoration(
//              image: DecorationImage(
//                  image: AssetImage('assets/images/images.jpg'),
//                  fit: BoxFit.fill)),
//        ),
        SizedBox(height: 50),
        Container(
          child: Center(
            child: Text(
              "Farmerly",
              style: GoogleFonts.pinyonScript(
                fontWeight: FontWeight.bold,
                fontSize: 99,
                color: Colors.black
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 180.0,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/i.png')),
          ),
        ),
        SizedBox(height: 10),
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
                buttonText: 'Login',
                buttonType: (snapshot.data == true)
                    ? ButtonType.DarkBlue
                    : ButtonType.Disabled,
                onPressed: authBloc.loginEmail,
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
                  text: 'Create an Account? ',
                  style: TextStyles.body,
                  children: [
                    TextSpan(
                        text: 'Signup',
                        style: TextStyles.link,
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => Navigator.pushNamed(context, '/signup'))
                  ])),
        )
      ],
    );
  }
}
//clippath used not comfortable with the UI
class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path=new Path();
    path.lineTo(0,size.height-80);
    var controlPoint=Offset(50,size.height);
    var endPoint=Offset(size.width/2, size.height);
    path.quadraticBezierTo(controlPoint.dx,controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
   return true;
  }

}
