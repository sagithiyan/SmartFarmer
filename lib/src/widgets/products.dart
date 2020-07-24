import 'package:cupertino_toolbar/cupertino_toolbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarmer/src/app.dart';
import 'package:smartfarmer/src/blocs/auth_bloc.dart';
import 'package:smartfarmer/src/blocs/product_bloc.dart';
import 'package:smartfarmer/src/models/product.dart';
import 'dart:io';

import 'package:smartfarmer/src/styles/colors.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productBloc=Provider.of<ProductBloc>(context);
    var authBloc=Provider.of<AuthBloc>(context);

    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: CupertinoToolbar(
          items: <CupertinoToolbarItem>[
            CupertinoToolbarItem(
              icon: CupertinoIcons.add_circled_solid,
              onPressed: () => Navigator.of(context).pushNamed('/editproduct'),
            )
          ],
          body: pageBody(productBloc,context,authBloc.userId),
        ),
      );
    } else {
      return Scaffold(
        body: pageBody(productBloc,context,authBloc.userId  ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.black,
          child: Icon(Icons.add),
          onPressed: () => Navigator.of(context).pushNamed('/editproduct'),
        ),
      );
    }
  }

  Widget pageBody(ProductBloc productBloc,BuildContext context,String vendorId) {
    return StreamBuilder<List<Product>>(
      stream: productBloc.productByVendorId(vendorId),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return (Platform.isIOS)
            ?CupertinoActivityIndicator()
        :CircularProgressIndicator();
        return ListView.builder(
            itemCount:snapshot.data.length ,
            itemBuilder: (context,index){
                var product =snapshot.data[index];
                return Text(product.productName);
            });
      }
    );
  }
}
