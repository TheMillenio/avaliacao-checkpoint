class RatingModel {
  const RatingModel({
    required this.rate,
    required this.count,
  });

  final double rate;
  final int count;

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: (json['rate'] as num?)?.toDouble() ?? 0,
      count: json['count'] as int? ?? 0,
    );
  }
}
