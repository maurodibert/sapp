import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapp/main/library/ass_loading.dart';
import 'package:sapp/main/screens/show_screen/show_viewmodel.dart';

class ShowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShowViewModel model = Provider.of<ShowViewModel>(context);
    return SafeArea(
      child: Scaffold(
          body: model.show != null
              ? Center(
                  child: Text(model.show.name),
                )
              : LoadingWidget()),
    );
  }
}
