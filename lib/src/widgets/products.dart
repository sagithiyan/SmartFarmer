
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarmer/src/app.dart';
import 'package:smartfarmer/src/blocs/auth_bloc.dart';
import 'package:smartfarmer/src/blocs/product_bloc.dart';
import 'package:smartfarmer/src/models/product.dart';
import 'dart:io';

import 'package:smartfarmer/src/styles/colors.dart';
import 'package:smartfarmer/src/widgets/card.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productBloc = Provider.of<ProductBloc>(context);
    var authBloc = Provider.of<AuthBloc>(context);

    return pageBody(productBloc, context, authBloc.userId);
  }

  Widget pageBody(
      ProductBloc productBloc, BuildContext context, String vendorId) {
    return StreamBuilder<List<Product>>(
        stream: productBloc.productByVendorId(vendorId),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return (Platform.isIOS)
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator();

          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var product = snapshot.data[index];
                      return GestureDetector(
                        child: AppCard(
                          availableUnits: product.availableUnits,
                          price: product.unitPrice,
                          productName: product.productName,
                          unitType: product.unitType,
                        ),
                        onTap: () => Navigator.of(context)
                            .pushNamed('/editproduct/${product.productId}'),
                      );
                    }),
              ),
              GestureDetector(
                child: Container(
                  height: 45.0,
                  width: double.infinity,
                  color: AppColors.black,
                  child: (Platform.isIOS)
                      ? Icon(CupertinoIcons.add,
                      color: Colors.white, size: 35.0)
                      : Icon(Icons.add, color: Colors.white, size: 35.0),
                ),
                onTap: () => Navigator.of(context).pushNamed('/editproduct'),
              )
            ],
          );
        });
  }
}