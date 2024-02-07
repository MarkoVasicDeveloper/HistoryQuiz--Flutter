import 'package:flutter/material.dart';
import 'package:istorija_srbije/models/log_model.dart';
import 'package:istorija_srbije/models/multiplayer_model.dart';
import 'package:istorija_srbije/models/settings_model.dart';
import 'package:istorija_srbije/models/succes_model.dart';
import 'package:istorija_srbije/models/user_model.dart';
import 'package:istorija_srbije/provider/user/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService;
  UserModel _userModel = UserModel(
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
    multiplayer: MultiplayerModel(
        champion: 0,
        ruunerUp: 0,
        thirdPlace: 0,
        currentStage: 'roundOf16',
        isConnected: false,
        opponentAvailable: false,
        opponent: OpponentModel(
          username: '',
          points: 0,
          round: 0,
        ),
        currentAnswer: '',
        currentOpponentAnswer: '',
        score: 0,
        opponentScore: 0),
  );

  UserProvider(this._userService);

  UserModel get userModel => _userModel;

  Future<void> initializeUserData() async {
    final Map<String, dynamic> decodedData = await _userService.loadUserData();
    _userModel = UserModel.fromJson(decodedData);
    notifyListeners();
  }

  void setUsername(String newUsername) {
    _userModel.setUsername(newUsername);
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setLogIn(String newUsername) {
    _userModel.setLogin('');
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setHearts(int hearts, VoidCallback? onZeroHearts) {
    _userModel.setHearts(hearts);
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
    if (_userModel.hearts == 0) onZeroHearts!();
  }

  void setDiamonds(int diamonds) {
    _userModel.setDiamonds(diamonds);
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setFreeSpin(bool free) {
    _userModel.setFreeSpin(free);
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setRound(int? resetRound) {
    _userModel.setRound(resetRound);
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setSetings(bool? notification, int? volume) {
    _userModel.setSettings(notification, volume);
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setSuccessProcentage() {
    _userModel.setSuccessProcentage();
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setSuccessCorrect() {
    _userModel.setSuccessCorrect();
    _userModel.setSuccessProcentage();
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setSuccessTotal() {
    _userModel.setSuccessTotal();
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setSuccessWrong() {
    _userModel.setSuccessWrong();
    _userModel.setSuccessProcentage();
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setInRow(int inRow) {
    _userModel.setInRow(inRow);
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setCurrentInRow(bool reset) {
    _userModel.setCurrentInRow(reset);
    if (_userModel.success.currentInRow > _userModel.success.inRow) {
      _userModel.setInRow(_userModel.success.currentInRow);
    }
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setPoints(int points) {
    _userModel.setPoints(points);
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setChampion() {
    _userModel.setChampion();
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setRuunerUp() {
    _userModel.setRuunerUp();
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setThirdPlace() {
    _userModel.setThirdPlace();
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setCurrentStage(String stage) {
    _userModel.setCurrentStage(stage);
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setIsConnected(bool connect) {
    _userModel.setIsConnected(connect);
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setOpponentAvailable(bool available) {
    _userModel.setOpponentAvailable(available);
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setOpponent(OpponentModel opponent) {
    _userModel.setOpponent(opponent);
    _userService.saveUserDataToFile(_userModel);
    notifyListeners();
  }

  void setCurrentAnswer(String answer) {
    _userModel.setCurrentAnswer(answer);
    notifyListeners();
  }

  void setOpponentCurrentAnswer(String answer) {
    _userModel.setOpponentCurrentAnswer(answer);
    notifyListeners();
  }

  void setScore({int? score}) {
    _userModel.setScore(score ?? _userModel.multiplayer.score + 1);
    notifyListeners();
  }

  void setOpponentScore({int? score}) {
    _userModel
        .setOpponentScore(score ?? _userModel.multiplayer.opponentScore + 1);
    notifyListeners();
  }
}
