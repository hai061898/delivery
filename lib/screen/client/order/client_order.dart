// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/controllers/order_controller.dart';
import 'package:da/models/response/order_client.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'components/list_order.dart';

class ClientOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextCustom(text: 'My Orders', fontSize: 20),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios_new_rounded,
                  color: ColorsCustom.primaryColor, size: 17),
              TextCustom(
                  text: 'Back', fontSize: 17, color: ColorsCustom.primaryColor)
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<OrdersClient>?>(
          future: ordersController.getListOrdersForClient(),
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
              : ListOrdersClient(listOrders: snapshot.data!)),
    );
  }
}
