import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sapp/core/models/episode_model.dart';
import 'package:sapp/core/models/show_model.dart';

// TODO: TEST
class TvMazeDB {
  /// Get **complete list of shows**
  /// respecting original pagination:
  /// _250 maximum per page_
  Future<List<ShowModel>> fetchShows(int page) async {
    List<ShowModel> _shows = [];
    String url = 'http://api.tvmaze.com/shows?page=$page';

    try {
      print('[ HomeViewModel ] Fetching shows page: $page');
      var response = await http.get(url);

      if (response.statusCode == 404) {
        print('[ HomeViewModel ] There are no more pages');
        return _shows;
      } else {
        // TODO: final because it will perform better since I'll not change this?
        final List decodedBody = await json.decode(response.body) as List;
        if (decodedBody != null) {
          for (var show in decodedBody) {
            _shows.add(ShowModel.fromJson(show));
          }
        }

        print('[ HomeViewModel ] Fetching shows ended');
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
      print('[ ShowViewModel ] Fetching show with id: $id');
      var response = await http.get(url);

      final Map decodedBody = await json.decode(response.body) as Map;
      if (decodedBody != null) {
        _show = ShowModel.fromJson(decodedBody);
      }
      print('[ ShowViewModel ] Fetched show');
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
      print('[ ShowViewModel ] Fetching show episodes:');
      var response = await http.get(url);

      final List decodedBody = await json.decode(response.body) as List;

      if (decodedBody != null) {
        for (Map episode in decodedBody) {
          _episodes.add(EpisodeModel.fromJson(episode));
        }
      }
      print('[ ShowViewModel ] Fetched episodes');
    } catch (e) {
      throw Exception(e);
    }

    return _episodes;
  }
}
