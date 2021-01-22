import 'package:flutter/cupertino.dart';
import 'package:sapp/core/models/show_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    init();
  }

  int _page = 0;
  List<ShowModel> _shows = [];
  List<ShowModel> get shows => _shows;
  String _viewState = 'empty';
  String get viewState => _viewState;

  //
  // LIFE CYCLE - Initialization and disposing
  init() async {
    await fetchShows(_page);
  }

  // TODO: TEST
  /// Get **complete list of shows**
  /// respecting original pagination:
  /// _250 maximum per page_
  Future fetchShows(int page) async {
    String url = 'http://api.tvmaze.com/shows?page=$page';

    try {
      print('[HomeViewModel] Fetching shows page: $page');
      var response = await http.get(url);

      if (response.statusCode == 404) {
        print('[HomeViewModel] There are no more pages');
        return;
      } else {
        // TODO: final because it will perform better since I'll not change this?
        final List decodedBody = await json.decode(response.body) as List;
        if (decodedBody != null) {
          for (var show in decodedBody) {
            _shows.add(ShowModel.fromJson(show));
          }
          _viewState = 'list';
          notifyListeners();
        }

        print('[HomeViewModel] Fetching shows ended');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /// advance respecting original api's pagination
  Future advance() async {
    _page += 1;
    _shows = [];
    await fetchShows(_page);
  }

  /// back respecting original api's pagination
  Future back() async {
    if (_page != 0) {
      _page -= 1;
      _shows = [];
      await fetchShows(_page);
    }
  }
}
