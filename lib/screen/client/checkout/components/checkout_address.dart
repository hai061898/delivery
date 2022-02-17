// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:da/bloc/user/user_bloc.dart';
import 'package:da/helper/helper.dart';
import 'package:da/screen/client/select_address/select_address.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      height: 95,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextCustom(text: 'Shipping Address', fontWeight: FontWeight.w500),
              InkWell(
                  onTap: () => Navigator.push(
                      context, routeCustom(page: SelectAddressPage())),
                  child: TextCustom(
                      text: 'Change',
                      color: ColorsCustom.primaryColor,
                      fontSize: 17))
            ],
          ),
          Divider(),
          SizedBox(height: 5.0),
          BlocBuilder<UserBloc, UserState>(
              builder: (_, state) => TextCustom(
                  text: (state.addressName != '')
                      ? state.addressName
                      : 'Select Address',
                  fontSize: 17,
                  maxLine: 1))
        ],
      ),
    );
  }
}
