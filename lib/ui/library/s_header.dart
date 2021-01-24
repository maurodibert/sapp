import 'package:flutter/material.dart';

class SeriousHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Image.asset(
          'assets/images/serious_logo_white_contour.png',
          width: 60,
        ),
      ),
    );
  }
}
