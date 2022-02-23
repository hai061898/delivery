// ignore_for_file: prefer_const_constructors

part of 'helper.dart';

class BounceInDown extends StatefulWidget {
  final Widget child;

  const BounceInDown({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _BounceInDownState createState() => _BounceInDownState();
}

class _BounceInDownState extends State<BounceInDown>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _animation = Tween<double>(begin: 120 * -1, end: 0).animate(
        CurvedAnimation(parent: _controller!, curve: Curves.bounceOut));

    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, _animation.value),
        child: widget.child,
      ),
    );
  }
}
