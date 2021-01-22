import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapp/core/models/show_model.dart';
import 'package:sapp/core/services/tv_maze_db.dart';
import 'package:sapp/main/library/ass_loading.dart';
import 'package:sapp/main/screens/home_screen/views/list_view.dart';
import 'package:sapp/service_lcoator.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    init();
  }

  //
  // GENERAL STATE
  TvMazeDB tvMazeDB = locator<TvMazeDB>();

  int _page = 0;
  List<ShowModel> _shows = [];
  List<ShowModel> get shows => _shows;

  int _viewsState = 0;
  int get viewsState => _viewsState;

  List<Widget> _views = [
    LoadingWidget(),
    HomeScreenListView(),
  ];
  List<Widget> get views => _views;

  //
  // LIFE CYCLE - Initialization and disposing
  init() async {
    _listViewScroll = ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );
    _shows = await fetchShows(_page);
  }

  //
  // LIST VIEW
  ScrollController _listViewScroll;
  ScrollController get listViewScroll => _listViewScroll;

  /// advance respecting original api's pagination
  Future advance() async {
    _page += 1;
    _shows = [];
    await fetchShows(_page);
    _scrollToTop();
    notifyListeners();
  }

  /// back respecting original api's pagination
  Future back() async {
    if (_page != 0) {
      _page -= 1;
      _shows = [];
      await fetchShows(_page);
    }
    _scrollToTop();
    notifyListeners();
  }

  void _scrollToTop() {
    _listViewScroll.animateTo(0.0,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  Future<List<ShowModel>> fetchShows(int page) async {
    List<ShowModel> response = await tvMazeDB.fetchShows(page);
    if (response != []) {
      _shows = response;
      _viewsState = 1;
      notifyListeners();
    }
    return _shows;
  }
}
