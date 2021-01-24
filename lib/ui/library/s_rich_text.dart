import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class SeriousRichText extends StatelessWidget {
  final String data;
  final Color color;
  SeriousRichText({@required this.data, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      style: {
        "p": Style(
            color: color,
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
            alignment: Alignment.centerLeft),
      },
    );
  }
}
