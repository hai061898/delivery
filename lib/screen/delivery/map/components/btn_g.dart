// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/helper/helper.dart';
import 'package:da/models/response/order_response.dart';
import 'package:flutter/material.dart';

class BtnGoogleMap extends StatelessWidget {
  final OrdersResponse order;

  const BtnGoogleMap({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: -5)
      ]),
      child: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 25,
          child: InkWell(
              onTap: () async => await urlLauncherCustom.openMapLaunch(
                  order.latitude!, order.longitude!),
              child: Image.asset('Assets/google-map.png', height: 30))),
    );
  }
}
