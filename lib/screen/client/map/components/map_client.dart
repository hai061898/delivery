// ignore_for_file: use_key_in_widget_constructors

import 'package:da/bloc/mapclient/map_client_bloc.dart';
import 'package:da/models/response/order_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapClient extends StatelessWidget {
  final OrdersClient orderClient;

  const MapClient({required this.orderClient});

  @override
  Widget build(BuildContext context) {
    final mapClientBloc = BlocProvider.of<MapclientBloc>(context);

    return BlocBuilder<MapclientBloc, MapclientState>(
      builder: (context, state) => GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(double.parse(orderClient.latitude!),
                double.parse(orderClient.longitude!)),
            zoom: 17.5),
        zoomControlsEnabled: false,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: mapClientBloc.initMapClient,
        markers: state.markerClient.values.toSet(),
      ),
    );
  }
}
