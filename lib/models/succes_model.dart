class SuccessModel {
  int success;
  int wrong;
  int procentage;
  int total;
  int inRow;
  int currentInRow;
  int points;

  SuccessModel({
    required this.success,
    required this.procentage,
    required this.wrong,
    required this.total,
    required this.inRow,
    required this.currentInRow,
    required this.points,
  });

  factory SuccessModel.fromJson(Map<String, dynamic> json) {
    return SuccessModel(
      success: json['success'] ?? 0,
      wrong: json['wrong'] ?? 0,
      procentage: json['procentage'] ?? 0,
      total: json['total'] ?? 0,
      inRow: json['inRow'],
      currentInRow: json['currentInRow'],
      points: json['points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "wrong": wrong,
      "procentage": procentage,
      "total": total,
      "inRow": inRow,
      "currentInRow": currentInRow,
      "points": points,
    };
  }
}
