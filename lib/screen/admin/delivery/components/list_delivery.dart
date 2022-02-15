// ignore_for_file: prefer_is_empty, prefer_const_constructors

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/user/user_bloc.dart';
import 'package:da/models/response/delivery_response.dart';
import 'package:da/services/url_api.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListDelivery extends StatelessWidget {
  final List<Delivery> listDelivery;

  const ListDelivery({required this.listDelivery});

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return (listDelivery.length != 0)
        ? ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            itemCount: listDelivery.length,
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: InkWell(
                onTap: () => modalDelete(context, listDelivery[i].nameDelivery!,
                    listDelivery[i].image!, () {
                  userBloc.add(OnUpdateDeliveryToClientEvent(
                      listDelivery[i].personId.toString()));
                  Navigator.pop(context);
                }),
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    URLS.BASE_URL + listDelivery[i].image!))),
                      ),
                      SizedBox(width: 15.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextCustom(
                              text: listDelivery[i].nameDelivery!,
                              fontWeight: FontWeight.w500),
                          SizedBox(height: 5.0),
                          TextCustom(
                              text: listDelivery[i].phone!, color: Colors.grey),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('Assets/no-data.svg', height: 290),
                SizedBox(height: 20.0),
                TextCustom(
                    text: 'Without Delivery men',
                    color: ColorsCustom.primaryColor,
                    fontSize: 20)
              ],
            ),
          );
  }
}
