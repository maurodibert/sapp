import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapp/core/models/show_model.dart';
import 'package:sapp/core/services/tv_maze_db.dart';
import 'package:sapp/service_lcoator.dart';

class ShowViewModel extends ChangeNotifier {
  //
  // GENERAL STATE
  TvMazeDB tvMazeDB = locator<TvMazeDB>();

  int _showId;
  int get showId => _showId;
  ShowModel _show;
  ShowModel get show => _show;

  void setShowId(int id) {
    _showId = id;
    notifyListeners();
  }

  Future<ShowModel> fetchShow(int id) async {
    ShowModel response = await tvMazeDB.getShow(id);
    if (response != null) {
      _show = response;
      notifyListeners();
    }
    return _show;
  }

  //
  // LIFE CYCLE - Initialization and disposing
  // init() async {}
}
