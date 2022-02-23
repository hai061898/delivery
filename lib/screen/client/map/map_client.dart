// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors

import 'package:da/bloc/mapclient/map_client_bloc.dart';
import 'package:da/models/response/order_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'components/info_map_client.dart';
import 'components/map_client.dart';

class ClientMapPage extends StatefulWidget {
  final OrdersClient orderClient;

  const ClientMapPage({required this.orderClient});

  @override
  _ClientMapPageState createState() => _ClientMapPageState();
}

class _ClientMapPageState extends State<ClientMapPage> {
  late MapclientBloc mapClientBloc;

  @override
  void initState() {
    mapClientBloc = BlocProvider.of<MapclientBloc>(context);
    mapClientBloc.add(OnMarkerClientEvent(
        LatLng(double.parse(widget.orderClient.latitude!),
            double.parse(widget.orderClient.longitude!)),
        LatLng(double.parse(widget.orderClient.latClient!),
            double.parse(widget.orderClient.lngClient!))));
    mapClientBloc.initSocketDelivery(widget.orderClient.id.toString());
    super.initState();
  }

  @override
  void dispose() {
    mapClientBloc.disconectSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapClient(orderClient: widget.orderClient),
          Positioned(
              left: 10,
              right: 10,
              bottom: 20,
              child: InfoCardClient(widget.orderClient))
        ],
      ),
    );
  }
}
