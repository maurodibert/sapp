import 'package:flutter/cupertino.dart';
import 'package:sapp/core/models/show_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    init();
  }

  int _initialPage = 0;
  List<ShowModel> _shows = [];
  List<ShowModel> get shows => _shows;

  //
  // LIFE CYCLE - Initialization and disposing
  init() async {
    fetchShows(_initialPage);
  }

  /// Get **complete list of shows**
  /// respecting original pagination:
  /// _250 maximum per page_
  // TODO: TEST
  Future fetchShows(int page) async {
    String url = 'http://api.tvmaze.com/shows?page=$page';

    try {
      print('::: Fetching Shows - page: $page');
      var response = await http.get(url);
      // TODO: final because it will perform better since I'll not change this?
      final List decodedBody = json.decode(response.body) as List;
      if (decodedBody != null) {
        for (var show in decodedBody) {
          _shows.add(ShowModel.fromJson(show));
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
