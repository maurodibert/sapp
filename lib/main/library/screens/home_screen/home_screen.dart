import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapp/core/constants.dart';
import 'package:sapp/core/models/show_model.dart';
import 'package:sapp/main/library/s_bar.dart';
import 'package:sapp/main/library/screens/home_screen/home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          Scaffold(body: Consumer<HomeViewModel>(builder: (context, model, _) {
        return model.shows != null
            ? Stack(
                children: [
                  buildHeader(model),
                  buildBody(model),
                  buildBottomNavBar(model)
                ],
              )
            : Center(child: CircularProgressIndicator());
      })),
    );
  }

  Widget buildHeader(HomeViewModel model) {
    return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
          child: Container(
              child: Column(
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
          )),
        ));
  }

  Widget buildBody(HomeViewModel model) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      children: [
        for (ShowModel show in model.shows)
          Column(
            children: [
              Text(show.name),
              Text(show.status),
            ],
          )
      ],
    );
  }

  Widget buildBottomNavBar(HomeViewModel model) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: SeriesBar(
          child: Text('nav bar'),
        ),
      ),
    );
  }
}
