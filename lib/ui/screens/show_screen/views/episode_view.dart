import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapp/core/constants.dart';
import 'package:sapp/ui/library/s_rich_text.dart';
import 'package:sapp/ui/screens/show_screen/show_viewmodel.dart';

class EpisodeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShowViewModel model = Provider.of<ShowViewModel>(context);
    Size size = MediaQuery.of(context).size;

    if (model.episode != null) {
      return Positioned(
        // hiding details view
        left: model.isDetailsVisible ? 20 : -size.width,
        top: model.isDetailsVisible ? 0 : -size.height,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          width: size.width - 40,
          // height: size.height,
          color: Colors.yellow,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Text(
                          model.episode.name,
                          style: kP.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.clear),
                          color: Colors.black,
                          onPressed: () => model.toggleDetails(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Text(
                          'S' + model.episode.season.toString().toUpperCase(),
                          style: kP.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'N' + model.episode.number.toString().toUpperCase(),
                          style: kP.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  if (model.episode.image != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: size.width - 48,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          image: DecorationImage(
                            image: NetworkImage(model.episode.image),
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.8),
                                BlendMode.dstATop),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  SeriousRichText(
                      data: model.episode.summary, color: Colors.black),
                  SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
