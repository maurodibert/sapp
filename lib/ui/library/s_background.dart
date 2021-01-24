import 'package:flutter/material.dart';

class SeriousBackground extends StatelessWidget {
  final double width;
  final Color color;
  final String image;
  SeriousBackground({@required this.width, @required this.image, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: color ?? Colors.black87,
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2), BlendMode.dstATop),
          fit: BoxFit.cover,
          image: NetworkImage(image),
        ),
      ),
    );
  }
}
