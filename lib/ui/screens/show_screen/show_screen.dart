import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapp/core/constants.dart';
import 'package:sapp/core/models/episode_model.dart';
import 'package:sapp/core/models/season_model.dart';
import 'package:sapp/ui/library/s_background.dart';
import 'package:sapp/ui/library/s_rich_text.dart';
import 'package:sapp/ui/screens/show_screen/show_viewmodel.dart';
import 'package:sapp/ui/screens/show_screen/views/episode_view.dart';

class ShowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShowViewModel model = Provider.of<ShowViewModel>(context);
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: buildBody(model, size),
      ),
    );
  }

  Widget buildBody(ShowViewModel model, Size size) {
    return Hero(
      tag: 'tag - ${model.show.id}',
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            SeriousBackground(
              width: size.width,
              image: model.show.image,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    k24Vertical,
                    buildMainTexts(model),
                    buildSeasons(model, size),
                  ],
                ),
              ),
            ),
            EpisodeView(),
          ],
        ),
      ),
    );
  }

  Widget buildMainTexts(ShowViewModel model) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Text(model.show.name, style: kH3.copyWith(color: Colors.yellow)),
        ),
        SeriousRichText(data: model.show.summary, color: Colors.white),
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
                        color: Colors.yellow, fontWeight: FontWeight.bold)),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
      ],
    );
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
}
