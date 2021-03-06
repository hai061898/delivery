// ignore_for_file: unnecessary_this, prefer_collection_literals

part of 'map_client_bloc.dart';

@immutable
class MapclientState {

  final bool isReadyMapClient;

  final Map<String, Marker> markerClient;

  MapclientState({
    this.isReadyMapClient = false,

    Map<String, Marker>? markerClient
  }) : this.markerClient = markerClient ?? Map();


  MapclientState copyWith({ bool? isReadyMapClient, Map<String, Marker>? markerClient  })
    => MapclientState(
        isReadyMapClient: isReadyMapClient ?? this.isReadyMapClient,
        markerClient: markerClient ?? this.markerClient 
      );


}