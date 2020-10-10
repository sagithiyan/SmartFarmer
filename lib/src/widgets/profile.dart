import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';
import 'package:smartfarmer/src/blocs/auth_bloc.dart';
import 'package:smartfarmer/src/blocs/vendor_bloc.dart';
import 'package:smartfarmer/src/models/vendor.dart';
import 'package:smartfarmer/src/styles/colors.dart';
import 'package:smartfarmer/src/widgets/button.dart';

class Profile extends StatelessWidget {
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
    var authBloc = Provider.of<AuthBloc>(context);
    var vendorBloc = Provider.of<VendorBloc>(context);

    return StreamBuilder<Vendor>(
        stream: vendorBloc.vendor,
        builder: (context, snapshot) {
          return Column(
            children: [
              Expanded(
                  child: (snapshot.data != null)
                      ? ListView(
                          children: [],
                        )
                      : Center(
                          child: AppButton(
                            buttonText: 'Create Vendor profile',
                            buttonType: ButtonType.LightBlue,
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/editvendor'),
                          ),
                        )),
              Container(
                  height: 50.0,
                  child: (Platform.isIOS)
                      ? CupertinoButton(
                          child: Text(
                            'Logout',
                            style: TextStyle(color: AppColors.lightblue),
                          ),
                          onPressed: () => authBloc.logout(),
                        )
                      : FlatButton(
                          child: Text(
                            'Logout',
                            style: TextStyle(color: AppColors.lightblue),
                          ),
                          onPressed: () => authBloc.logout(),
                        ))
            ],
          );
        });
  }
}
