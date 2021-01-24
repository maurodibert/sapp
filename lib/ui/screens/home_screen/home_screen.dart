import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapp/ui/screens/home_screen/home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeViewModel model = Provider.of<HomeViewModel>(context);
    return SafeArea(
      child: Scaffold(
        body: model.views[model.viewsState],
      ),
    );
  }
}
