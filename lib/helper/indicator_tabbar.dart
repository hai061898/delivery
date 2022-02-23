// ignore_for_file: prefer_const_constructors

part of 'helper.dart';

class IndicatorTabBarCustom extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      PainterIndicator(this, onChanged);
}

class PainterIndicator extends BoxPainter {
  final IndicatorTabBarCustom decoration;

  PainterIndicator(this.decoration, VoidCallback? onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Rect rect;

    rect = Offset(offset.dx + 6, (configuration.size!.height - 3)) &
        Size(configuration.size!.width - 12, 3);

    final paint = Paint()
      ..color = ColorsCustom.primaryColor
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
        RRect.fromRectAndCorners(rect,
            topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
        paint);
  }
}
