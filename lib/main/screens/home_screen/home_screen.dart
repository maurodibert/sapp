import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapp/core/constants.dart';
import 'package:sapp/core/models/show_model.dart';
import 'package:sapp/main/library/ass_bar.dart';
import 'package:sapp/main/library/ass_button.dart';
import 'package:sapp/main/screens/home_screen/home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          Scaffold(body: Consumer<HomeViewModel>(builder: (context, model, _) {
        return model.shows.length > 0
            ? Stack(
                children: [
                  buildBody(model),
                  buildHeader(model),
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

  Widget buildBody(HomeViewModel model) {
    return GridView.count(
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      crossAxisCount: 3,
      children: [
        for (ShowModel show in model.shows)
          Container(
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
              children: [
                Text(show.name),
              ],
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
                child: AssButton(
                  isPrimary: true,
                  text: "<",
                  onTap: () => model.back(),
                  radius: BorderRadius.only(
                    bottomLeft: Radius.circular(kSmallRadius),
                    topLeft: Radius.circular(kSmallRadius),
                  ),
                ),
              ),
              Expanded(
                child: AssButton(
                  isPrimary: true,
                  text: ">",
                  onTap: () => model.advance(),
                  radius: BorderRadius.only(
                    bottomRight: Radius.circular(kSmallRadius),
                    topRight: Radius.circular(kSmallRadius),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
