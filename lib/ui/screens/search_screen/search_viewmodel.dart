import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapp/core/models/show_model.dart';
import 'package:sapp/core/services/tv_maze_db.dart';
import 'package:sapp/service_lcoator.dart';

class SearchViewModel extends ChangeNotifier {
  //
  // INJECTIONS
  TvMazeDB tvMazeDB = locator<TvMazeDB>();

  //
  // GENERAL STATE
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController get textFieldController => _textFieldController;

  List<ShowModel> _shows;
  List<ShowModel> get shows => _shows;

  //
  // LIFE CYCLE - Initialization and disposing

  //
  // SERVICE COMMUNICATION
  Future<List<ShowModel>> queryShows(String query) async {
    List<ShowModel> response = await tvMazeDB.queryShows(query);
    if (response != []) {
      _shows = response;
      notifyListeners();
    }
    return _shows;
  }

  void cleanSearch() {
    _shows = [];
    _textFieldController.clear();
    notifyListeners();
  }
}
