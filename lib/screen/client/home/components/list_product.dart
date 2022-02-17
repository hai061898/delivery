// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:da/controllers/product_controller.dart';
import 'package:da/models/response/product_response.dart';
import 'package:da/screen/client/product/detail_product.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ListProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Productsdb>>(
      future: productController.getProductsTopHome(),
      builder: (_, snapshot) {
        final List<Productsdb>? listProduct = snapshot.data;

        return !snapshot.hasData
            ? Column(
                children: [
                  ShimmerCustom(),
                  SizedBox(height: 10.0),
                  ShimmerCustom(),
                  SizedBox(height: 10.0),
                  ShimmerCustom(),
                ],
              )
            : GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 220),
                itemCount: listProduct?.length,
                itemBuilder: (_, i) => Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(20.0)),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                DetailsProductPage(product: listProduct![i]))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Hero(
                              tag: listProduct![i].id,
                              child: Image.network(
                                  'http://127.0.0.1/' + listProduct[i].picture,
                                  height: 150)),
                        ),
                        TextCustom(
                            text: listProduct[i].nameProduct,
                            textOverflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                            color: ColorsCustom.primaryColor,
                            fontSize: 19),
                        SizedBox(height: 5.0),
                        TextCustom(
                            text: '\$ ${listProduct[i].price.toString()}',
                            fontSize: 16,
                            fontWeight: FontWeight.w500)
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
