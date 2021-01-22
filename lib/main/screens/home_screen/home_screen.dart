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
        switch (model.viewState) {
          case 'list':
            return Stack(
              children: [
                buildBody(model),
                buildHeader(model),
                buildBottomNavBar(model)
              ],
            );
            break;
          case 'search':
          default:
            return Center(child: CircularProgressIndicator());
        }
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
      crossAxisCount: 2,
      children: [
        for (ShowModel show in model.shows)
          // TODO: make card component
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
}
