// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace

import 'package:da/bloc/payments/payments_bloc.dart';
import 'package:da/models/payment_type.dart';
import 'package:da/themes/color_custom.dart';
import 'package:da/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPaymentMethods extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final paymentBloc = BlocProvider.of<PaymentsBloc>(context);

    return Container(
      padding: EdgeInsets.all(15.0),
      height: 155,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextCustom(text: 'Payment Methods', fontWeight: FontWeight.w500),
              BlocBuilder<PaymentsBloc, PaymentsState>(
                  builder: (_, state) => TextCustom(
                      text: state.typePaymentMethod,
                      color: ColorsCustom.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16)),
            ],
          ),
          Divider(),
          SizedBox(height: 5.0),
          Container(
            height: 80,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: TypePaymentMethod.listTypePayment.length,
              itemBuilder: (_, i) => InkWell(
                onTap: () => paymentBloc.add(OnSelectTypePaymentMethodEvent(
                    TypePaymentMethod.listTypePayment[i].typePayment,
                    TypePaymentMethod.listTypePayment[i].icon,
                    TypePaymentMethod.listTypePayment[i].color)),
                child: BlocBuilder<PaymentsBloc, PaymentsState>(
                  builder: (_, state) => Container(
                    height: 80,
                    width: 80,
                    margin: EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                        color:
                            (TypePaymentMethod.listTypePayment[i].typePayment ==
                                    state.typePaymentMethod)
                                ? Color(0xffF7FAFC)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey[200]!)),
                    child: Icon(TypePaymentMethod.listTypePayment[i].icon,
                        size: 40,
                        color: TypePaymentMethod.listTypePayment[i].color),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
