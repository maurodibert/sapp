import 'package:sapp/core/models/episode_model.dart';

class ShowModel {
  final int id;
  final String url;
  final String name;
  final List<dynamic> genres;
  final String status;
  final Map<String, dynamic> schedule;
  final String image;
  final String summary;
  final List<EpisodeModel> episodes;

  ShowModel({
    this.id,
    this.url,
    this.name,
    this.genres,
    this.status,
    this.schedule,
    this.image,
    this.summary,
    this.episodes,
  });

  factory ShowModel.fromJson(Map<String, dynamic> json) {
    return ShowModel(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      genres: json['genres'] as List,
      status: json['status'],
      schedule: json['schedule'] as Map,
      image: json['image'] != null ? json['image']['medium'] : null,
      summary: json['summary'],
      episodes: json['episodes'] as List,
    );
  }
}
