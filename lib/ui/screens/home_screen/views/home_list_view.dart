import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapp/core/constants.dart';
import 'package:sapp/core/models/show_model.dart';
import 'package:sapp/ui/library/s_bar.dart';
import 'package:sapp/ui/library/s_card.dart';
import 'package:sapp/ui/library/s_header.dart';
import 'package:sapp/ui/screens/home_screen/home_viewmodel.dart';
import 'package:sapp/ui/screens/search_screen/search_screen.dart';
import 'package:sapp/ui/screens/search_screen/search_viewmodel.dart';
import 'package:sapp/ui/screens/show_screen/show_screen.dart';
import 'package:sapp/ui/screens/show_screen/show_viewmodel.dart';

class HomeListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeViewModel model = Provider.of<HomeViewModel>(context);
    ShowViewModel showModel = Provider.of<ShowViewModel>(context);
    SearchViewModel searchModel = Provider.of<SearchViewModel>(context);

    return Stack(
      children: [
        buildBody(context, model, showModel),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: SHeader(),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: buildBottomNavBar(context, model, searchModel),
          ),
        ),
      ],
    );
  }
}

Widget buildBody(
    BuildContext context, HomeViewModel model, ShowViewModel showModel) {
  return GridView.count(
    controller: model.listViewScroll,
    mainAxisSpacing: 0,
    crossAxisSpacing: 0,
    crossAxisCount: 2,
    children: [
      for (ShowModel show in model.shows)
        if (show.image != null && show.name != null)
          SeriousCard(
            onTap: () async {
              // important to ensure Hero animation
              // not showing previous fetched show
              showModel.setShowId(show.id);
              await showModel.fetchShow(show.id);
              showModel.fetchEpisodes(show.id);
              showModel.fetchSeasons(show.id);
              // used for manage transition's duration
              Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 800),
                    pageBuilder: (_, __, ___) => ShowScreen()),
              );
            },
            tag: 'tag - ${show.id}',
            image: show.image,
            name: show.name,
          ),
    ],
  );
}

Widget buildBottomNavBar(
  BuildContext context,
  HomeViewModel model,
  SearchViewModel searchModel,
) {
  return SeriousBar(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => model.back(),
          ),
        ),
        Expanded(
          child: Container(
            child: Hero(
              tag: kHeroSearchTag,
              child: Material(
                type: MaterialType.transparency,
                child: IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.black,
                    onPressed: () async {
                      searchModel.cleanSearch();
                      return Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 800),
                            pageBuilder: (_, __, ___) => SearchScreen()),
                      );
                    }),
              ),
            ),
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(Icons.arrow_forward),
            color: Colors.black,
            onPressed: () => model.advance(),
          ),
        ),
      ],
    ),
  );
}
