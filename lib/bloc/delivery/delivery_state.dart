// ignore_for_file: prefer_const_constructors_in_immutables

part of 'delivery_bloc.dart';

@immutable
class DeliveryState {
  final String idDelivery;
  final String notificationTokenDelivery;

  DeliveryState({this.idDelivery = '0', this.notificationTokenDelivery = ''});

  DeliveryState copyWith(
          {String? idDelivery, String? notificationTokenDelivery}) =>
      DeliveryState(
          idDelivery: idDelivery ?? this.idDelivery,
          notificationTokenDelivery:
              notificationTokenDelivery ?? this.notificationTokenDelivery);
}
