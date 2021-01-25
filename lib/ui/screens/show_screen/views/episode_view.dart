import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapp/core/constants.dart';
import 'package:sapp/ui/library/s_rich_text.dart';
import 'package:sapp/ui/screens/show_screen/show_viewmodel.dart';

class EpisodeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShowViewModel model = Provider.of<ShowViewModel>(context);
    Size size = MediaQuery.of(context).size;

    if (model.episode != null) {
      return Positioned(
        // hiding details view
        left: model.isDetailsVisible ? 20 : -size.width,
        top: model.isDetailsVisible ? 0 : -size.height,
        child: Container(
          width: size.width - 40,
          height: size.height,
          // height: size.height,
          color: kYellow.withOpacity(0.95),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  k32Vertical,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            model.episode.name,
                            style: kP.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          child: Stack(children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                Icons.clear,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: IconButton(
                                padding: EdgeInsets.all(2),
                                icon: Icon(Icons.clear),
                                color: Colors.black,
                                onPressed: () => model.toggleDetails(),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Text(
                          'S' + model.episode.season.toString().toUpperCase(),
                          style: kP.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'N' + model.episode.number.toString().toUpperCase(),
                          style: kP.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  k8Vertical,
                  if (model.episode.image != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: size.width - 48,
                        height: 200,
                        decoration: BoxDecoration(
                          color: kYellow,
                          borderRadius: BorderRadius.all(
                            Radius.circular(kSmallRadius),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(model.episode.image),
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.8),
                                BlendMode.dstATop),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  SeriousRichText(
                      data: model.episode.summary, color: Colors.black),
                  k32Vertical,
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
