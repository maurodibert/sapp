import 'package:flutter/material.dart';
import 'package:sapp/core/constants.dart';

class SHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Image.asset(
          'assets/images/serious_iso_logo.png',
          width: 300,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [kBottomMediumShadow],
        borderRadius: BorderRadius.all(
          Radius.circular(kSmallRadius),
        ),
      ),
    );
  }
}
