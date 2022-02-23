// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:da/helper/helper.dart';
import 'package:da/models/response/order_client.dart';
import 'package:da/services/url_api.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InfoCardClient extends StatelessWidget {
  final OrdersClient orderClient;

  const InfoCardClient(this.orderClient);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),
                blurRadius: 7,
                spreadRadius: 5)
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(
                            URLS.BASE_URL + orderClient.imageDelivery!))),
              ),
              SizedBox(width: 10.0),
              TextCustom(text: orderClient.delivery!),
              Spacer(),
              InkWell(
                onTap: () async => await urlLauncherCustom
                    .makePhoneCall('tel:${orderClient.deliveryPhone}'),
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200]),
                  child: Icon(Icons.phone, color: ColorsCustom.primaryColor),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
