// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

part of 'alert_dialog.dart';

void modalInfo(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: Container(
        height: 250,
        child: Column(
          children: [
            Row(
              children: [
                TextCustom(
                    text: 'Star ',
                    color: Colors.amber,
                    fontWeight: FontWeight.w500),
                TextCustom(text: 'Food', fontWeight: FontWeight.w500),
              ],
            ),
            Divider(),
            SizedBox(height: 10.0),
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      colors: [Colors.white, Colors.amber])),
              child: Container(
                margin: EdgeInsets.all(10.0),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
                child: Icon(Icons.priority_high_rounded,
                    color: Colors.white, size: 38),
              ),
            ),
            SizedBox(height: 35.0),
            TextCustom(text: text, fontSize: 17, fontWeight: FontWeight.w400),
            SizedBox(height: 20.0),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                alignment: Alignment.center,
                height: 35,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(5.0)),
                child:
                    TextCustom(text: 'Done', color: Colors.white, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
