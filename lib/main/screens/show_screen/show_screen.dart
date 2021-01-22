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
          body: model.show != null ? buildBody(model) : LoadingWidget()),
    );
  }

  Widget buildBody(ShowViewModel model) {
    return Hero(
      tag: 'tag - ${model.show.id}',
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
            fit: BoxFit.cover,
            image: NetworkImage(model.show.image),
          ),
        ),
      ),
    );
  }
}
