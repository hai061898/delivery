// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/user/user_bloc.dart';
import 'package:da/controllers/delivery_controller.dart';
import 'package:da/helper/helper.dart';
import 'package:da/models/response/delivery_response.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_delivery.dart';
import 'components/list_delivery.dart';

class ListDeliverysPage extends StatefulWidget {
  @override
  State<ListDeliverysPage> createState() => _ListDeliverysPageState();
}

class _ListDeliverysPageState extends State<ListDeliverysPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState)
          modalLoading(context);
        else if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSuccess(context, 'Delivery Deleted', () {
            Navigator.pop(context);
            setState(() {});
          });
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextCustom(text: 'List Delivery men'),
          centerTitle: true,
          leadingWidth: 80,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios_new_rounded,
                    color: ColorsCustom.primaryColor, size: 17),
                TextCustom(
                  text: 'Back',
                  fontSize: 17,
                  color: ColorsCustom.primaryColor,
                )
              ],
            ),
          ),
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () => Navigator.push(
                    context, routeCustom(page: AddNewDeliveryPage())),
                child: TextCustom(
                    text: 'Add',
                    color: ColorsCustom.primaryColor,
                    fontSize: 17))
          ],
        ),
        body: FutureBuilder<List<Delivery>?>(
            future: deliveryController.getAlldelivery(),
            builder: (context, snapshot) => (!snapshot.hasData)
                ? Column(
                    children: [
                      ShimmerCustom(),
                      SizedBox(height: 10.0),
                      ShimmerCustom(),
                      SizedBox(height: 10.0),
                      ShimmerCustom(),
                    ],
                  )
                : ListDelivery(listDelivery: snapshot.data!)),
      ),
    );
  }
}
