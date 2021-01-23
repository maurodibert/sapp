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
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          body: model.show != null ? buildBody(model, size) : LoadingWidget()),
    );
  }

  Widget buildDetails(ShowViewModel model, Size size) {
    // TODO: Unify in components
    Widget htmlSummary = Html(
      data: model.episode.summary,
      style: {
        "p": Style(
            color: Colors.black,
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
            alignment: Alignment.centerLeft),
      },
    );

    return model.episode != null
        ? Positioned(
            // hiding details view
            left: model.isDetailsVisible ? 20 : -size.width,
            top: model.isDetailsVisible ? 0 : -size.width,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: size.width - 40,
              height: size.height,
              color: Colors.yellow,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 48,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text(
                              model.episode.name,
                              style: kH3.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              'S' +
                                  model.episode.season.toString().toUpperCase(),
                              style: kP.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                                'N' +
                                    model.episode.number
                                        .toString()
                                        .toUpperCase(),
                                style: kP.copyWith(color: Colors.black)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: size.width - 48,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
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
                      SizedBox(
                        height: 12,
                      ),
                      htmlSummary,
                      SizedBox(
                        height: 48,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container();
  }

  Widget buildSeasons(ShowViewModel model, Size size) {
    if (model.seasons != null && model.seasons.length > 0)
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 24, 8, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (SeasonModel season in model.seasons)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    season.number.toString(),
                    style: kP.copyWith(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  for (EpisodeModel episode in model.episodes)
                    if (episode.season == season.number)
                      MaterialButton(
                        onPressed: () => model.toggleDetails(episode.number),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                episode.number.toString(),
                                style: kP.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(episode.name,
                                  style: kP.copyWith(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
          ],
        ),
      );
    return Container();
  }

  Widget buildBody(ShowViewModel model, Size size) {
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
            width: size.width,
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
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24,
                  ),
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
                          Text(
                              model.show.schedule['time'] == ''
                                  ? '(Hour not available)'
                                  : model.show.schedule['time'],
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

                  buildSeasons(model, size),
                ],
              ),
            ),
          ),
          buildDetails(model, size),
        ],
      ),
    );
  }
}
