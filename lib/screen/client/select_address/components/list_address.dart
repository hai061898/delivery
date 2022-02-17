// ignore_for_file: prefer_is_empty, prefer_const_constructors, sized_box_for_whitespace

import 'package:da/bloc/user/user_bloc.dart';
import 'package:da/models/response/address_response.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListAddresses extends StatelessWidget {
  final List<ListAddress> listAddress;

  const ListAddresses({Key? key, required this.listAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return (listAddress.length != 0)
        ? ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            itemCount: listAddress.length,
            itemBuilder: (_, i) => Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10.0)),
              child: ListTile(
                leading: BlocBuilder<UserBloc, UserState>(
                    builder: (_, state) =>
                        (state.uidAddress == listAddress[i].id)
                            ? Icon(Icons.radio_button_checked_rounded,
                                color: ColorsCustom.primaryColor)
                            : Icon(Icons.radio_button_off_rounded)),
                title: TextCustom(
                    text: listAddress[i].street!,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
                subtitle: TextCustom(
                    text: listAddress[i].reference!,
                    fontSize: 16,
                    color: ColorsCustom.secundaryColor),
                onTap: () => userBloc.add(OnSelectAddressButtonEvent(
                    listAddress[i].id!, listAddress[i].reference!)),
              ),
            ),
          )
        : _WithoutListAddress();
  }
}

class _WithoutListAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('Assets/my-location.svg', height: 400),
          TextCustom(
              text: 'Without Address',
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: ColorsCustom.secundaryColor),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}
