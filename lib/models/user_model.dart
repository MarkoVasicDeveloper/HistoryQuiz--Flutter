import 'package:istorija_srbije/models/log_model.dart';
import 'package:istorija_srbije/models/settings_model.dart';
import 'package:istorija_srbije/models/succes_model.dart';

class UserModel {
  String username;
  int hearts;
  int diamonds;
  LogModel log;
  bool freeSpin;
  int round;
  SettingsModel settings;
  SuccessModel success;

  UserModel({
    required this.username,
    required this.hearts,
    required this.diamonds,
    required this.log,
    required this.freeSpin,
    required this.round,
    required this.settings,
    required this.success,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      hearts: json['hearts'],
      diamonds: json['diamonds'],
      log: LogModel.fromJson(json['log']),
      freeSpin: json['freeSpin'],
      round: json['round'],
      settings: SettingsModel.fromJson(json['settings']),
      success: SuccessModel.fromJson(json['success']),
    );
  }

  void setUsername(String newUsername) {
    username = newUsername;
  }

  void setHearts(int newHearts) {
    hearts = newHearts;
  }

  void setDiamonds(int newDiamonds) {
    diamonds = newDiamonds;
  }

  void setFreeSpin(bool free) {
    freeSpin = free;
  }

  void setRound(int? resetRound) {
    if (resetRound != null) {
      round = 0;
    } else {
      round = round + 1;
    }
  }

  void setLogin(String newUsername) {
    log.last = DateTime.now().toIso8601String();
    log.number += 1;

    if (newUsername.isNotEmpty) {
      username = newUsername;
    }
  }

  void setSettings(bool? notification, int? volume) {
    if (notification!) settings.notification = notification;
    if (volume != null) settings.volume = volume;
  }

  void setSuccessProcentage() {
    if (success.total != 0) {
      double procentage = (success.success / success.total) * 100.0;
      success.procentage = procentage.roundToDouble().toInt();
    }
  }

  void setSuccessCorrect() {
    success.success += 1;
  }

  void setSuccessTotal() {
    success.total += 1;
  }

  void setSuccessWrong() {
    success.wrong += 1;
  }

  void setInRow(int inRow) {
    success.inRow = inRow;
  }

  void setCurrentInRow(bool reset) {
    if (reset) {
      success.currentInRow = 0;
    } else {
      success.currentInRow += 1;
    }
  }

  void setPoints(int points) {
    success.points += points;
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'hearts': hearts,
      'diamonds': diamonds,
      'log': log.toJson(),
      'freeSpin': freeSpin,
      'round': round,
      'settings': settings.toJson(),
      'success': success.toJson(),
    };
  }
}
