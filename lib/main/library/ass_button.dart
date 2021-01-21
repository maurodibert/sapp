import 'package:flutter/material.dart';
import 'package:sapp/core/constants.dart';

class AssButton extends StatelessWidget {
  final bool isPrimary;
  final double width;
  final String text;
  final Function onTap;
  final BorderRadius radius;

  const AssButton({
    Key key,
    @required this.isPrimary,
    @required this.text,
    @required this.onTap,
    this.width,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      decoration: BoxDecoration(
          color: isPrimary
              ? Colors.red.withOpacity(0.9)
              : Colors.red.withOpacity(0.1),
          borderRadius:
              radius ?? BorderRadius.all(Radius.circular(kSmallRadius))),
      child: InkWell(
        splashColor: isPrimary ? Colors.yellow : Colors.yellow,
        borderRadius: BorderRadius.all(Radius.circular(kSmallRadius)),
        onTap: () => onTap(),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
                child: Text(text,
                    style: kH3.copyWith(
                        color: isPrimary ? Colors.white : Colors.red,
                        fontSize: 16)))),
      ),
    );
  }
}
