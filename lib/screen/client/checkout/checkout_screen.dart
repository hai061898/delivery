// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/cart/cart_bloc.dart';
import 'package:da/bloc/order/order_bloc.dart';
import 'package:da/bloc/payments/payments_bloc.dart';
import 'package:da/bloc/user/user_bloc.dart';
import 'package:da/helper/helper.dart';
import 'package:da/screen/client/home/home_client_screen.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/checkout_address.dart';
import 'components/checkout_payment.dart';
import 'components/detail_total.dart';

class CheckOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderBloc = BlocProvider.of<OrdersBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);
    final cartBloc = BlocProvider.of<CartBloc>(context);
    final paymentBloc = BlocProvider.of<PaymentsBloc>(context);

    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state is LoadingOrderState) {
          modalLoading(context);
        } else if (state is SuccessOrdersState) {
          Navigator.pop(context);
          modalSuccess(context, 'order received', () {
            cartBloc.add(OnClearCartEvent());
            paymentBloc.add(OnClearTypePaymentMethodEvent());
            Navigator.pushAndRemoveUntil(
                context, routeCustom(page: ClientHomePage()), (route) => false);
          });
        } else if (state is FailureOrdersState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: TextCustom(text: state.error, color: Colors.white),
              backgroundColor: Colors.red));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          title: TextCustom(text: 'Checkout', fontWeight: FontWeight.w500),
          centerTitle: true,
          elevation: 0,
          leadingWidth: 80,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios_new_rounded,
                    color: ColorsCustom.primaryColor, size: 19),
                TextCustom(
                    text: 'Back ',
                    fontSize: 17,
                    color: ColorsCustom.primaryColor)
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckoutAddress(),
                SizedBox(height: 20.0),
                CheckoutPaymentMethods(),
                SizedBox(height: 20.0),
                DetailsTotal(),
                SizedBox(height: 20.0),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocBuilder<PaymentsBloc, PaymentsState>(
                        builder: (context, state) => InkWell(
                              onTap: () {
                                orderBloc.add(OnAddNewOrdersEvent(
                                    userBloc.state.uidAddress,
                                    cartBloc.state.total,
                                    paymentBloc.state.typePaymentMethod,
                                    cartBloc.product));
                              },
                              child: Container(
                                height: 55,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: state.colorPayment,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(state.iconPayment,
                                        color: Colors.white),
                                    SizedBox(width: 10.0),
                                    TextCustom(
                                        text: state.typePaymentMethod,
                                        color: Colors.white)
                                  ],
                                ),
                              ),
                            ))
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
