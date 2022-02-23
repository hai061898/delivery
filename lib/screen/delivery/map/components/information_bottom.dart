// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/mylocation/mylocationmap_bloc.dart';
import 'package:da/bloc/order/order_bloc.dart';
import 'package:da/helper/helper.dart';
import 'package:da/models/response/order_response.dart';
import 'package:da/services/url_api.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class InformationBottom extends StatelessWidget {
  final OrdersResponse order;

  const InformationBottom({required this.order});

  @override
  Widget build(BuildContext context) {
    final orderBloc = BlocProvider.of<OrdersBloc>(context);

    return Container(
      padding: EdgeInsets.all(15.0),
      height: 183,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),
                blurRadius: 7,
                spreadRadius: 5)
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 28, color: Colors.black87),
              SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                      text: 'Delivery Address',
                      fontSize: 15,
                      color: Colors.grey),
                  TextCustom(text: order.reference!, fontSize: 16, maxLine: 2),
                ],
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image:
                            NetworkImage(URLS.BASE_URL + order.clientImage!))),
              ),
              SizedBox(width: 10.0),
              TextCustom(text: order.cliente!),
              Spacer(),
              InkWell(
                onTap: () async => await urlLauncherCustom
                    .makePhoneCall('tel:${order.clientPhone}'),
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200]),
                  child: Icon(Icons.phone, color: ColorsCustom.primaryColor),
                ),
              )
            ],
          ),
          SizedBox(height: 10.0),
          BlocBuilder<MylocationmapBloc, MylocationmapState>(
            builder: (context, state) => BtnCustom(
              height: 45,
              text: 'DELIVERED',
              fontWeight: FontWeight.w500,
              onPressed: () {
                final distanceDelivery = Geolocator.distanceBetween(
                    state.location!.latitude,
                    state.location!.longitude,
                    double.parse(order.latitude!),
                    double.parse(order.longitude!));

                if (distanceDelivery <= 150) {
                  orderBloc.add(OnUpdateStatusOrderDeliveredEvent(
                      order.orderId.toString()));
                } else {
                  modalInfo(context, 'Its still far away');
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
