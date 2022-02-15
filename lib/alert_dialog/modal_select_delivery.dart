// ignore_for_file: prefer_const_constructors

part of 'alert_dialog.dart';

void modalSelectDelivery(BuildContext context, String idOrder) {
  final orderBloc = BlocProvider.of<OrdersBloc>(context);

  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.white60,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      content: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextCustom(
                        text: 'Star',
                        color: ColorsCustom.primaryColor,
                        fontWeight: FontWeight.w500),
                    TextCustom(text: 'Food', fontWeight: FontWeight.w500),
                  ],
                ),
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close))
              ],
            ),
            Divider(),
            SizedBox(height: 10.0),
            TextCustom(text: 'Select delivery man'),
            SizedBox(height: 10.0),
            Expanded(
              child: FutureBuilder<List<Delivery>?>(
                  future: deliveryController.getAlldelivery(),
                  builder: (context, snapshot) => (!snapshot.hasData)
                      ? Column(
                          children: [
                            ShimmerCustom(),
                            SizedBox(height: 10.0),
                            ShimmerCustom(),
                            SizedBox(height: 10.0),
                            ShimmerCustom(),
                          ],
                        )
                      : _ListDeliveryModal(listDelivery: snapshot.data!)),
            ),
            BlocBuilder<DeliveryBloc, DeliveryState>(
              builder: (context, state) => BtnCustom(
                text: 'SEND ORDER',
                fontWeight: FontWeight.w500,
                onPressed: () {
                  if (state.idDelivery != '0') {
                    orderBloc.add(OnUpdateStatusOrderToDispatchedEvent(idOrder,
                        state.idDelivery, state.notificationTokenDelivery));
                    Navigator.pop(context);
                  }
                },
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class _ListDeliveryModal extends StatelessWidget {
  final List<Delivery> listDelivery;

  const _ListDeliveryModal({required this.listDelivery});

  @override
  Widget build(BuildContext context) {
    final deliveryBloc = BlocProvider.of<DeliveryBloc>(context);

    return ListView.builder(
      itemCount: listDelivery.length,
      itemBuilder: (context, i) => InkWell(
        onTap: () => deliveryBloc.add(OnSelectDeliveryEvent(
            listDelivery[i].personId.toString(),
            listDelivery[i].notificationToken.toString())),
        splashColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.only(bottom: 10.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    image: DecorationImage(
                        image: NetworkImage(
                            URLS.BASE_URL + listDelivery[i].image!))),
              ),
              SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(listDelivery[i].nameDelivery!,
                      maxLines: 1, style: GoogleFonts.getFont('Inter')),
                  SizedBox(height: 5.0),
                  TextCustom(text: listDelivery[i].phone!, color: Colors.grey),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: BlocBuilder<DeliveryBloc, DeliveryState>(
                      builder: (_, state) => (state.idDelivery ==
                              listDelivery[i].personId.toString())
                          ? Icon(Icons.check_outlined,
                              size: 30, color: Colors.green)
                          : Container()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
