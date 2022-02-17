// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/auth/auth_bloc.dart';
import 'package:da/helper/helper.dart';
import 'package:da/screen/client/list_address/list_address.dart';
import 'package:da/screen/client/order/client_order.dart';
import 'package:da/screen/intro/check_login.dart';
import 'package:da/screen/profile/change_password_screen.dart';
import 'package:da/screen/profile/edit_profile_screen.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileClientPage extends StatelessWidget {
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
                  context, routeCustom(page: ProfileClientPage())));
          Navigator.pop(context);
        } else if (state is FailureAuthState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: TextCustom(text: state.error, color: Colors.white),
              backgroundColor: Colors.red));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
                text: 'Add addresses',
                icon: Icons.my_location_rounded,
                colorIcon: 0xffFB5019,
                onPressed: () => Navigator.push(
                    context, routeCustom(page: ListAddressesPage())),
              ),
              ItemAccount(
                text: 'Orders',
                icon: Icons.shopping_bag_outlined,
                colorIcon: 0xffFBAD49,
                onPressed: () => Navigator.push(
                    context, routeCustom(page: ClientOrdersPage())),
              ),
              ItemAccount(
                text: 'Dark mode',
                icon: Icons.dark_mode_rounded,
                colorIcon: 0xff051E2F,
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
        bottomNavigationBar: BottomNavigationCustom(3),
      ),
    );
  }
}
