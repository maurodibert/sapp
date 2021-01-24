import 'package:flutter/material.dart';
import 'package:sapp/core/constants.dart';

class SeriousCard extends StatelessWidget {
  final Function onTap;
  final String tag;
  final String image;
  final String name;
  final double width;
  final double height;

  const SeriousCard({
    Key key,
    @required this.onTap,
    @required this.tag,
    @required this.image,
    @required this.name,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: tag,
        // added to prevent overflow in content
        child: Material(
            type: MaterialType.transparency,
            child: image == null
                ? Container(
                    color: Colors.black,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Not available',
                            style: kP.copyWith(color: Colors.white)),
                      ),
                    ),
                  )
                : Container(
                    width: width ?? null,
                    height: height ?? null,
                    decoration: image != null
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.cover,
                            ),
                          )
                        : BoxDecoration(color: Colors.red),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          color: Colors.black,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              name,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }
}
