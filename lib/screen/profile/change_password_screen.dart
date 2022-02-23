// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, body_might_complete_normally_nullable

import 'package:da/alert_dialog/alert_dialog.dart';
import 'package:da/bloc/general/general_bloc.dart';
import 'package:da/bloc/user/user_bloc.dart';
import 'package:da/helper/helper.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/form_field_password.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _repeatPasswordController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    clearTextEditingController();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  void clearTextEditingController() {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _repeatPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final generalBloc = BlocProvider.of<GeneralBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context);
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSuccess(
              context, 'Password changed', () => Navigator.pop(context));
          clearTextEditingController();
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
          title: TextCustom(text: 'Change Password'),
          centerTitle: true,
          leadingWidth: 80,
          leading: TextButton(
              onPressed: () => Navigator.pop(context),
              child: TextCustom(
                  text: 'Cancel',
                  fontSize: 17,
                  color: ColorsCustom.primaryColor)),
          actions: [
            TextButton(
                onPressed: () {
                  if (_keyForm.currentState!.validate()) {
                    userBloc.add(OnChangePasswordEvent(
                        _currentPasswordController.text,
                        _newPasswordController.text));
                  }
                },
                child: TextCustom(
                    text: 'Save',
                    fontSize: 16,
                    color: ColorsCustom.primaryColor))
          ],
        ),
        body: SafeArea(
          child: Form(
            key: _keyForm,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: BlocBuilder<GeneralBloc, GeneralState>(
                builder: (context, state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    TextCustom(text: 'Current Password'),
                    SizedBox(height: 5.0),
                    FormFieldCustomPassword(
                      controller: _currentPasswordController,
                      isPassword: state.isShowPassword,
                      suffixIcon: IconButton(
                          splashRadius: 20,
                          icon: state.isShowPassword
                              ? Icon(Icons.remove_red_eye_outlined)
                              : Icon(Icons.visibility_off_rounded),
                          onPressed: () {
                            bool isShowPassword =
                                !generalBloc.state.isShowPassword;
                            generalBloc
                                .add(OnShowOrHidePasswordEvent(isShowPassword));
                          }),
                      validator: passwordValidator,
                    ),
                    SizedBox(height: 20.0),
                    TextCustom(text: 'New Password'),
                    SizedBox(height: 5.0),
                    FormFieldCustomPassword(
                      controller: _newPasswordController,
                      isPassword: state.isNewPassword,
                      suffixIcon: IconButton(
                          splashRadius: 20,
                          icon: state.isNewPassword
                              ? Icon(Icons.remove_red_eye_outlined)
                              : Icon(Icons.visibility_off_rounded),
                          onPressed: () {
                            bool isShowPassword =
                                !generalBloc.state.isNewPassword;
                            generalBloc.add(
                                OnShowOrHideNewPasswordEvent(isShowPassword));
                          }),
                      validator: passwordValidator,
                    ),
                    SizedBox(height: 20.0),
                    TextCustom(text: 'Repeat Password'),
                    SizedBox(height: 5.0),
                    FormFieldCustomPassword(
                      controller: _repeatPasswordController,
                      isPassword: state.isRepeatpassword,
                      suffixIcon: IconButton(
                          splashRadius: 20,
                          icon: state.isRepeatpassword
                              ? Icon(Icons.remove_red_eye_outlined)
                              : Icon(Icons.visibility_off_rounded),
                          onPressed: () {
                            bool isShowPassword =
                                !generalBloc.state.isRepeatpassword;
                            generalBloc.add(OnShowOrHideRepeatPasswordEvent(
                                isShowPassword));
                          }),
                      validator: (val) {
                        if (val != _newPasswordController.text) {
                          return 'Passwords do not match';
                        } else if (val!.isEmpty) {
                          return 'Repeat password is required';
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
