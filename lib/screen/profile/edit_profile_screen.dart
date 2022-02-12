// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/user/user_bloc.dart';
import 'package:da/helper/helper.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  final _keyForm = GlobalKey<FormState>();

  Future<void> getPersonalInformation() async {
    final userBloc = BlocProvider.of<UserBloc>(context).state.user!;

    _nameController = TextEditingController(text: userBloc.firstName);
    _lastNameController = TextEditingController(text: userBloc.lastName);
    _phoneController = TextEditingController(text: userBloc.phone);
    _emailController = TextEditingController(text: userBloc.email);
  }

  @override
  void initState() {
    super.initState();
    getPersonalInformation();
  }

  @override
  void dispose() {
    _nameController.clear();
    _lastNameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
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
          modalSuccess(context, 'User updated', () => Navigator.pop(context));
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 80,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: [
                SizedBox(width: 10.0),
                Icon(Icons.arrow_back_ios_new_rounded,
                    color: ColorsCustom.primaryColor, size: 17),
                TextCustom(
                    text: 'Back',
                    fontSize: 17,
                    color: ColorsCustom.primaryColor)
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (_keyForm.currentState!.validate()) {
                    userBloc.add(OnEditUserEvent(_nameController.text,
                        _lastNameController.text, _phoneController.text));
                  }
                },
                child: TextCustom(
                    text: 'Update account',
                    fontSize: 16,
                    color: Colors.amber[900]!))
          ],
        ),
        body: SafeArea(
          child: Form(
              key: _keyForm,
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                children: [
                  TextCustom(text: 'Name', color: ColorsCustom.secundaryColor),
                  SizedBox(height: 5.0),
                  FormFieldCustom(
                      controller: _nameController,
                      validator:
                          RequiredValidator(errorText: 'Name is required')),
                  SizedBox(height: 20.0),
                  TextCustom(
                      text: 'Lastname', color: ColorsCustom.secundaryColor),
                  SizedBox(height: 5.0),
                  FormFieldCustom(
                    controller: _lastNameController,
                    hintText: 'lastname',
                    validator:
                        RequiredValidator(errorText: 'Lastname is required'),
                  ),
                  SizedBox(height: 20.0),
                  TextCustom(text: 'Phone', color: ColorsCustom.secundaryColor),
                  SizedBox(height: 5.0),
                  FormFieldCustom(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    hintText: '000-000-000',
                    validator: validatedPhoneForm,
                  ),
                  SizedBox(height: 20.0),
                  TextCustom(
                      text: 'Email Address',
                      color: ColorsCustom.secundaryColor),
                  SizedBox(height: 5.0),
                  FormFieldCustom(controller: _emailController, readOnly: true),
                  SizedBox(height: 20.0),
                ],
              )),
        ),
      ),
    );
  }
}
