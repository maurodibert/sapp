import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapp/core/models/show_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sapp/main/screens/home_screen/views/list_view.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    init();
  }

  //
  // GENERAL STATE
  int _viewsState = 0;
  int get viewsState => _viewsState;
  List<Widget> _views = [
    Center(
      child: CircularProgressIndicator(),
    ),
    HomeScreenListView(),
  ];
  List<Widget> get views => _views;

  //
  // LIFE CYCLE - Initialization and disposing
  init() async {
    await fetchShows(_page);
  }

  //
  // LIST VIEW
  int _page = 0;
  List<ShowModel> _shows = [];
  List<ShowModel> get shows => _shows;

  // TODO: move to service
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
          _viewsState = 1;
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
