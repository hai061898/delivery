import 'package:da/models/response/order_response.dart';
import 'package:flutter/material.dart';

import 'card_order.dart';

class ListOrders extends StatelessWidget {
  
  final List<OrdersResponse> listOrders;

  const ListOrders({required this.listOrders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOrders.length,
      itemBuilder: (context, i) 
        => CardOrders(orderResponse: listOrders[i]),
    );
  }
}