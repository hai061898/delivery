// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:da/controllers/order_controller.dart';
import 'package:da/controllers/user_controller.dart';
import 'package:da/models/product_cart.dart';
import 'package:da/services/push_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersState()) {
    on<OnAddNewOrdersEvent>(_onAddNewOrders);
    on<OnUpdateStatusOrderToDispatchedEvent>(_onUpdateStatusOrderToDispatched);
    on<OnUpdateStatusOrderOnWayEvent>(_onUpdateStatusOrderOnWay);
    on<OnUpdateStatusOrderDeliveredEvent>(_onUpdateStatusOrderDelivered);
  }

  Future<void> _onAddNewOrders(
      OnAddNewOrdersEvent event, Emitter<OrdersState> emit) async {
    try {
      emit(LoadingOrderState());

      await Future.delayed(Duration(milliseconds: 1500));

      final resp = await ordersController.addNewOrders(
          event.uidAddress, event.total, event.typePayment, event.products);

      if (resp.resp) {
        final listTokens = await userController.getAdminsNotificationToken();

        Map<String, dynamic> data = {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK'
        };

        await pushNotification.sendNotificationMultiple(
            listTokens, data, 'Successful purchase', 'You have a new order');

        emit(SuccessOrdersState());
      } else {
        emit(FailureOrdersState(resp.msg));
      }
    } catch (e) {
      emit(FailureOrdersState(e.toString()));
    }
  }

  Future<void> _onUpdateStatusOrderToDispatched(
      OnUpdateStatusOrderToDispatchedEvent event,
      Emitter<OrdersState> emit) async {
    try {
      emit(LoadingOrderState());

      final resp = await ordersController.updateStatusOrderToDispatched(
          event.idOrder, event.idDelivery);

      await Future.delayed(Duration(seconds: 1));

      if (resp.resp) {
        Map<String, dynamic> data = {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK'
        };

        await pushNotification.sendNotification(event.notificationTokenDelivery,
            data, 'Assigned order', 'New order assigned');

        emit(SuccessOrdersState());
      } else {
        emit(FailureOrdersState(resp.msg));
      }
    } catch (e) {
      emit(FailureOrdersState(e.toString()));
    }
  }

  Future<void> _onUpdateStatusOrderOnWay(
      OnUpdateStatusOrderOnWayEvent event, Emitter<OrdersState> emit) async {
    try {
      emit(LoadingOrderState());

      final resp = await ordersController.updateOrderStatusOnWay(
          event.idOrder,
          event.locationDelivery.latitude.toString(),
          event.locationDelivery.longitude.toString());

      await Future.delayed(Duration(seconds: 1));

      if (resp.resp)
        emit(SuccessOrdersState());
      else
        emit(FailureOrdersState(resp.msg));
    } catch (e) {
      emit(FailureOrdersState(e.toString()));
    }
  }

  Future<void> _onUpdateStatusOrderDelivered(
      OnUpdateStatusOrderDeliveredEvent event,
      Emitter<OrdersState> emit) async {
    try {
      emit(LoadingOrderState());

      final resp =
          await ordersController.updateOrderStatusDelivered(event.idOrder);

      await Future.delayed(Duration(milliseconds: 450));

      if (resp.resp)
        emit(SuccessOrdersState());
      else
        emit(FailureOrdersState(resp.msg));
    } catch (e) {
      emit(FailureOrdersState(e.toString()));
    }
  }
}
