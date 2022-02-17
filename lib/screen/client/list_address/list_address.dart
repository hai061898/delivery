// ignore_for_file: override_on_non_overriding_member, sized_box_for_whitespace, prefer_const_constructors, prefer_is_empty, use_key_in_widget_constructors

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/user/user_bloc.dart';
import 'package:da/controllers/user_controller.dart';
import 'package:da/helper/helper.dart';
import 'package:da/models/response/address_response.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class ListAddressesPage extends StatefulWidget {
  @override
  _ListAddressesPageState createState() => _ListAddressesPageState();
}

class _ListAddressesPageState extends State<ListAddressesPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Permission.location.isGranted) {
        Navigator.push(context, routeCustom(page: AddStreetAddressPage()));
      }
    }
  }

  void accessLocation(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        Navigator.push(context, routeCustom(page: AddStreetAddressPage()));
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context);
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextCustom(text: 'List Addresses', fontSize: 19),
          centerTitle: true,
          elevation: 0,
          leadingWidth: 80,
          leading: TextButton(
              onPressed: () => Navigator.pushReplacement(
                  context, routeCustom(page: ProfileClientPage())),
              child: TextCustom(
                  text: 'Cancel',
                  color: ColorsCustom.primaryColor,
                  fontSize: 17)),
          actions: [
            TextButton(
                onPressed: () async =>
                    accessLocation(await Permission.location.request()),
                child: TextCustom(
                    text: 'Add',
                    color: ColorsCustom.primaryColor,
                    fontSize: 17)),
          ],
        ),
        body: FutureBuilder<List<ListAddress>?>(
            future: userController.getAddresses(),
            builder: (context, snapshot) => (!snapshot.hasData)
                ? ShimmerCustom()
                : _ListAddresses(listAddress: snapshot.data!)),
      ),
    );
  }
}

class _ListAddresses extends StatelessWidget {
  final List<ListAddress> listAddress;

  const _ListAddresses({Key? key, required this.listAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return (listAddress.length != 0)
        ? ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            itemCount: listAddress.length,
            itemBuilder: (_, i) => Dismissible(
                  key: Key(listAddress[i].id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(),
                  onDismissed: (direction) => userBloc
                      .add(OnDeleteStreetAddressEvent(listAddress[i].id!)),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                    margin: EdgeInsets.only(bottom: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0))),
                    child: Icon(Icons.delete_sweep_rounded,
                        color: Colors.white, size: 38),
                  ),
                  child: Container(
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
                      trailing: Icon(Icons.swap_horiz_rounded,
                          color: Colors.red[300]),
                      onTap: () => userBloc.add(OnSelectAddressButtonEvent(
                          listAddress[i].id!, listAddress[i].reference!)),
                    ),
                  ),
                ))
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
          SvgPicture.asset('assets/my-location.svg', height: 400),
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
