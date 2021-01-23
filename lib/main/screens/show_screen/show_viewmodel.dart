import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapp/core/models/episode_model.dart';
import 'package:sapp/core/models/season_model.dart';
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
  List<EpisodeModel> _episodes = [];
  List<EpisodeModel> get episodes => _episodes;
  List<SeasonModel> _seasons = [];
  List<SeasonModel> get seasons => _seasons;

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

  Future<List<EpisodeModel>> fetchEpisodes(int id) async {
    List<EpisodeModel> response = await tvMazeDB.getEpisodes(id);
    if (response != null) {
      _episodes = response;
      notifyListeners();
    }
    return _episodes;
  }

  Future<List<SeasonModel>> fetchSeasons(int id) async {
    List<SeasonModel> response = await tvMazeDB.getSeasons(id);
    if (response != null) {
      _seasons = response;
      notifyListeners();
    }
    return _seasons;
  }
}
