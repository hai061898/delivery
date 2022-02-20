// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_is_empty

import 'package:da/controllers/delivery_controller.dart';
import 'package:da/helper/helper.dart';
import 'package:da/models/response/order_response.dart';
import 'package:da/screen/delivery/order/components/card_order.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListOrdersDeliveryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextCustom(text: 'List of orders'),
        centerTitle: true,
        elevation: 0,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios_new_rounded,
                  size: 19, color: ColorsCustom.primaryColor),
              TextCustom(
                  text: 'Back', fontSize: 17, color: ColorsCustom.primaryColor)
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<OrdersResponse>?>(
          future: deliveryController.getOrdersForDelivery('DISPATCHED'),
          builder: (context, snapshot) => (!snapshot.hasData)
              ? Column(
                  children: [
                    ShimmerCustom(),
                    SizedBox(height: 10.0),
                    ShimmerCustom(),
                    SizedBox(height: 10.0),
                    ShimmerCustom(),
                  ],
                )
              : _ListOrdersForDelivery(listOrdersDelivery: snapshot.data!)),
    );
  }
}

class _ListOrdersForDelivery extends StatelessWidget {
  final List<OrdersResponse> listOrdersDelivery;

  const _ListOrdersForDelivery({required this.listOrdersDelivery});

  @override
  Widget build(BuildContext context) {
    return (listOrdersDelivery.length != 0)
        ? ListView.builder(
            itemCount: listOrdersDelivery.length,
            itemBuilder: (_, i) => CardOrdersDelivery(
                  orderResponse: listOrdersDelivery[i],
                  onPressed: () => Navigator.push(
                      context,
                      routeCustom(
                          page: OrdersDetailsDeliveryPage(
                              order: listOrdersDelivery[i]))),
                ))
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: SvgPicture.asset('assets/no-data.svg', height: 300)),
              SizedBox(height: 15.0),
              TextCustom(
                  text: 'Without Orders',
                  color: ColorsCustom.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 21)
            ],
          );
  }
}
