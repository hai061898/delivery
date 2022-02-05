// ignore_for_file: empty_constructor_bodies, curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:da/controllers/user_controller.dart';
import 'package:da/models/response/response_login.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserBloc> {
  UserBloc() : super(UserState()) {
    on<OnRegisterClientEvent>( _onRegisterClient );
  }
  Future<void> _onRegisterClien(
      OnRegisterClientEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());
      final data = await userController.registerClient(
          event.name,
          event.lastname,
          event.phone,
          event.image,
          event.email,
          event.password,
          nToken!);
      if (data.resp)
        emit(SuccessUserState());
      else
        emit(FailureUserState(data.msg));
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }
}
