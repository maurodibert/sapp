import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapp/core/constants.dart';
import 'package:sapp/ui/screens/search_screen/search_viewmodel.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SearchViewModel model = Provider.of<SearchViewModel>(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Hero(
              tag: kHeroSearchTag,
              child: Material(
                type: MaterialType.transparency,
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              )),
        ),
      ),
    );
  }
}
