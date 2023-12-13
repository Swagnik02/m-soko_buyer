import 'package:flutter/material.dart';

Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)
    smoothTransition() {
  return (context, animation, secondaryAnimation, child) {
    const begin = Offset(0.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  };
}
