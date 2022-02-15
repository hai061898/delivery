// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/user/user_bloc.dart';
import 'package:da/helper/helper.dart';
import 'package:da/screen/admin/home/admin_home.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'components/picture_register.dart';

class AddNewDeliveryPage extends StatefulWidget {
  @override
  _AddNewDeliveryPageState createState() => _AddNewDeliveryPageState();
}

class _AddNewDeliveryPageState extends State<AddNewDeliveryPage> {
  late TextEditingController _nameController;
  late TextEditingController _lastnameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _lastnameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    clearTextEditingController();
    _nameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void clearTextEditingController() {
    _nameController.clear();
    _lastnameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context);
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSuccess(
              context,
              'Delivery Successfully Registered',
              () => Navigator.pushAndRemoveUntil(context,
                  routeCustom(page: AdminHomePage()), (route) => false));
          userBloc.add(OnClearPicturePathEvent());
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextCustom(text: 'Add New Delivery'),
          centerTitle: true,
          leadingWidth: 80,
          leading: TextButton(
            child: TextCustom(
                text: 'Cancel', color: ColorsCustom.primaryColor, fontSize: 17),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  if (_keyForm.currentState!.validate()) {
                    userBloc.add(OnRegisterDeliveryEvent(
                        _nameController.text,
                        _lastnameController.text,
                        _phoneController.text,
                        _emailController.text,
                        _passwordController.text,
                        userBloc.state.pictureProfilePath));
                  }
                },
                child: TextCustom(
                    text: ' Save ', color: ColorsCustom.primaryColor))
          ],
        ),
        body: Form(
          key: _keyForm,
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: [
              SizedBox(height: 20.0),
              Align(alignment: Alignment.center, child: PictureRegistre()),
              SizedBox(height: 20.0),
              TextCustom(text: 'Name'),
              SizedBox(height: 5.0),
              FormFieldCustom(
                hintText: 'name',
                controller: _nameController,
                validator: RequiredValidator(errorText: 'Name is required'),
              ),
              SizedBox(height: 20.0),
              TextCustom(text: 'Lastname'),
              SizedBox(height: 5.0),
              FormFieldCustom(
                controller: _lastnameController,
                hintText: 'lastname',
                validator: RequiredValidator(errorText: 'Lastname is required'),
              ),
              SizedBox(height: 20.0),
              TextCustom(text: 'Phone'),
              SizedBox(height: 5.0),
              FormFieldCustom(
                controller: _phoneController,
                hintText: '---.---.---',
                keyboardType: TextInputType.number,
                validator: RequiredValidator(errorText: 'Lastname is required'),
              ),
              SizedBox(height: 15.0),
              TextCustom(text: 'Email'),
              SizedBox(height: 5.0),
              FormFieldCustom(
                  controller: _emailController,
                  hintText: 'email@frave.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: validatedEmail),
              SizedBox(height: 15.0),
              TextCustom(text: 'Password'),
              SizedBox(height: 5.0),
              FormFieldCustom(
                controller: _passwordController,
                hintText: '********',
                isPassword: true,
                validator: passwordValidator,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
