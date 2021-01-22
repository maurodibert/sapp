import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowViewModel extends ChangeNotifier {
  ShowViewModel() {}

  //
  // GENERAL STATE
  int _showId;
  int get showId => _showId;

  void setShowId(int id) {
    _showId = id;
    notifyListeners();
  }

  //
  // LIFE CYCLE - Initialization and disposing
  // init() async {}
}
