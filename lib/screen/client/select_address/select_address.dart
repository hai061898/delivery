// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/controllers/user_controller.dart';
import 'package:da/models/response/address_response.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'components/list_address.dart';

class SelectAddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextCustom(
          text: 'Select Addresses',
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80,
        leading: IconButton(
          icon: Row(
            children: [
              Icon(Icons.arrow_back_ios_new_rounded,
                  color: ColorsCustom.primaryColor, size: 21),
              TextCustom(
                  text: 'Back', fontSize: 16, color: ColorsCustom.primaryColor)
            ],
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<ListAddress>?>(
          future: userController.getAddresses(),
          builder: (context, snapshot) => (!snapshot.hasData)
              ? ShimmerCustom()
              : ListAddresses(listAddress: snapshot.data!)),
    );
  }
}
