// ignore_for_file: annotate_overrides, sized_box_for_whitespace, use_key_in_widget_constructors, prefer_const_constructors

import 'package:da/bloc/auth/auth_bloc.dart';
import 'package:da/bloc/user/user_bloc.dart';
import 'package:da/helper/helper.dart';
import 'package:da/screen/client/home/home_client_screen.dart';
import 'package:da/screen/login/login_screen.dart';
import 'package:da/screen/route_page/role_screen.dart';
import 'package:da/themes/color_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckingLoginPage extends StatefulWidget {
  @override
  _CheckingLoginPageState createState() => _CheckingLoginPageState();
}


class _CheckingLoginPageState extends State<CheckingLoginPage> with TickerProviderStateMixin {

  late AnimationController _animationController;
  
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(_animationController)..addStatusListener((status) {
      if( status == AnimationStatus.completed ){
        _animationController.reverse();
      } else if ( status == AnimationStatus.dismissed ){
        _animationController.forward();
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        
        if( state is LoadingAuthState ){

          Navigator.pushReplacement(context, routeCustom(page: CheckingLoginPage()));
        
        } else if ( state is LogOutAuthState ){

          Navigator.pushAndRemoveUntil(context, routeCustom(page: LoginPage()), (route) => false);    
         
        } else if ( state.rolId != '' ){

          userBloc.add( OnGetUserEvent(state.user!) );

          if( state.rolId  == '1' || state.rolId  == '3' ){

            Navigator.pushAndRemoveUntil(context, routeCustom(page: SelectRolePage()), (route) => false);
          
           } else if ( state.rolId  == '2' ){

            Navigator.pushAndRemoveUntil(context, routeCustom(page: ClientHomePage()), (route) => false);          
          }
        }
      },
      child: Scaffold(
        backgroundColor: ColorsCustom.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) 
                  => Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Image.asset('Assets/Logo/logo-white.png'),
                    ),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}