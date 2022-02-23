// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/bloc/mapdelivery/mapdelivery_bloc.dart';
import 'package:da/bloc/mylocation/mylocationmap_bloc.dart';
import 'package:da/themes/color_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BtnLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapDeliveryBloc = BlocProvider.of<MapdeliveryBloc>(context);
    final locationBloc = BlocProvider.of<MylocationmapBloc>(context);

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: -5)
        ]),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 25,
          child: IconButton(
            icon: Icon(Icons.my_location_rounded,
                color: ColorsCustom.primaryColor),
            onPressed: () => mapDeliveryBloc
                .moveCamareLocation(locationBloc.state.location!),
          ),
        ),
      ),
    );
  }
}
