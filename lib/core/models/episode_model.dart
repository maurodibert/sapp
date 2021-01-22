class EpisodeModel {
  final int id;
  final String name;
  final int season;
  final int number;
  final String image;
  final String summary;

  EpisodeModel({
    this.id,
    this.name,
    this.season,
    this.number,
    this.image,
    this.summary,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'],
      name: json['name'],
      season: json['season'],
      number: json['number'],
      image: json['image'] != null ? json['image']['medium'] : null,
      summary: json['summary'],
    );
  }
}
