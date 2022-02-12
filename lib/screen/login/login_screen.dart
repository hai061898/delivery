// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/auth/auth_bloc.dart';
import 'package:da/bloc/user/user_bloc.dart';
import 'package:da/helper/helper.dart';
import 'package:da/screen/forgetpassword/forget_password_screen.dart';
import 'package:da/screen/intro/intro_page.dart';
import 'package:da/screen/route_page/role_screen.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.clear();
    _passwordController.clear();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is LoadingAuthState) {
          modalLoading(context);
        } else if (state is FailureAuthState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state.rolId != '') {
          userBloc.add(OnGetUserEvent(state.user!));
          Navigator.pop(context);

          if (state.rolId == '1' || state.rolId == '3') {
            Navigator.pushAndRemoveUntil(
                context, routeCustom(page: SelectRolePage()), (route) => false);
          } else if (state.rolId == '2') {
            Navigator.pushAndRemoveUntil(
                context, routeCustom(page: ClientHomePage()), (route) => false);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: _keyForm,
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pushReplacement(
                            context, routeCustom(page: IntroPage())),
                        borderRadius: BorderRadius.circular(100.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey[50], shape: BoxShape.circle),
                          child: Icon(Icons.arrow_back_ios_new_outlined,
                              color: Colors.black, size: 20),
                        ),
                      ),
                      Row(
                        children: [
                          TextCustom(
                              text: 'Star',
                              color: ColorsCustom.primaryColor,
                              fontWeight: FontWeight.w500),
                          TextCustom(
                              text: 'Food',
                              color: Colors.black87,
                              fontWeight: FontWeight.w500),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Image.asset('assets/Logo/logo-black.png', height: 150),
                SizedBox(height: 30.0),
                Container(
                  alignment: Alignment.center,
                  child: TextCustom(
                      text: 'Welcome back!',
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff14222E)),
                ),
                SizedBox(height: 5.0),
                Align(
                  alignment: Alignment.center,
                  child: TextCustom(
                      text:
                          'Use your credentials below and login to your account.',
                      textAlign: TextAlign.center,
                      color: Colors.grey,
                      maxLine: 2,
                      fontSize: 16),
                ),
                SizedBox(height: 50.0),
                TextCustom(text: 'Email Address'),
                SizedBox(height: 5.0),
                FormFieldCustom(
                  controller: _emailController,
                  hintText: 'email@frave.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: validatedEmail,
                ),
                SizedBox(height: 20.0),
                TextCustom(text: 'Password'),
                SizedBox(height: 5.0),
                FormFieldCustom(
                  controller: _passwordController,
                  hintText: '********',
                  isPassword: true,
                  validator: passwordValidator,
                ),
                SizedBox(height: 10.0),
                Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () => Navigator.push(
                            context, routeCustom(page: ForgotPasswordPage())),
                        child: TextCustom(
                            text: 'Forgot Password?',
                            fontSize: 17,
                            color: ColorsCustom.primaryColor))),
                SizedBox(height: 40.0),
                BtnCustom(
                  text: 'Login',
                  fontSize: 21,
                  height: 50,
                  fontWeight: FontWeight.w500,
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      authBloc.add(LoginEvent(
                          _emailController.text, _passwordController.text));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
