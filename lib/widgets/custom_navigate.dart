import 'package:flutter/material.dart';

Route routeTo(page) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 600),
    pageBuilder: (context, animation, secondoryAnimation) => page,
    transitionsBuilder: (context, animation, scondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

void nextScreen(context, page) async {
  Navigator.push(context, routeTo(page));
}

void nextScreenReplacement(context, page) async {
  Navigator.pushReplacement(context, routeTo(page));
}

void backScreen(context) async {
  Navigator.of(context).pop();
}
