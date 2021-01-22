import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapp/core/constants.dart';
import 'package:sapp/core/models/show_model.dart';
import 'package:sapp/main/library/ass_bar.dart';
import 'package:sapp/main/screens/home_screen/home_viewmodel.dart';
import 'package:sapp/main/screens/show_screen/show_viewmodel.dart';

class HomeScreenListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeViewModel model = Provider.of<HomeViewModel>(context);
    ShowViewModel showModel = Provider.of<ShowViewModel>(context);

    return Stack(
      children: [
        buildBody(context, model, showModel),
        buildHeader(model),
        buildBottomNavBar(model)
      ],
    );
  }
}

Widget buildHeader(HomeViewModel model) {
  return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
        child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Series App",
                    style: kH1,
                  ),
                  Text(
                    "A Serious Series App",
                    style: kP,
                  ),
                ],
              ),
            )),
      ));
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
        // TODO: make card component
        GestureDetector(
          // onTap: () => print('show id: ${show.id}'),
          onTap: () {
            showModel.setShowId(show.id);
            Navigator.pushNamed(context, '/show');
          },
          child: Container(
            // TODO: No image indicator
            decoration: show.image != null
                ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(show.image),
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
                      show.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    ],
  );
}

Widget buildBottomNavBar(HomeViewModel model) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: AssBar(
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
              child: IconButton(
                icon: Icon(Icons.search),
                color: Colors.black,
                onPressed: () => print('search pressed'),
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
      ),
    ),
  );
}
