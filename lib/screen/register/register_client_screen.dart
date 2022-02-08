// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/user/user_bloc.dart';
import 'package:da/helper/helper.dart';
import 'package:da/screen/register/components/picture_register.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterClientPage extends StatefulWidget {
  @override
  _RegisterClientPageState createState() => _RegisterClientPageState();
}

class _RegisterClientPageState extends State<RegisterClientPage> {

  late TextEditingController _nameController;
  late TextEditingController _lastnameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController = TextEditingController();
    _lastnameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    clearForm();
    _nameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  void clearForm(){
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
        
        if( state is LoadingUserState ){

          modalLoading(context);

        } else if ( state is SuccessUserState ){

          Navigator.pop(context);
          modalSuccess(context, 'Client Registered successfully', () => Navigator.pushReplacement(context, routeFrave(page: LoginPage())));
        
        } else if ( state is FailureUserState ){

          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }

      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
              clearForm();
            } ,
            child: Container(
              alignment: Alignment.center,
              child: TextCustom(text: 'Cancel', color: ColorsCustom.primaryColor, fontSize: 16 )
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 70,
          title: TextCustom(text: 'Add new Account',),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
              
                if( _keyForm.currentState!.validate()){

                  userBloc.add( OnRegisterClientEvent(
                    _nameController.text,
                    _lastnameController.text,
                    _phoneController.text,
                    _emailController.text,
                    _passwordController.text,
                     userBloc.state.pictureProfilePath
                  ));
                }
              },
              child: Container(
                margin: EdgeInsets.only(right: 10.0),
                alignment: Alignment.center,
                child: TextCustom(text: 'Save', color: ColorsCustom.primaryColor, fontSize: 16 ),
              ),
            ),
          ],
        ),
        body: Form(
          key: _keyForm,
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: [
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.center,
                child: PictureRegistre()
              ),
              SizedBox(height: 40.0),
              TextCustom(text: 'Name'),
              SizedBox(height: 5.0),
              FormFieldFrave(
                controller: _nameController,
                hintText: 'Enter your name',
                validator: RequiredValidator(errorText: 'Name is required'),
              ),
              SizedBox(height: 15.0),
              TextCustom(text: 'Lastname'),
              SizedBox(height: 5.0),
              FormFieldFrave(
                controller: _lastnameController,
                hintText: 'Enter your lastname',
                validator: RequiredValidator(errorText: 'Lastname is required'),
              ),
              SizedBox(height: 15.0),
              TextCustom(text: 'Phone'),
              SizedBox(height: 5.0),
              FormFieldFrave(
                controller: _phoneController,
                hintText: '000-000-000',
                keyboardType: TextInputType.number,
                validator: validatedPhoneForm,
              ),
              SizedBox(height: 15.0),
              TextCustom(text: 'Email'),
              SizedBox(height: 5.0),
              FormFieldFrave(
                controller: _emailController,
                hintText: 'email@frave.com',
                keyboardType: TextInputType.emailAddress,
                validator: validatedEmail
              ),
              SizedBox(height: 15.0),
              TextCustom(text: 'Password'),
              SizedBox(height: 5.0),
              FormFieldFrave(
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
