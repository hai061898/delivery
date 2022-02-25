// ignore_for_file: unused_element, prefer_const_constructors

import 'package:da/bloc/auth/auth_bloc.dart';
import 'package:da/bloc/cart/cart_bloc.dart';
import 'package:da/bloc/delivery/delivery_bloc.dart';
import 'package:da/bloc/general/general_bloc.dart';
import 'package:da/bloc/mapclient/map_client_bloc.dart';
import 'package:da/bloc/mapdelivery/mapdelivery_bloc.dart';
import 'package:da/bloc/mylocation/mylocationmap_bloc.dart';
import 'package:da/bloc/order/order_bloc.dart';
import 'package:da/bloc/payments/payments_bloc.dart';
import 'package:da/bloc/product/products_bloc.dart';
import 'package:da/bloc/user/user_bloc.dart';
import 'package:da/screen/intro/check_login.dart';
import 'package:da/services/push_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

PushNotification pushNotification = PushNotification();

Future<void> _firebaseMessagingBackground(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackground);
  pushNotification.initNotifacion();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    pushNotification.onMessagingListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(CheckLoginEvent())),
        BlocProvider(create: (context) => GeneralBloc()),
        BlocProvider(create: (context) => ProductsBloc()),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => MylocationmapBloc()),
        BlocProvider(create: (context) => PaymentsBloc()),
        BlocProvider(create: (context) => OrdersBloc()),
        BlocProvider(create: (context) => DeliveryBloc()),
        BlocProvider(create: (context) => MapdeliveryBloc()),
        BlocProvider(create: (context) => MapclientBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Delivery',
        home: CheckingLoginPage(),
      ),
    );
  }
}
