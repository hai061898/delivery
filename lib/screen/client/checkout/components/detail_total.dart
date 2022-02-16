// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:da/bloc/cart/cart_bloc.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cardBloc = BlocProvider.of<CartBloc>(context);

    return Container(
      padding: EdgeInsets.all(15.0),
      height: 190,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextCustom(text: 'Order Summary', fontWeight: FontWeight.w500),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextCustom(text: 'Subtotal', color: Colors.grey),
              TextCustom(
                  text: '\$ ${cardBloc.state.total}0', color: Colors.grey),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextCustom(text: 'IGV', color: Colors.grey),
              TextCustom(text: '\$ 2.5', color: Colors.grey),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextCustom(text: 'Shipping', color: Colors.grey),
              TextCustom(text: '\$ 0.00', color: Colors.grey),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextCustom(text: 'Total', fontWeight: FontWeight.w500),
              TextCustom(
                  text: '\$ ${cardBloc.state.total}0',
                  fontWeight: FontWeight.w500),
            ],
          ),
        ],
      ),
    );
  }
}
