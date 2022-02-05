part of 'user_bloc.dart';

@immutable 
abstract class UserEvent {}


class OnRegisterClientEvent extends UserEvent {
  final String name;
  final String lastname;
  final String phone;
  final String email;
  final String password;
  final String image;

  OnRegisterClientEvent(this.name, this.lastname, this.phone, this.email, this.password, this.image);

}