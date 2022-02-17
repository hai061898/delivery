// ignore_for_file: override_on_non_overriding_member, avoid_unnecessary_containers, prefer_const_constructors, use_key_in_widget_constructors, curly_braces_in_flow_control_structures

import 'package:da/bloc/cart/cart_bloc.dart';
import 'package:da/helper/helper.dart';
import 'package:da/screen/client/checkout/checkout_screen.dart';
import 'package:da/screen/client/home/home_client_screen.dart';
import 'package:da/services/url_api.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartClientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextCustom(
            text: 'My Bag', fontSize: 20, fontWeight: FontWeight.w500),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80,
        leading: IconButton(
          icon: Row(
            children: [
              Icon(Icons.arrow_back_ios_new_rounded,
                  color: ColorsCustom.primaryColor, size: 19),
              TextCustom(
                  text: 'Back', fontSize: 16, color: ColorsCustom.primaryColor)
            ],
          ),
          onPressed: () => Navigator.pushAndRemoveUntil(
              context, routeCustom(page: ClientHomePage()), (route) => false),
        ),
        actions: [
          Center(
              child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) => TextCustom(
                      text: '${state.quantityCart} Items', fontSize: 17))),
          SizedBox(width: 10.0)
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) => (state.quantityCart != 0)
                      ? ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          itemCount: state.quantityCart,
                          itemBuilder: (_, i) => Dismissible(
                                key: Key(state.products![i].uidProduct),
                                direction: DismissDirection.endToStart,
                                background: Container(),
                                secondaryBackground: Container(
                                  padding: EdgeInsets.only(right: 35.0),
                                  margin: EdgeInsets.only(bottom: 15.0),
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20.0),
                                          bottomRight: Radius.circular(20.0))),
                                  child: Icon(Icons.delete_sweep_rounded,
                                      color: Colors.white, size: 40),
                                ),
                                onDismissed: (direccion) =>
                                    cartBloc.add(OnDeleteProductToCartEvent(i)),
                                child: Container(
                                    height: 90,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(bottom: 15.0),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          padding: EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  scale: 8,
                                                  image: NetworkImage(
                                                      URLS.BASE_URL +
                                                          state.products![i]
                                                              .imageProduct))),
                                        ),
                                        Container(
                                          width: 130,
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextCustom(
                                                  text: state
                                                      .products![i].nameProduct,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20),
                                              SizedBox(height: 10.0),
                                              TextCustom(
                                                  text:
                                                      '\$ ${state.products![i].price * state.products![i].quantity}',
                                                  color:
                                                      ColorsCustom.primaryColor)
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                    alignment: Alignment.center,
                                                    padding:
                                                        EdgeInsets.all(2.0),
                                                    decoration: BoxDecoration(
                                                        color: ColorsCustom
                                                            .primaryColor,
                                                        shape: BoxShape.circle),
                                                    child: InkWell(
                                                      child: Icon(Icons.remove,
                                                          color: Colors.white),
                                                      onTap: () {
                                                        if (state.products![i]
                                                                .quantity >
                                                            1)
                                                          cartBloc.add(
                                                              OnDecreaseProductQuantityToCartEvent(
                                                                  i));
                                                      },
                                                    )),
                                                SizedBox(width: 10.0),
                                                TextCustom(
                                                    text:
                                                        '${state.products![i].quantity}',
                                                    color: ColorsCustom
                                                        .primaryColor),
                                                SizedBox(width: 10.0),
                                                Container(
                                                    alignment: Alignment.center,
                                                    padding:
                                                        EdgeInsets.all(2.0),
                                                    decoration: BoxDecoration(
                                                        color: ColorsCustom
                                                            .primaryColor,
                                                        shape: BoxShape.circle),
                                                    child: InkWell(
                                                        child: Icon(Icons.add,
                                                            color:
                                                                Colors.white),
                                                        onTap: () => cartBloc.add(
                                                            OnIncreaseQuantityProductToCartEvent(
                                                                i))))
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              ))
                      : _WithOutProducts()),
            ),
            Container(
              height: 200,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              color: Colors.white,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(10.0)),
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) => Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextCustom(text: 'Total'),
                          TextCustom(text: '${state.total}'),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextCustom(text: 'Sub Total'),
                          TextCustom(text: '${state.total}'),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      BtnCustom(
                        text: 'Checkout',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: (state.quantityCart != 0)
                            ? ColorsCustom.primaryColor
                            : ColorsCustom.secundaryColor,
                        onPressed: () {
                          if (state.quantityCart != 0) {
                            Navigator.push(
                                context, routeCustom(page: CheckOutPage()));
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WithOutProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SvgPicture.asset('assets/empty-cart.svg', height: 450),
          TextCustom(
            text: 'Without products',
            fontSize: 21,
            fontWeight: FontWeight.w500,
            color: ColorsCustom.primaryColor,
          )
        ],
      ),
    );
  }
}
