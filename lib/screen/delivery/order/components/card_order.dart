// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:da/helper/helper.dart';
import 'package:da/models/response/order_response.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CardOrdersDelivery extends StatelessWidget {

  final OrdersResponse orderResponse;
  final VoidCallback? onPressed;

  const CardOrdersDelivery({required this.orderResponse, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10.0),
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: -5)
        ]
      ),
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(text: 'ORDER ID: ${orderResponse.orderId}'),
              Divider(),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextCustom(text: 'Date', fontSize: 16, color: ColorsCustom.secundaryColor),
                  TextCustom(text: DateCustom.getDateOrder(orderResponse.currentDate.toString()), fontSize: 16),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextCustom(text: 'Client', fontSize:16, color: ColorsCustom.secundaryColor),
                  TextCustom(text: orderResponse.cliente!, fontSize: 16),
                ],
              ),
              SizedBox(height: 10.0),
              TextCustom(text: 'Address shipping', fontSize: 16, color: ColorsCustom.secundaryColor),
              SizedBox(height: 5.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextCustom(text: orderResponse.reference!, fontSize: 16, maxLine: 2)
              ),
              SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}