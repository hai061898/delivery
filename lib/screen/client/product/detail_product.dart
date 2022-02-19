// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, curly_braces_in_flow_control_structures

import 'package:carousel_slider/carousel_slider.dart';
import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/cart/cart_bloc.dart';
import 'package:da/controllers/product_controller.dart';
import 'package:da/models/product_cart.dart';
import 'package:da/models/response/image_product_response.dart';
import 'package:da/models/response/product_response.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsProductPage extends StatefulWidget {
  final Productsdb product;

  const DetailsProductPage({required this.product});

  @override
  _DetailsProductPageState createState() => _DetailsProductPageState();
}

class _DetailsProductPageState extends State<DetailsProductPage> {
  bool isLoading = false;
  List<ImageProductdb> imagesProducts = [];

  _getImageProducts() async {
    imagesProducts =
        await productController.getImagesProducts(widget.product.id.toString());
    setState(() {
      isLoading = true;
    });
  }

  @override
  void initState() {
    _getImageProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (isLoading)
                ? Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 360,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(40.0),
                                    bottomRight: Radius.circular(40.0))),
                            child: Hero(
                              tag: widget.product.id,
                              child: Container(
                                height: 180,
                                child: CarouselSlider.builder(
                                  itemCount: imagesProducts.length,
                                  options: CarouselOptions(
                                      viewportFraction: 1.0, autoPlay: true),
                                  itemBuilder: (context, i, realIndex) =>
                                      Container(
                                    width: size.width,
                                    child: Image.network(
                                        'http://127.0.0.1/' +
                                            imagesProducts[i].picture),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                cartBloc.add(OnResetQuantityEvent());
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Icon(Icons.arrow_back_ios_new_rounded,
                                    size: 20),
                              ),
                            ),
                            TextCustom(
                                text: 'Details',
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Icon(Icons.favorite_border_outlined,
                                  size: 20),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : ShimmerCustom(),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                    decoration: BoxDecoration(
                        color: ColorsCustom.primaryColor,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Row(
                      children: [
                        Icon(Icons.star_rounded, color: Colors.white, size: 18),
                        SizedBox(width: 3.0),
                        TextCustom(
                            text: '4.9', color: Colors.white, fontSize: 17)
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.timer, size: 18),
                      SizedBox(width: 5.0),
                      TextCustom(text: '30 Min'),
                    ],
                  ),
                  TextCustom(text: '\$ Free Shipping')
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                child: TextCustom(
                    text: widget.product.nameProduct,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                child: TextCustom(
                    text: widget.product.description,
                    fontSize: 18,
                    color: Colors.grey,
                    maxLine: 5),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15.0)),
                          child: BlocBuilder<CartBloc, CartState>(
                            builder: (context, state) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      if (state.quantity > 1)
                                        cartBloc.add(
                                            OnDecreaseProductQuantityEvent());
                                    }),
                                SizedBox(width: 10.0),
                                TextCustom(
                                    text: state.quantity.toString(),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                                SizedBox(width: 10.0),
                                IconButton(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    icon: Icon(Icons.add),
                                    onPressed: () => cartBloc
                                        .add(OnIncreaseProductQuantityEvent())),
                              ],
                            ),
                          ),
                        ),
                        (widget.product.status == 1)
                            ? Container(
                                height: 50,
                                width: 220,
                                decoration: BoxDecoration(
                                    color: ColorsCustom.primaryColor,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      child: TextCustom(
                                          text: 'Add to cart',
                                          color: Colors.white,
                                          fontSize: 18),
                                      onPressed: () {
                                        final newProduct = ProductCart(
                                            uidProduct:
                                                widget.product.id.toString(),
                                            imageProduct:
                                                widget.product.picture,
                                            nameProduct:
                                                widget.product.nameProduct,
                                            price: widget.product.price,
                                            quantity: cartBloc.state.quantity);
                                        cartBloc.add(OnAddProductToCartEvent(
                                            newProduct));
                                        modalSuccess(context, 'Product Added',
                                            () => Navigator.pop(context));
                                      },
                                    ),
                                    SizedBox(width: 5.0),
                                    BlocBuilder<CartBloc, CartState>(
                                        builder: (context, state) => TextCustom(
                                            text:
                                                '\$ ${widget.product.price * state.quantity}',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20))
                                  ],
                                ))
                            : Container(
                                height: 50,
                                width: 220,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.sentiment_dissatisfied_rounded,
                                        color: Colors.white, size: 30),
                                    SizedBox(width: 5.0),
                                    TextCustom(
                                        text: 'SOLD OUT',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)
                                  ],
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
