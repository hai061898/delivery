part of 'user_bloc.dart';

@immutable 
class  UserState {
  // final User? user;
}

class LoadingUserState extends UserState {}

class SuccessUserState extends UserState {}

class FailureUserState extends UserState {
  final String error;

  FailureUserState(this.error);
}