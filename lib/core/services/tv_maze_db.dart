import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sapp/core/models/episode_model.dart';
import 'package:sapp/core/models/season_model.dart';
import 'package:sapp/core/models/show_model.dart';

class TvMazeDB {
  /// Get **complete list of shows**
  /// respecting original pagination:
  /// _250 maximum per page_
  Future<List<ShowModel>> fetchShows(int page) async {
    List<ShowModel> _shows = [];
    String url = 'http://api.tvmaze.com/shows?page=$page';

    try {
      print('[ TV Maze DB Service ] Fetching shows page: $page');
      var response = await http.get(url);

      if (response.statusCode == 404) {
        print('[ TV Maze DB Service ] There are no more pages');
        return _shows;
      } else {
        final List decodedBody = await json.decode(response.body) as List;
        if (decodedBody != null) {
          for (var show in decodedBody) {
            _shows.add(ShowModel.fromJson(show));
          }
        }

        print('[ TV Maze DB Service ] Fetching shows ended');
        return _shows;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Get **individual show detail**
  Future<ShowModel> getShow(int id) async {
    ShowModel _show;
    String url = 'http://api.tvmaze.com/shows/$id';

    try {
      print('[ TV Maze DB Service ] Fetching show with id: $id');
      var response = await http.get(url);

      final Map decodedBody = await json.decode(response.body) as Map;
      if (decodedBody != null) {
        _show = ShowModel.fromJson(decodedBody);
      }
      print('[ TV Maze DB Service ] Fetched show');
    } catch (e) {
      throw Exception(e);
    }

    return _show;
  }

  /// Get **episodes of specific show**
  Future<List<EpisodeModel>> getEpisodes(int id) async {
    List<EpisodeModel> _episodes = [];
    String url = 'http://api.tvmaze.com/shows/$id/episodes';

    try {
      print('[ TV Maze DB Service ] Fetching show $id episodes:');
      var response = await http.get(url);

      final List decodedBody = await json.decode(response.body) as List;

      if (decodedBody != null) {
        for (Map episode in decodedBody) {
          _episodes.add(EpisodeModel.fromJson(episode));
        }
      }
      print('[ TV Maze DB Service ] Fetched episodes');
    } catch (e) {
      throw Exception(e);
    }

    return _episodes;
  }

  /// Get **seasons of specific show**
  Future<List<SeasonModel>> getSeasons(int id) async {
    List<SeasonModel> _seasons = [];
    String url = 'http://api.tvmaze.com/shows/$id/seasons';

    try {
      print('[ TV Maze DB Service ] Fetching show $id seasons');
      var response = await http.get(url);

      final List decodedBody = await json.decode(response.body) as List;

      if (decodedBody != null) {
        for (Map season in decodedBody) {
          _seasons.add(SeasonModel.fromJson(season));
        }
      }
      print('[ TV Maze DB Service ] Fetched seasons');
    } catch (e) {
      throw Exception(e);
    }

    return _seasons;
  }

  /// Get **a list of shows based on a query**:
  Future<List<ShowModel>> queryShows(String query) async {
    List<ShowModel> _shows = [];
    String url = 'http://api.tvmaze.com/search/shows?q=$query';

    try {
      print('[ TV Maze DB Service ] Fetching shows for query: $query');
      var response = await http.get(url);

      final List decodedBody = await json.decode(response.body) as List;
      if (decodedBody != null) {
        for (var show in decodedBody) {
          _shows.add(ShowModel.fromJson(show['show']));
        }
      }

      print('[ TV Maze DB Service ] Fetching shows ended');
      return _shows;
    } catch (e) {
      throw Exception(e);
    }
  }
}
