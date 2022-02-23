// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/auth/auth_bloc.dart';
import 'package:da/helper/helper.dart';
import 'package:da/screen/delivery/order/list_order.dart';
import 'package:da/screen/delivery/order/order_deliver.dart';
import 'package:da/screen/delivery/order/order_onway.dart';
import 'package:da/screen/intro/check_login.dart';
import 'package:da/screen/profile/change_password_screen.dart';
import 'package:da/screen/profile/edit_profile_screen.dart';
import 'package:da/screen/route_page/role_screen.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingAuthState) {
          modalLoading(context);
        } else if (state is SuccessAuthState) {
          Navigator.pop(context);
          modalSuccess(
              context,
              'Picture Change Successfully',
              () => Navigator.pushReplacement(
                  context, routeCustom(page: DeliveryHomePage())));
          Navigator.pop(context);
        } else if (state is FailureAuthState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: [
              SizedBox(height: 20.0),
              Align(alignment: Alignment.center, child: ImagePickerCustom()),
              SizedBox(height: 20.0),
              Center(
                  child: TextCustom(
                      text: authBloc.state.user!.firstName! +
                          ' ' +
                          authBloc.state.user!.lastName!,
                      fontSize: 25,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 5.0),
              Center(
                  child: TextCustom(
                      text: authBloc.state.user!.email!,
                      fontSize: 20,
                      color: Colors.grey)),
              SizedBox(height: 15.0),
              TextCustom(text: 'Account', color: Colors.grey),
              SizedBox(height: 10.0),
              ItemAccount(
                text: 'Profile setting',
                icon: Icons.person,
                colorIcon: 0xff01C58C,
                onPressed: () => Navigator.push(
                    context, routeCustom(page: EditProfilePage())),
              ),
              ItemAccount(
                text: 'Change Password',
                icon: Icons.lock_rounded,
                colorIcon: 0xff1B83F5,
                onPressed: () => Navigator.push(
                    context, routeCustom(page: ChangePasswordPage())),
              ),
              ItemAccount(
                text: 'Change Role',
                icon: Icons.swap_horiz_rounded,
                colorIcon: 0xffE62755,
                onPressed: () => Navigator.pushAndRemoveUntil(context,
                    routeCustom(page: SelectRolePage()), (route) => false),
              ),
              ItemAccount(
                text: 'Dark mode',
                icon: Icons.dark_mode_rounded,
                colorIcon: 0xff051E2F,
              ),
              SizedBox(height: 15.0),
              TextCustom(text: 'Delivery', color: Colors.grey),
              SizedBox(height: 10.0),
              ItemAccount(
                text: 'Orders',
                icon: Icons.checklist_rounded,
                colorIcon: 0xff5E65CD,
                onPressed: () => Navigator.push(
                    context, routeCustom(page: ListOrdersDeliveryPage())),
              ),
              ItemAccount(
                text: 'On Way',
                icon: Icons.delivery_dining_rounded,
                colorIcon: 0xff1A60C1,
                onPressed: () => Navigator.push(
                    context, routeCustom(page: OrderOnWayPage())),
              ),
              ItemAccount(
                text: 'Delivered',
                icon: Icons.check_rounded,
                colorIcon: 0xff4BB17B,
                onPressed: () => Navigator.push(
                    context, routeCustom(page: OrderDeliveredPage())),
              ),
              SizedBox(height: 15.0),
              TextCustom(text: 'Personal', color: Colors.grey),
              SizedBox(height: 10.0),
              ItemAccount(
                text: 'Privacy & Policy',
                icon: Icons.policy_rounded,
                colorIcon: 0xff6dbd63,
              ),
              ItemAccount(
                text: 'Security',
                icon: Icons.lock_outline_rounded,
                colorIcon: 0xff1F252C,
              ),
              ItemAccount(
                text: 'Term & Conditions',
                icon: Icons.description_outlined,
                colorIcon: 0xff458bff,
              ),
              ItemAccount(
                text: 'Help',
                icon: Icons.help_outline,
                colorIcon: 0xff4772e6,
              ),
              Divider(),
              ItemAccount(
                text: 'Sign Out',
                icon: Icons.power_settings_new_sharp,
                colorIcon: 0xffF02849,
                onPressed: () {
                  authBloc.add(LogOutEvent());
                  Navigator.pushAndRemoveUntil(context,
                      routeCustom(page: CheckingLoginPage()), (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
