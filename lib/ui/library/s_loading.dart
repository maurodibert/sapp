//
// COMPONENTS
import 'package:flutter/material.dart';
import 'package:sapp/core/constants.dart';

class SeriousLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kYellow)),
      ),
    );
  }
}
