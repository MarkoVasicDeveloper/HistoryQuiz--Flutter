class SettingsModel {
  bool notification;
  int volume;

  SettingsModel({required this.notification, required this.volume});

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      notification: json['notification'],
      volume: json['volume'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notification': notification,
      'volume': volume,
    };
  }
}
