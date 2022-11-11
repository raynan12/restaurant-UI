

import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  CustomPageRoute({required this.child})
      : super(
        pageBuilder: (context, Animation<double> animation,
          Animation<double> secondaryAnimation) => 
            child,
          transitionDuration: Duration(milliseconds: 500),
      );

  Widget child;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
      }
}