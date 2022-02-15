// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/models/response/order_detail.dart';
import 'package:da/services/url_api.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ListProductsDetails extends StatelessWidget {
  final List<DetailsOrder> listProductDetails;

  const ListProductsDetails({required this.listProductDetails});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      itemCount: listProductDetails.length,
      separatorBuilder: (_, index) => Divider(),
      itemBuilder: (_, i) => Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          URLS.BASE_URL + listProductDetails[i].picture!))),
            ),
            SizedBox(width: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                    text: listProductDetails[i].nameProduct!,
                    fontWeight: FontWeight.w500),
                SizedBox(height: 5.0),
                TextCustom(
                    text: 'Quantity: ${listProductDetails[i].quantity}',
                    color: Colors.grey,
                    fontSize: 17),
              ],
            ),
            Expanded(
                child: Container(
              alignment: Alignment.centerRight,
              child: TextCustom(text: '\$ ${listProductDetails[i].total}'),
            ))
          ],
        ),
      ),
    );
  }
}
