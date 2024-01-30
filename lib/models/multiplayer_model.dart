class MultiplayerModel {
  int champion;
  int ruunerUp;
  int thirdPlace;
  String currentStage;

  MultiplayerModel(
      {required this.champion,
      required this.ruunerUp,
      required this.thirdPlace,
      required this.currentStage});

  factory MultiplayerModel.fromJson(Map<String, dynamic> json) {
    return MultiplayerModel(
        champion: json['champion'],
        ruunerUp: json['ruunerUp'],
        thirdPlace: json['thirdPlace'],
        currentStage: json['currentStage']);
  }

  Map<String, dynamic> toJson() {
    return {
      'champion': champion,
      'ruunerUp': ruunerUp,
      'thirdPlace': thirdPlace,
      'currentStage': currentStage
    };
  }
}
