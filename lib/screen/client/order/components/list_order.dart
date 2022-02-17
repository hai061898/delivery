// ignore_for_file: use_key_in_widget_constructors, prefer_is_empty, prefer_const_constructors

import 'package:da/helper/helper.dart';
import 'package:da/models/response/order_client.dart';
import 'package:da/screen/client/order/client_order_detail.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListOrdersClient extends StatelessWidget {
  final List<OrdersClient> listOrders;

  const ListOrdersClient({required this.listOrders});

  @override
  Widget build(BuildContext context) {
    return (listOrders.length != 0)
        ? ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            itemCount: listOrders.length,
            itemBuilder: (context, i) => GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  routeCustom(
                      page:
                          ClientDetailsOrderPage(orderClient: listOrders[i]))),
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                padding: EdgeInsets.all(15.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustom(
                            text: 'ORDER # ${listOrders[i].id}',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorsCustom.primaryColor),
                        TextCustom(
                            text: listOrders[i].status!,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (listOrders[i].status == 'DELIVERED'
                                ? ColorsCustom.primaryColor
                                : ColorsCustom.secundaryColor)),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustom(
                            text: 'AMOUNT',
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                        TextCustom(
                            text: '\$ ${listOrders[i].amount}0', fontSize: 16)
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustom(
                            text: 'DATE',
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                        TextCustom(
                            text: DateCustom.getDateOrder(
                                listOrders[i].currentDate.toString()),
                            fontSize: 15)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : SvgPicture.asset('assets/empty-cart.svg');
  }
}
