// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/auth/auth_bloc.dart';
import 'package:da/bloc/user/user_bloc.dart';
import 'package:da/helper/helper.dart';
import 'package:da/screen/intro/check_login.dart';
import 'package:da/screen/profile/edit_profile_screen.dart';
import 'package:da/screen/route_page/role_screen.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {

        if (state is LoadingUserState) {

          modalLoading(context);

        } else if (state is SuccessUserState) {

          Navigator.pop(context);
          modalSuccess(context, 'Picture Change Successfully', () => Navigator.pushReplacement(context, routeCustom(page: AdminHomePage())));
          Navigator.pop(context);

        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: [
              Align(alignment: Alignment.center, child: ImagePickerCustom()),
              SizedBox(height: 10.0),
              Center(
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (_, state) 
                    => TextCustom( text: ( state.user != null) ? state.user!.firstName!.toUpperCase() + ' ' + state.user!.lastName!.toUpperCase() : '',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        maxLine: 1,
                        textAlign: TextAlign.center,
                        color: ColorsCustom.secundaryColor
                      )
                )
              ),
              SizedBox(height: 5.0),
              Center(
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (_, state) 
                      => TextCustom( text: (state.user != null ) ? state.user!.email! : '', fontSize: 20, color: ColorsCustom.secundaryColor)
                  )
              ),
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
                onPressed: () => Navigator.pushAndRemoveUntil(context, routeCustom(page: SelectRolePage()), (route) => false),
              ),
              ItemAccount(
                text: 'Dark mode',
                icon: Icons.dark_mode_rounded,
                colorIcon: 0xff051E2F,
              ),
              SizedBox(height: 15.0),
              TextCustom(text: 'Restaurant', color: Colors.grey),
              SizedBox(height: 10.0),
              ItemAccount(
                text: 'Categories',
                icon: Icons.category_rounded,
                colorIcon: 0xff5E65CD,
                onPressed: () => Navigator.push(
                    context, routeCustom(page: CategoriesAdminPage())),
              ),
              ItemAccount(
                text: 'Products',
                icon: Icons.add,
                colorIcon: 0xff355773,
                onPressed: () => Navigator.push(
                    context, routeCustom(page: ListProductsPage())),
              ),
              ItemAccount(
                text: 'Delivery',
                icon: Icons.delivery_dining_rounded,
                colorIcon: 0xff469CD7,
                onPressed: () => Navigator.push(
                    context, routeCustom(page: ListDeliverysPage())),
              ),
              ItemAccount(
                text: 'Orders',
                icon: Icons.checklist_rounded,
                colorIcon: 0xffFFA136,
                onPressed: () => Navigator.push(
                    context, routeCustom(page: OrdersAdminPage())),
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
                  Navigator.pushAndRemoveUntil(
                    context,
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