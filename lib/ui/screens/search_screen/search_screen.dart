import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapp/core/constants.dart';
import 'package:sapp/core/models/show_model.dart';
import 'package:sapp/ui/library/s_card.dart';
import 'package:sapp/ui/library/s_header.dart';
import 'package:sapp/ui/screens/search_screen/search_viewmodel.dart';
import 'package:sapp/ui/screens/show_screen/show_screen.dart';
import 'package:sapp/ui/screens/show_screen/show_viewmodel.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SearchViewModel model = Provider.of<SearchViewModel>(context);
    ShowViewModel showModel = Provider.of<ShowViewModel>(context);

    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildForm(model),
                if (model.shows != null && model.shows.length > 0) k24Vertical,
                if (model.shows != null && model.shows.length > 0)
                  buildResult(context, model, showModel),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SeriousHeader(),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildForm(SearchViewModel model) {
    return Container(
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextFormField(
                  controller: model.textFieldController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      hintText: "Search a show",
                      hintStyle: TextStyle(color: Colors.white),
                      suffixIcon: Hero(
                        tag: kHeroSearchTag,
                        child: Material(
                          type: MaterialType.transparency,
                          child: IconButton(
                            icon: Icon(Icons.search, color: Colors.white),
                            onPressed: () async {
                              await model
                                  .queryShows(model.textFieldController.text);
                              model.textFieldController.clear();
                            },
                          ),
                        ),
                      )),
                  style: kP.copyWith(
                      fontSize: 24,
                      color: kOrange,
                      fontStyle: FontStyle.normal),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You have to enter a show';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) async {
                    await model.queryShows(model.textFieldController.text);
                    model.textFieldController.clear();
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget buildResult(
      BuildContext context, SearchViewModel model, ShowViewModel showModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (ShowModel show in model.shows)
            if (show.image != null && show.name != null)
              SeriousCard(
                height: 320,
                width: 120,
                onTap: () async {
                  // important to ensure Hero animation
                  // not showing previous fetched show
                  showModel.setShowId(show.id);
                  await showModel.fetchShow(show.id);
                  showModel.fetchEpisodes(show.id);
                  showModel.fetchSeasons(show.id);
                  // used for manage transition's duration
                  await Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 800),
                        pageBuilder: (_, __, ___) => ShowScreen()),
                  );
                  model.cleanSearch();
                },
                tag: 'tag - ${show.id}',
                image: show.image,
                name: show.name,
              ),
        ],
      ),
    );
  }
}
