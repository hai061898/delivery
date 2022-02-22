
// ignore_for_file: prefer_const_constructors, library_prefixes

import 'dart:convert';

import 'package:da/helper/helper.dart';
import 'package:da/services/url_api.dart';
import 'package:da/themes/theme_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'map_client_state.dart';
part 'map_client_event.dart';

class MapclientBloc extends Bloc<MapclientEvent, MapclientState> {
  MapclientBloc() : super(MapclientState()) {
    on<OnReadyMapClientEvent>(_onReadyMapClient);
    on<OnMarkerClientEvent>(_onMarkerClient);
    on<OnPositionDeliveryEvent>(_onPositionDelivery);
  }

  late GoogleMapController _mapController;
  late IO.Socket _socket;

  void initMapClient(GoogleMapController controller) {
    if (!state.isReadyMapClient) {
      _mapController = controller;

      _mapController.setMapStyle(jsonEncode(themeMaps));

      add(OnReadyMapClientEvent());
    }
  }

  void initSocketDelivery(String idOrder) {
    _socket = IO.io(URLS.BASE_URL + 'orders-delivery-socket', {
      'transports': ['websocket'],
      'autoConnect': true,
    });

    _socket.connect();

    _socket.on('position/$idOrder', (data) {
      add(OnPositionDeliveryEvent(LatLng(data['latitude'], data['longitude'])));
    });
  }

  void disconectSocket() {
    _socket.disconnect();
  }

  Future<void> _onReadyMapClient(
      OnReadyMapClientEvent event, Emitter<MapclientState> emit) async {
    emit(state.copyWith(isReadyMapClient: true));
  }

  Future<void> _onMarkerClient(
      OnMarkerClientEvent event, Emitter<MapclientState> emit) async {
    final marketCustom =
        await getAssetImageMarker('assets/food-delivery-marker.png');
    final iconDestination =
        await getAssetImageMarker('assets/delivery-destination.png');

    final markerDeliver = Marker(
        markerId: MarkerId('markerDeliver'),
        position: event.delivery,
        icon: marketCustom);

    final markerClient = Marker(
        markerId: MarkerId('markerClient'),
        position: event.client,
        icon: iconDestination);

    final newMarker = {...state.markerClient};
    newMarker['markerDeliver'] = markerDeliver;
    newMarker['markerClient'] = markerClient;

    emit(state.copyWith(markerClient: newMarker));
  }

  Future<void> _onPositionDelivery(
      OnPositionDeliveryEvent event, Emitter<MapclientState> emit) async {
    final deliveryMarker =
        await getAssetImageMarker('assets/food-delivery-marker.png');

    final markerDeliver = Marker(
        markerId: MarkerId('markerDeliver'),
        position: event.location,
        icon: deliveryMarker);

    final newMarker = {...state.markerClient};
    newMarker['markerDeliver'] = markerDeliver;

    emit(state.copyWith(markerClient: newMarker));
  }
}
