import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delivery_state.dart';
part 'delivery_event.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  DeliveryBloc() : super(DeliveryState()) {
    on<OnSelectDeliveryEvent>(_onSelectDelivery);
    on<OnUnSelectDeliveryEvent>(_onUnSelectDelivery);
  }

  Future<void> _onSelectDelivery(
      OnSelectDeliveryEvent event, Emitter<DeliveryState> emit) async {
    emit(state.copyWith(
        idDelivery: event.idDelivery,
        notificationTokenDelivery: event.notificationToken));
  }

  Future<void> _onUnSelectDelivery(
      OnUnSelectDeliveryEvent event, Emitter<DeliveryState> emit) async {
    emit(state.copyWith(idDelivery: '0', notificationTokenDelivery: ''));
  }
}
