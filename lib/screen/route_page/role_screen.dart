// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/bloc/auth/auth_bloc.dart';
import 'package:da/helper/helper.dart';
import 'package:da/screen/admin/home/admin_home.dart';
import 'package:da/screen/client/home/home_client_screen.dart';
import 'package:da/screen/route_page/components/btn_r.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectRolePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final authBloc = BlocProvider.of<AuthBloc>(context).state;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextCustom(text: 'Star', fontSize: 25, color: ColorsCustom.primaryColor, fontWeight: FontWeight.w500 ),
                  TextCustom(text: 'Food', fontSize: 25, color: ColorsCustom.secundaryColor, fontWeight: FontWeight.w500 ),
                ],
              ),
              SizedBox(height: 20.0),
              TextCustom(text: 'How do you want to continue?', color: ColorsCustom.secundaryColor, fontSize: 25,),
              SizedBox(height: 30.0),
              ( authBloc.user!.rolId == 1) 
                ? BtnRol(
                svg: 'assets/svg/restaurante.svg',
                text: 'Restaurant',
                color1: ColorsCustom.primaryColor.withOpacity(.2),
                color2: Colors.greenAccent.withOpacity(.1),
                onPressed: () => Navigator.pushAndRemoveUntil(context, routeCustom(page: AdminHomePage()), (route) => false),
              ) : Container(),
              (authBloc.user!.rolId == 1 || authBloc.user!.rolId == 3 )
                ? BtnRol(
                svg: 'assets/svg/bussiness-man.svg',
                text: 'Client',
                color1: Color(0xffFE6488).withOpacity(.2),
                color2: Colors.amber.withOpacity(.1),
                onPressed: () => Navigator.pushReplacement(context, routeCustom(page: ClientHomePage())),
              ) : Container() ,
              (authBloc.user!.rolId == 1 || authBloc.user!.rolId == 3 ) 
                ? BtnRol(
                svg: 'assets/svg/delivery-bike.svg',
                text: 'Delivery',
                color1: Color(0xff8956FF).withOpacity(.2),
                color2: Colors.purpleAccent.withOpacity(.1),
                onPressed: () => Navigator.pushAndRemoveUntil(context, routeCustom(page: DeliveryHomePage()), (route) => false),
              ) : Container()
            ],
          ),
        ),
      ),
    );
  }
}