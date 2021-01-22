import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapp/main/screens/show_screen/show_viewmodel.dart';

class ShowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShowViewModel model = Provider.of<ShowViewModel>(context);
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Text('show screen'),
      )),
    );
  }
}
