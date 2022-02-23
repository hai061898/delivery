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
    mapClientBloc.add( OnMarkerClientEvent(
        LatLng(double.parse(widget.orderClient.latitude!), double.parse(widget.orderClient.longitude!)), 
        LatLng(double.parse(widget.orderClient.latClient!), double.parse(widget.orderClient.lngClient!))
      ) 
    );
    mapClientBloc.initSocketDelivery(widget.orderClient.id.toString());
    super.initState();
  }

  @override
  void dispose() {
    mapClientBloc.disconectSocket();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Stack(
        children: [
          _MapClient(orderClient: widget.orderClient),

          Positioned(
            left: 10,
            right: 10,
            bottom: 20,
            child: _InfoCardClient( widget.orderClient)
          )
        ],
      ),
    );
  }
}

class _MapClient extends StatelessWidget {

  final OrdersClient orderClient;

  const _MapClient({required this.orderClient});
  
  @override
  Widget build(BuildContext context) {

    final mapClientBloc = BlocProvider.of<MapclientBloc>(context);
    
    return BlocBuilder<MapclientBloc, MapclientState>(
      builder: (context, state) 
        => GoogleMap(
        initialCameraPosition: CameraPosition(target:  LatLng(double.parse(orderClient.latitude!), double.parse(orderClient.longitude!)), zoom: 17.5),
        zoomControlsEnabled: false,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: mapClientBloc.initMapClient,
        markers: state.markerClient.values.toSet(),
      ),
    );
      
  }
}


