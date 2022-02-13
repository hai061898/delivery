// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

part of 'alert_dialog.dart';

void modalActiveOrInactiveProduct(BuildContext context, int status,
    String nameProduct, int idProduct, String picture) {
  final productBloc = BlocProvider.of<ProductsBloc>(context);

  showDialog(
    context: context,
    barrierColor: Colors.white54,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      content: Container(
        height: 155,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextCustom(
                        text: 'Star ',
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
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          scale: 7,
                          image: NetworkImage(URLS.BASE_URL + picture))),
                ),
                SizedBox(width: 10.0),
                TextCustom(
                  text: nameProduct,
                  maxLine: 2,
                ),
              ],
            ),
            SizedBox(height: 20.0),
            BtnCustom(
              height: 45,
              text: (status == 1) ? 'SOLD OUT' : 'IN STOCK',
              color: (status == 1) ? Colors.red : Colors.green,
              onPressed: () {
                productBloc.add(OnUpdateStatusProductEvent(
                    idProduct.toString(), (status == 1) ? '0' : '1'));
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    ),
  );
}
