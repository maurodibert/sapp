import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapp/core/services/tv_maze_db.dart';
import 'package:sapp/service_lcoator.dart';

class SearchViewModel extends ChangeNotifier {
  SearchViewModel() {
    // init();
  }

  //
  // INJECTIONS
  TvMazeDB tvMazeDB = locator<TvMazeDB>();

  //
  // GENERAL STATE

  //
  // LIFE CYCLE - Initialization and disposing
  init() async {}

  // Future<List<ShowModel>> fetchShows(int page) async {
  //   List<ShowModel> response = await tvMazeDB.fetchShows(page);
  //   if (response != []) {
  //     _shows = response;
  //     _viewsState = 1;
  //     notifyListeners();
  //   }
  //   return _shows;
  // }
}
