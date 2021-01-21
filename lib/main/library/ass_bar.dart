import 'package:flutter/material.dart';
import 'package:sapp/core/constants.dart';

class AssBar extends StatelessWidget {
  final Widget child;
  final double width;
  AssBar({@required this.child, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [kBottomMediumShadow],
        borderRadius: BorderRadius.all(
          Radius.circular(kSmallRadius),
        ),
      ),
      child: Center(child: child),
    );
  }
}
