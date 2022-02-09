// ignore_for_file: prefer_const_constructors

part of 'helper.dart';
Route navigatorPageFade ( BuildContext context, Widget page ){

  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 450),
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) 
      => FadeTransition(
        child: child,
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOut)
        ),
      )
  );

}