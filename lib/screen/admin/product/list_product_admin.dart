// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/product/products_bloc.dart';
import 'package:da/controllers/product_controller.dart';
import 'package:da/helper/helper.dart';
import 'package:da/models/response/product_response.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_product.dart';
import 'components/gridview_product.dart';

class ListProductsPage extends StatefulWidget {
  @override
  State<ListProductsPage> createState() => _ListProductsPageState();
}

class _ListProductsPageState extends State<ListProductsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state is LoadingProductsState) {
          modalLoading(context);
        } else if (state is SuccessProductsState) {
          Navigator.pop(context);
          modalSuccess(context, 'Success', () {
            Navigator.pop(context);
            setState(() {});
          });
        } else if (state is FailureProductsState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextCustom(text: 'List Products', fontSize: 19),
          centerTitle: true,
          leadingWidth: 80,
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios_new_rounded,
                    color: ColorsCustom.primaryColor, size: 17),
                TextCustom(
                    text: 'Back',
                    fontSize: 17,
                    color: ColorsCustom.primaryColor)
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.push(
                    context, routeCustom(page: AddNewProductPage())),
                child: TextCustom(
                    text: 'Add',
                    fontSize: 17,
                    color: ColorsCustom.primaryColor))
          ],
        ),
        body: FutureBuilder<List<Productsdb>>(
            future: productController.listProductsAdmin(),
            builder: (context, snapshot) => (!snapshot.hasData)
                ? ShimmerCustom()
                : GridViewListProduct(listProducts: snapshot.data!)),
      ),
    );
  }
}
