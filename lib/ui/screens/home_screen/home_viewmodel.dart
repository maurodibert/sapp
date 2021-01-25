import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapp/core/models/show_model.dart';
import 'package:sapp/core/services/tv_maze_db.dart';
import 'package:sapp/ui/library/s_loading.dart';
import 'package:sapp/ui/screens/home_screen/views/home_list_view.dart';
import 'package:sapp/service_lcoator.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    init();
  }

  //
  // INJECTIONS
  TvMazeDB tvMazeDB = locator<TvMazeDB>();

  //
  // GENERAL STATE
  int _page = 0;
  List<ShowModel> _shows = [];
  List<ShowModel> get shows => _shows;

  int _viewsState = 0;
  int get viewsState => _viewsState;

  List<Widget> _views = [
    SeriousLoading(),
    HomeListView(),
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

  /// original api's pagination: 250max per page
  Future advance() async {
    _page += 1;
    _shows = [];
    await fetchShows(_page);
    _scrollToTop();
    notifyListeners();
  }

  /// original api's pagination: 250max per page
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

  //
  // SERVICE COMMUNICATION
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
