class MultiplayerModel {
  int champion;
  int ruunerUp;
  int thirdPlace;
  String currentStage;
  bool isConnected;
  bool opponentAvailable;
  OpponentModel opponent;

  MultiplayerModel(
      {required this.champion,
      required this.ruunerUp,
      required this.thirdPlace,
      required this.currentStage,
      required this.isConnected,
      required this.opponentAvailable,
      required this.opponent});

  factory MultiplayerModel.fromJson(Map<String, dynamic> json) {
    return MultiplayerModel(
      champion: json['champion'],
      ruunerUp: json['ruunerUp'],
      thirdPlace: json['thirdPlace'],
      currentStage: json['currentStage'],
      isConnected: json['isConnected'],
      opponentAvailable: json['opponentAvailable'],
      opponent: OpponentModel.fromJson(json['opponent']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'champion': champion,
      'ruunerUp': ruunerUp,
      'thirdPlace': thirdPlace,
      'currentStage': currentStage,
      'isConnected': isConnected,
      'opponentAvailable': opponentAvailable,
      'opponent': opponent.toJson()
    };
  }
}

class OpponentModel {
  String username;
  int points;

  OpponentModel({required this.username, required this.points});

  factory OpponentModel.fromJson(Map<String, dynamic> json) {
    return OpponentModel(
      username: json['username'],
      points: json['points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'points': points,
    };
  }
}
