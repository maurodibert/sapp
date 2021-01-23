import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';
import 'package:sapp/core/constants.dart';
import 'package:sapp/core/models/episode_model.dart';
import 'package:sapp/core/models/season_model.dart';
import 'package:sapp/main/library/ass_loading.dart';
import 'package:sapp/main/screens/show_screen/show_viewmodel.dart';
import 'package:flutter_html/flutter_html.dart';

class ShowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShowViewModel model = Provider.of<ShowViewModel>(context);
    return SafeArea(
      child: Scaffold(
          body: model.show != null ? buildBody(model) : LoadingWidget()),
    );
  }

  Widget buildBody(ShowViewModel model) {
    Widget htmlSummary = Html(
      data: model.show.summary,
      style: {
        "p": Style(
            color: Colors.white,
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
            alignment: Alignment.centerLeft),
      },
    );

    return Hero(
      tag: 'tag - ${model.show.id}',
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            // background
            decoration: BoxDecoration(
              color: Colors.black87,
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
                fit: BoxFit.cover,
                image: NetworkImage(model.show.image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(model.show.name,
                        style: kH3.copyWith(color: Colors.yellow)),
                  ),
                  // TODO: find how to get rid of internal padding and re do section extracting components
                  htmlSummary,

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(model.show.schedule['time'],
                              style: kP.copyWith(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold)),
                          if (model.show.schedule['days'] != null)
                            for (String day in model.show.schedule['days'])
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(day,
                                    style: kP.copyWith(
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold)),
                              )
                        ],
                      ),
                    ),
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if (model.show.genres.length > 0)
                          for (String genre in model.show.genres)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                genre,
                                style: kP.copyWith(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                      ],
                    ),
                  ),

                  if (model.seasons != null && model.seasons.length > 0)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 24, 8, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (SeasonModel season in model.seasons)
                            Text(
                              season.number.toString(),
                              style: kP.copyWith(
                                color: Colors.yellow,
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
