// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:da/controllers/order_controller.dart';
import 'package:da/helper/helper.dart';
import 'package:da/models/pay_type.dart';
import 'package:da/models/response/order_response.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'component/list_order.dart';

class OrdersAdminPage extends StatelessWidget {

  @override
  Widget build(BuildContext context){

    return DefaultTabController(
      length: payType.length, 
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextCustom(text: 'List Orders', fontSize: 20),
          centerTitle: true,
          leadingWidth: 80,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios_new_outlined, color: ColorsCustom.primaryColor, size: 17),
                TextCustom(text: 'Back', color: ColorsCustom.primaryColor, fontSize: 17)
              ],
            ),
          ),
          bottom: TabBar(
            indicatorWeight: 2,
            labelColor: ColorsCustom.primaryColor,
            unselectedLabelColor: Colors.grey,
            indicator: IndicatorTabBarCustom(),
            isScrollable: true,
            tabs: List<Widget>.generate(payType.length, (i) 
              => Tab(
                  child: Text(payType[i], style: GoogleFonts.getFont('Roboto', fontSize: 17))
                )
            )
          ),
        ),
        body: TabBarView(
          children: payType.map((e) 
            => FutureBuilder<List<OrdersResponse>?>(
                future: ordersController.getOrdersByStatus( e ),
                builder: (context, snapshot) 
                  => ( !snapshot.hasData )
                      ? Column(
                          children: [
                            ShimmerCustom(),
                            SizedBox(height: 10),
                            ShimmerCustom(),
                            SizedBox(height: 10),
                            ShimmerCustom(),
                          ],
                        )
                      :  ListOrders(listOrders: snapshot.data!)
            )
          ).toList(),
        ),
      )
    );
  }   
}
