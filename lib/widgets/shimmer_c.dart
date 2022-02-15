// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

part of 'widgets.dart';

class ShimmerCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Color(0xFFF3F3F3),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.grey[200]),
      ),
    );
  }
}
