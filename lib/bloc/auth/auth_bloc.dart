// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:da/models/response/response_login.dart';
import 'package:da/controllers/auth_controller.dart';
import 'package:da/controllers/user_controller.dart';
import 'package:da/helper/secure_storage.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  AuthBloc() : super(AuthState()) {

    on<LoginEvent>( _onLogin );
    on<CheckLoginEvent>( _onCheckLogin );
    on<LogOutEvent>( _onLogOut );

  }

  
  Future<void> _onLogin( LoginEvent event, Emitter<AuthState> emit ) async {

    try {

      emit( LoadingAuthState() );

      final data = await authController.loginController(event.email, event.password);

      await Future.delayed(Duration(milliseconds: 850));

      if( data.resp ){

        await secureStorage.deleteSecureStorage();

        await secureStorage.persistenToken( data.token!);

        await userController.updateNotificationToken();

        emit( state.copyWith( user: data.user, rolId: data.user!.rolId.toString() ));

      } else {
        emit( FailureAuthState( data.msg ) );
      }
      
    } catch (e) {
      emit( FailureAuthState(e.toString()) );
    }

  }

  
  Future<void> _onCheckLogin( CheckLoginEvent event, Emitter<AuthState> emit ) async {

    try {

      emit( LoadingAuthState() );

      if( await secureStorage.readToken() != null ) {

        final data = await authController.renewLoginController();

        if( data.resp ){

          await secureStorage.persistenToken( data.token! );

          emit( state.copyWith(user: data.user, rolId: data.user!.rolId.toString() ));
        
        }else{
          emit(LogOutAuthState());
        }

      }else{
        emit( LogOutAuthState());
      }
      
    } catch (e) {
      emit( FailureAuthState(e.toString()) );
    }

  }
  

  Future<void> _onLogOut( LogOutEvent event, Emitter<AuthState> emit ) async {

    await secureStorage.deleteSecureStorage();
    emit( LogOutAuthState() );
    emit( state.copyWith( user: null, rolId: ''));

  }



}