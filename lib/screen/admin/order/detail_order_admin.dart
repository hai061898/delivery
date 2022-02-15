// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/order/order_bloc.dart';
import 'package:da/controllers/order_controller.dart';
import 'package:da/helper/helper.dart';
import 'package:da/models/response/order_detail.dart';
import 'package:da/models/response/order_response.dart';
import 'package:da/services/url_api.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component/list_product_detail.dart';
import 'order_admin.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrdersResponse order;

  const OrderDetailsPage({required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state is LoadingOrderState) {
          modalLoading(context);
        } else if (state is SuccessOrdersState) {
          Navigator.pop(context);
          modalSuccess(
              context,
              'DISPATCHED',
              () => Navigator.pushReplacement(
                  context, routeCustom(page: OrdersAdminPage())));
        } else if (state is FailureOrdersState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: TextCustom(text: state.error, color: Colors.white),
              backgroundColor: Colors.red));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: TextCustom(text: 'Order N° ${order.orderId}'),
          centerTitle: true,
          leadingWidth: 80,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios_new_rounded,
                    size: 17, color: ColorsCustom.primaryColor),
                TextCustom(
                    text: 'Back',
                    color: ColorsCustom.primaryColor,
                    fontSize: 17)
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: FutureBuilder<List<DetailsOrder>?>(
                    future: ordersController
                        .gerOrderDetailsById(order.orderId.toString()),
                    builder: (context, snapshot) => (!snapshot.hasData)
                        ? Column(
                            children: [
                              ShimmerCustom(),
                              SizedBox(height: 10.0),
                              ShimmerCustom(),
                              SizedBox(height: 10.0),
                              ShimmerCustom(),
                            ],
                          )
                        : ListProductsDetails(
                            listProductDetails: snapshot.data!))),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextCustom(
                          text: 'Total',
                          color: ColorsCustom.secundaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                      TextCustom(
                          text: '\$ ${order.amount}0',
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextCustom(
                          text: 'Cliente:',
                          color: ColorsCustom.secundaryColor,
                          fontSize: 16),
                      TextCustom(text: '${order.cliente}'),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextCustom(
                          text: 'Date:',
                          color: ColorsCustom.secundaryColor,
                          fontSize: 16),
                      TextCustom(
                          text: DateCustom.getDateOrder(
                              order.currentDate.toString()),
                          fontSize: 16),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  TextCustom(
                      text: 'Address shipping:',
                      color: ColorsCustom.secundaryColor,
                      fontSize: 16),
                  SizedBox(height: 5.0),
                  TextCustom(text: order.reference!, maxLine: 2, fontSize: 16),
                  SizedBox(height: 5.0),
                  (order.status == 'DISPATCHED')
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextCustom(
                                text: 'Delivery',
                                fontSize: 17,
                                color: ColorsCustom.secundaryColor),
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(URLS.BASE_URL +
                                              order.deliveryImage!))),
                                ),
                                SizedBox(width: 10.0),
                                TextCustom(text: order.delivery!, fontSize: 17)
                              ],
                            )
                          ],
                        )
                      : Container()
                ],
              ),
            )),
            (order.status == 'PAID OUT')
                ? Container(
                    padding: EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BtnCustom(
                          text: 'SELECT DELIVERY',
                          fontWeight: FontWeight.w500,
                          onPressed: () => modalSelectDelivery(
                              context, order.orderId.toString()),
                        )
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
