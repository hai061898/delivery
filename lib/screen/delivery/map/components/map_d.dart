// ignore_for_file: prefer_const_constructors

import 'package:da/bloc/mapdelivery/mapdelivery_bloc.dart';
import 'package:da/bloc/mylocation/mylocationmap_bloc.dart';
import 'package:da/models/response/order_response.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDelivery extends StatelessWidget {
  final OrdersResponse order;

  const MapDelivery({required this.order});

  @override
  Widget build(BuildContext context) {
    final mapDelivery = BlocProvider.of<MapdeliveryBloc>(context);
    final myLocationDeliveryBloc = BlocProvider.of<MylocationmapBloc>(context);

    return BlocBuilder<MylocationmapBloc, MylocationmapState>(
        builder: (_, state) {
      if (state.location != null) {
        mapDelivery.add(OnMarkertsDeliveryEvent(
            state.location!,
            LatLng(double.parse(order.latitude!),
                double.parse(order.longitude!))));
        mapDelivery.add(OnEmitLocationDeliveryEvent(
            order.orderId.toString(), myLocationDeliveryBloc.state.location!));
      }

      return (state.existsLocation)
          ? GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: state.location!, zoom: 17.5),
              zoomControlsEnabled: false,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: mapDelivery.initMapDeliveryFrave,
              markers: mapDelivery.state.markers.values.toSet(),
              polylines: mapDelivery.state.polyline!.values.toSet(),
            )
          : Center(
              child: TextCustom(text: 'Locating...'),
            );
    });
  }
}
