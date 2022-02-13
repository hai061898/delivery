// ignore_for_file: prefer_const_constructors

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/models/response/product_response.dart';
import 'package:da/services/url_api.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GridViewListProduct extends StatelessWidget {
  final List<Productsdb> listProducts;

  const GridViewListProduct({required this.listProducts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      itemCount: listProducts.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemBuilder: (context, i) => InkWell(
        onTap: () => modalActiveOrInactiveProduct(
            context,
            listProducts[i].status,
            listProducts[i].nameProduct,
            listProducts[i].id,
            listProducts[i].picture),
        onLongPress: () => modalDeleteProduct(
            context,
            listProducts[i].nameProduct,
            listProducts[i].picture,
            listProducts[i].id.toString()),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      scale: 7,
                      image: NetworkImage(
                          URLS.BASE_URL + listProducts[i].picture))),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: (listProducts[i].status == 1)
                        ? Colors.grey[50]
                        : Colors.red[100]),
                child:
                    TextCustom(text: listProducts[i].nameProduct, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
