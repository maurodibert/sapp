import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sapp/core/models/show_model.dart';

class TvMazeDB {
  // TODO: TEST
  /// Get **complete list of shows**
  /// respecting original pagination:
  /// _250 maximum per page_
  Future<List<ShowModel>> fetchShows(int page) async {
    List<ShowModel> _shows = [];

    String url = 'http://api.tvmaze.com/shows?page=$page';

    try {
      print('[HomeViewModel] Fetching shows page: $page');
      var response = await http.get(url);

      if (response.statusCode == 404) {
        print('[HomeViewModel] There are no more pages');
        return _shows;
      } else {
        // TODO: final because it will perform better since I'll not change this?
        final List decodedBody = await json.decode(response.body) as List;
        if (decodedBody != null) {
          for (var show in decodedBody) {
            _shows.add(ShowModel.fromJson(show));
          }
        }

        print('[HomeViewModel] Fetching shows ended');
        return _shows;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
