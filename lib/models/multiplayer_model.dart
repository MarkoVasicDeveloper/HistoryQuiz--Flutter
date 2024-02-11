class MultiplayerModel {
  int champion;
  int ruunerUp;
  int thirdPlace;
  String currentStage;
  bool isConnected;
  bool opponentAvailable;
  OpponentModel opponent;
  int score;
  int opponentScore;

  MultiplayerModel(
      {required this.champion,
      required this.ruunerUp,
      required this.thirdPlace,
      required this.currentStage,
      required this.isConnected,
      required this.opponentAvailable,
      required this.opponent,
      required this.opponentScore,
      required this.score});

  factory MultiplayerModel.fromJson(Map<String, dynamic> json) {
    return MultiplayerModel(
        champion: json['champion'],
        ruunerUp: json['ruunerUp'],
        thirdPlace: json['thirdPlace'],
        currentStage: json['currentStage'],
        isConnected: json['isConnected'],
        opponentAvailable: json['opponentAvailable'],
        opponent: OpponentModel.fromJson(json['opponent']),
        score: json['score'],
        opponentScore: json['opponentScore']);
  }

  Map<String, dynamic> toJson() {
    return {
      'champion': champion,
      'ruunerUp': ruunerUp,
      'thirdPlace': thirdPlace,
      'currentStage': currentStage,
      'isConnected': isConnected,
      'opponentAvailable': opponentAvailable,
      'opponent': opponent.toJson(),
      'score': score,
      'opponentScore': opponentScore
    };
  }
}

class OpponentModel {
  String username;
  int points;
  int round;

  OpponentModel({
    required this.username,
    required this.points,
    required this.round,
  });

  factory OpponentModel.fromJson(Map<String, dynamic> json) {
    return OpponentModel(
      username: json['username'],
      points: json['points'],
      round: json['round'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'points': points,
      'round': round,
    };
  }
}
