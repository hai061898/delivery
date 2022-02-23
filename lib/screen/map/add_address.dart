// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/mylocation/mylocationmap_bloc.dart';
import 'package:da/bloc/user/user_bloc.dart';
import 'package:da/helper/helper.dart';
import 'package:da/screen/client/list_address/list_address.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'map_address.dart';

class AddStreetAddressPage extends StatefulWidget {
  @override
  _AddStreetAddressPageState createState() => _AddStreetAddressPageState();
}

class _AddStreetAddressPageState extends State<AddStreetAddressPage> {
  late TextEditingController _streetAddressController;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    _streetAddressController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _streetAddressController.clear();
    _streetAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final myLocationBloc = BlocProvider.of<MylocationmapBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context);
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSuccess(
              context,
              'Street Address added successfully',
              () => Navigator.pushReplacement(
                  context, routeCustom(page: ListAddressesPage())));
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: TextCustom(text: state.error, color: Colors.white),
              backgroundColor: Colors.red));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextCustom(text: 'New Address', fontSize: 19),
          centerTitle: true,
          elevation: 0,
          leadingWidth: 80,
          leading: TextButton(
              onPressed: () => Navigator.pushReplacement(
                  context, routeCustom(page: ListAddressesPage())),
              child: TextCustom(
                  text: 'Cancel',
                  color: ColorsCustom.primaryColor,
                  fontSize: 17)),
          actions: [
            TextButton(
                onPressed: () async {
                  if (_keyForm.currentState!.validate()) {
                    userBloc.add(OnAddNewAddressEvent(
                        _streetAddressController.text.trim(),
                        myLocationBloc.state.addressName,
                        myLocationBloc.state.locationCentral!));
                  }
                },
                child: TextCustom(
                    text: 'Save',
                    color: ColorsCustom.primaryColor,
                    fontSize: 17)),
          ],
        ),
        body: SafeArea(
          child: Form(
            key: _keyForm,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(text: 'Street Address'),
                  SizedBox(height: 5.0),
                  FormFieldCustom(
                    controller: _streetAddressController,
                    validator: RequiredValidator(
                        errorText: 'Street Address is required'),
                  ),
                  SizedBox(height: 20.0),
                  TextCustom(text: 'Reference'),
                  SizedBox(height: 5.0),
                  InkWell(
                    onTap: () async {
                      final permissionGPS = await Permission.location.isGranted;
                      final gpsActive =
                          await Geolocator.isLocationServiceEnabled();

                      if (permissionGPS && gpsActive) {
                        Navigator.push(
                            context,
                            navigatorPageFade(
                                context, MapLocationAddressPage()));
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0),
                      alignment: Alignment.centerLeft,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: .5),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: BlocBuilder<MylocationmapBloc, MylocationmapState>(
                          builder: (_, state) =>
                              TextCustom(text: state.addressName)),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextCustom(
                          text: 'Press to select direction',
                          fontSize: 16,
                          color: Colors.grey))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
