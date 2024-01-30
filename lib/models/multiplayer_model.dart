class MultiplayerModel {
  int champion;
  int ruunerUp;
  int thirdPlace;
  String currentStage;
  bool isConnected;

  MultiplayerModel(
      {required this.champion,
      required this.ruunerUp,
      required this.thirdPlace,
      required this.currentStage,
      required this.isConnected});

  factory MultiplayerModel.fromJson(Map<String, dynamic> json) {
    return MultiplayerModel(
        champion: json['champion'],
        ruunerUp: json['ruunerUp'],
        thirdPlace: json['thirdPlace'],
        currentStage: json['currentStage'],
        isConnected: json['isConnected']);
  }

  Map<String, dynamic> toJson() {
    return {
      'champion': champion,
      'ruunerUp': ruunerUp,
      'thirdPlace': thirdPlace,
      'currentStage': currentStage,
      'isConnected': isConnected
    };
  }
}
