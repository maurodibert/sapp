import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapp/core/constants.dart';
import 'package:sapp/core/models/episode_model.dart';
import 'package:sapp/core/models/season_model.dart';
import 'package:sapp/ui/library/s_background.dart';
import 'package:sapp/ui/library/s_header.dart';
import 'package:sapp/ui/library/s_loading.dart';
import 'package:sapp/ui/library/s_rich_text.dart';
import 'package:sapp/ui/screens/show_screen/show_viewmodel.dart';
import 'package:sapp/ui/screens/show_screen/views/episode_view.dart';

class ShowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShowViewModel model = Provider.of<ShowViewModel>(context);
    Size size = MediaQuery.of(context).size;
    bool isReady = model.show != null &&
        model.seasons != null &&
        model.episodes != null &&
        model.show.id == model.showId;

    return SafeArea(
      child: Scaffold(
        body: isReady ? buildBody(context, model, size) : SeriousLoading(),
      ),
    );
  }

  Widget buildBody(BuildContext context, ShowViewModel model, Size size) {
    return Hero(
      tag: 'tag - ${model.show.id}',
      // added to prevent overflow in content
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
            Align(
              alignment: model.isDetailsVisible
                  ? Alignment.bottomCenter
                  : Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: GestureDetector(
                  onTap: () {
                    model.clean();
                    return Navigator.pushNamed(context, '/');
                  },
                  child: SeriousHeader(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMainTexts(ShowViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                  k8Vertical,
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
                              k8Horizontal,
                              Text(episode.name,
                                  style: kP.copyWith(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                  k24Vertical,
                ],
              ),
          ],
        ),
      );
    return Container();
  }
}
