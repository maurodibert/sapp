import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapp/core/models/show_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sapp/main/screens/home_screen/views/list_view.dart';

class ShowViewModel extends ChangeNotifier {
  ShowViewModel() {
    init();
  }

  //
  // GENERAL STATE

  //
  // LIFE CYCLE - Initialization and disposing
  init() async {}
}
