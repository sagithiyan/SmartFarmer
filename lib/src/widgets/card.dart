import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartfarmer/src/styles/base.dart';
import 'package:smartfarmer/src/styles/colors.dart';
import 'package:smartfarmer/src/styles/text.dart';


class AppCard extends StatelessWidget {
  final String productName;
  final String unitType;
  final int availableUnits;
  final double price;
  final String note;

  final formatCurrency = NumberFormat.simpleCurrency(locale: "si_LK");

  AppCard({
    @required this.productName,
    @required this.unitType,
    @required this.availableUnits,
    @required this.price,
    this.note = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: BaseStyles.listPadding,
      padding: BaseStyles.listPadding,
      decoration: BoxDecoration(
          boxShadow: BaseStyles.boxShadow,
          color: Colors.white,
          border: Border.all(
            color: AppColors.darkblue,
            width: BaseStyles.borderWidth,
          ),
          borderRadius: BorderRadius.circular(BaseStyles.borderRadius)
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10.0, top: 10.0),
                child: Image.asset('assets/images/example_vege.jpg', height: 100.0,),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(productName,style: TextStyles.subtitle),
                  Text('${formatCurrency.format(price)}/$unitType', style: TextStyles.body),
                  (availableUnits > 0 )
                      ? Text('In Stock', style: TextStyles.bodyLightBlue)
                      : Text('Currently Unavailable',style: TextStyles.bodyRed)
                ],)
            ],
          ),
          Text(note, style: TextStyles.body)
        ],
      ),
    );
  }
}