// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/helper/helper.dart';
import 'package:da/models/response/order_client.dart';
import 'package:da/models/response/order_detail.dart';
import 'package:da/screen/client/map/map_client.dart';
import 'package:da/services/url_api.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../controllers/order_controller.dart';

class ClientDetailsOrderPage extends StatelessWidget {
  final OrdersClient orderClient;

  const ClientDetailsOrderPage({required this.orderClient});

  void accessGps(PermissionStatus status, BuildContext context) {
    switch (status) {
      case PermissionStatus.granted:
        Navigator.pushReplacement(context,
            routeCustom(page: ClientMapPage(orderClient: orderClient)));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextCustom(
            text: 'ORDER # ${orderClient.id}',
            fontSize: 17,
            fontWeight: FontWeight.w500),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios_new_rounded,
                  color: ColorsCustom.primaryColor, size: 17),
              TextCustom(
                  text: 'Back', fontSize: 17, color: ColorsCustom.primaryColor)
            ],
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 10.0),
            child: TextCustom(
              text: orderClient.status!,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: (orderClient.status == 'DELIVERED'
                  ? ColorsCustom.primaryColor
                  : ColorsCustom.secundaryColor),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: FutureBuilder<List<DetailsOrder>?>(
                  future: ordersController
                      .gerOrderDetailsById(orderClient.id.toString()),
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
                      : _ListProductsDetails(
                          listProductDetails: snapshot.data!))),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextCustom(
                        text: 'TOTAL',
                        fontWeight: FontWeight.w500,
                        color: ColorsCustom.primaryColor),
                    TextCustom(
                        text: '\$ ${orderClient.amount}0',
                        fontWeight: FontWeight.w500),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextCustom(
                        text: 'DELIVERY',
                        fontWeight: FontWeight.w500,
                        color: ColorsCustom.primaryColor,
                        fontSize: 17),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      (orderClient.imageDelivery != null)
                                          ? URLS.BASE_URL +
                                              orderClient.imageDelivery!
                                          : URLS.BASE_URL +
                                              'without-image.png'))),
                        ),
                        SizedBox(width: 10.0),
                        TextCustom(
                            text: (orderClient.deliveryId != 0)
                                ? orderClient.delivery!
                                : 'Not assigned',
                            fontSize: 17),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextCustom(
                        text: 'DATE',
                        fontWeight: FontWeight.w500,
                        color: ColorsCustom.primaryColor,
                        fontSize: 17),
                    TextCustom(
                        text: DateCustom.getDateOrder(
                            orderClient.currentDate.toString()),
                        fontSize: 16),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextCustom(
                        text: 'ADDRESS',
                        fontWeight: FontWeight.w500,
                        color: ColorsCustom.primaryColor,
                        fontSize: 16),
                    TextCustom(
                        text: orderClient.reference!, fontSize: 16, maxLine: 1),
                  ],
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          (orderClient.status == 'ON WAY')
              ? Container(
                  padding: EdgeInsets.all(15.0),
                  child: BtnCustom(
                    text: 'FOLLOW DELIVERY',
                    fontWeight: FontWeight.w500,
                    onPressed: () async =>
                        accessGps(await Permission.location.request(), context),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

class _ListProductsDetails extends StatelessWidget {
  final List<DetailsOrder> listProductDetails;

  const _ListProductsDetails({required this.listProductDetails});

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
