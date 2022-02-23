// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/mapdelivery/mapdelivery_bloc.dart';
import 'package:da/bloc/mylocation/mylocationmap_bloc.dart';
import 'package:da/bloc/order/order_bloc.dart';
import 'package:da/helper/helper.dart';
import 'package:da/models/response/order_response.dart';
import 'package:da/screen/delivery/home/home_delivery.dart';
import 'package:da/screen/delivery/order/order_deliver.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'components/btn_g.dart';
import 'components/btn_l.dart';
import 'components/information_bottom.dart';
import 'components/map_d.dart';

class MapDeliveryPage extends StatefulWidget {
  final OrdersResponse order;

  const MapDeliveryPage({required this.order});

  @override
  _MapDeliveryPageState createState() => _MapDeliveryPageState();
}

class _MapDeliveryPageState extends State<MapDeliveryPage>
    with WidgetsBindingObserver {
  late MylocationmapBloc mylocationmapBloc;
  late MapdeliveryBloc mapDeliveryBloc;

  @override
  void initState() {
    mylocationmapBloc = BlocProvider.of<MylocationmapBloc>(context);
    mapDeliveryBloc = BlocProvider.of<MapdeliveryBloc>(context);
    mylocationmapBloc.initialLocation();
    mapDeliveryBloc.initSocketDelivery();
    WidgetsBinding.instance!.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    mylocationmapBloc.cancelLocation();
    mapDeliveryBloc.disconectSocket();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (!await Geolocator.isLocationServiceEnabled() ||
          !await Permission.location.isGranted) {
        Navigator.pushReplacement(
            context, routeCustom(page: DeliveryHomePage()));
      }
    }
  }

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
              'DELIVERED',
              () => Navigator.pushAndRemoveUntil(context,
                  routeCustom(page: OrderDeliveredPage()), (route) => false));
        } else if (state is FailureOrdersState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: TextCustom(text: state.error, color: Colors.white),
              backgroundColor: Colors.red));
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            MapDelivery(order: widget.order),
            Column(
              children: [
                Align(alignment: Alignment.centerRight, child: BtnLocation()),
                SizedBox(height: 10.0),
                Align(
                    alignment: Alignment.centerRight,
                    child: BtnGoogleMap(order: widget.order)),
              ],
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: InformationBottom(order: widget.order),
            )
          ],
        ),
      ),
    );
  }
}
