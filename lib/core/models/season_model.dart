class SeasonModel {
  final int id;
  final int number;

  SeasonModel({
    this.id,
    this.number,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) {
    return SeasonModel(
      id: json['id'],
      number: json['number'],
    );
  }
}
