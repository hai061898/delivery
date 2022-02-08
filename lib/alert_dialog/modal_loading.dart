// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

part of 'alert_dialog.dart';

void modalLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.white54,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      content: Container(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextCustom(
                    text: 'Star ',
                    color: ColorsCustom.primaryColor,
                    fontWeight: FontWeight.w500),
              ],
            ),
            Divider(),
            SizedBox(height: 10.0),
            Row(
              children: [
                CircularProgressIndicator(color: ColorsCustom.primaryColor),
                SizedBox(width: 15.0),
                TextCustom(text: 'Loading...')
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
