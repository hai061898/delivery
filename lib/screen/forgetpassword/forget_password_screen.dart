// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:da/helper/helper.dart';
import 'package:da/screen/checkmail/checkmail_screen.dart';
import 'package:da/screen/login/login_screen.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}


class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  late TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.clear();
    _emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextCustom(text: 'Reset Password', fontSize: 21, fontWeight: FontWeight.w500 ),
        centerTitle: true,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pushReplacement(context, routeCustom(page: LoginPage())),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: ColorsCustom.primaryColor ),
              TextCustom(text: 'Back', color: ColorsCustom.primaryColor, fontSize: 18)
            ],
          ),
        ),
        actions: [
          Icon(Icons.help_outline_outlined)
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: [
              TextCustom(
                text: 'Enter the email associated with your account and well send an email with instruccions to reset your password.', 
                maxLine: 4, 
                color: Color(0xff5B6589),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 30.0),
              TextCustom(text: 'Email Address'),
              SizedBox(height: 5.0),
              FormFieldCustom(
                controller: _emailController,
                hintText: 'example@frave.com',
                validator: validatedEmail,
              ),
              SizedBox(height: 30.0),
              BtnCustom(
                text: 'Send Instructions',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                onPressed: (){
                    // if( _formKey.currentState!.validate() ){}
                    Navigator.push(context, routeCustom(page: CheckEmailPage()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

}