// user_provider.dart
import 'package:flutter/material.dart';
import 'package:istorija_srbije/models/log_model.dart';
import 'package:istorija_srbije/models/settings_model.dart';
import 'package:istorija_srbije/models/succes_model.dart';
import 'package:istorija_srbije/models/user_model.dart';
import 'package:istorija_srbije/provider/user/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService;
  late UserModel _userModel;

  UserProvider(this._userService) {
    _userModel = UserModel(
      username: '',
      hearts: 5,
      diamonds: 10,
      log: LogModel(number: 0, last: ''),
      freeSpin: true,
      round: 0,
      settings: SettingsModel(notification: true, volume: 50),
      success: SuccessModel(
        success: 0,
        procentage: 0,
        wrong: 0,
        total: 0,
        inRow: 0,
        currentInRow: 0,
        points: 0,
      ),
    );
  }

  UserModel get userModel => _userModel;

  Future<void> initializeUserData() async {
    final Map<String, dynamic> decodedData = await _userService.loadUserData();
    _userModel = UserModel.fromJson(decodedData);
    notifyListeners();
  }

  void setUsername(String newUsername) {
    _userModel.setUsername(newUsername);
    _userService.saveUserDataToFile();
    notifyListeners();
  }

  void setLogIn(String newUsername) {
    _userModel.setLogin('');
    _userService.saveUserDataToFile();
    notifyListeners();
  }

  void setHearts(int hearts, VoidCallback? onZeroHearts) {
    _userModel.setHearts(hearts);
    _userService.saveUserDataToFile();
    notifyListeners();
    if (_userModel.hearts == 0) onZeroHearts!();
  }

  void setDiamonds(int diamonds) {
    _userModel.setDiamonds(diamonds);
    _userService.saveUserDataToFile();
    notifyListeners();
  }

  void setFreeSpin(bool free) {
    _userModel.setFreeSpin(free);
    _userService.saveUserDataToFile();
    notifyListeners();
  }

  void setRound(int? resetRound) {
    _userModel.setRound(resetRound);
    _userService.saveUserDataToFile();
    notifyListeners();
  }

  void setSetings(bool? notification, int? volume) {
    _userModel.setSettings(notification, volume);
    _userService.saveUserDataToFile();
    notifyListeners();
  }

  void setSuccessProcentage() {
    _userModel.setSuccessProcentage();
    _userService.saveUserDataToFile();
    notifyListeners();
  }

  void setSuccessCorrect() {
    _userModel.setSuccessCorrect();
    _userModel.setSuccessProcentage();
    _userService.saveUserDataToFile();
    notifyListeners();
  }

  void setSuccessTotal() {
    _userModel.setSuccessTotal();
    _userService.saveUserDataToFile();
    notifyListeners();
  }

  void setSuccessWrong() {
    _userModel.setSuccessWrong();
    _userModel.setSuccessProcentage();
    _userService.saveUserDataToFile();
    notifyListeners();
  }

  void setInRow(int inRow) {
    _userModel.setInRow(inRow);
    _userService.saveUserDataToFile();
    notifyListeners();
  }

  void setCurrentInRow(bool reset) {
    _userModel.setCurrentInRow(reset);
    if (_userModel.success.currentInRow > _userModel.success.inRow) {
      _userModel.setInRow(_userModel.success.currentInRow);
    }
    _userService.saveUserDataToFile();
    notifyListeners();
  }

  void setPoints(int points) {
    _userModel.setPoints(points);
    _userService.saveUserDataToFile();
    notifyListeners();
  }
}
