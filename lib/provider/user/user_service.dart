import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:istorija_srbije/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  UserService();

  Future<Map<String, dynamic>> loadUserData(UserModel userModel) async {
    if (kIsWeb) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('user_data');

      if (jsonString != null) {
        final data = json.decode(jsonString);
        Map<String, dynamic> log = data["log"];

        if (log['last'] != '') {
          DateTime now = DateTime.now();
          DateTime midnight = DateTime(now.year, now.month, now.day, 0, 0, 0);

          String lastLoginString = log['last'];
          DateTime lastLogin = DateTime.parse(lastLoginString);

          if (!data['freeSpin'] && lastLogin.isBefore(midnight)) {
            data['freeSpin'] = true;
          }
        }

        log['last'] = DateTime.now().toIso8601String();
        log['number'] = log['number'] + 1;

        final jsonNew = json.encode(data);

        await prefs.setString('user_data', jsonNew);
        return json.decode(jsonNew);
      } else {
        final jsonData = userModel.toJson();
        final jsonString = json.encode(jsonData);
        await prefs.setString('user_data', jsonString);
        return jsonData;
      }
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/user_data.json');
      String jsonString = await file.readAsString();
      Map<String, dynamic> jsonData = json.decode(jsonString);
      Map<String, dynamic> log = jsonData["log"];

      if (log['last'] != '') {
        DateTime now = DateTime.now();
        DateTime midnight = DateTime(now.year, now.month, now.day, 0, 0, 0);

        String lastLoginString = log['last'];
        DateTime lastLogin = DateTime.parse(lastLoginString);

        if (!jsonData['freeSpin'] && lastLogin.isBefore(midnight)) {
          jsonData['freeSpin'] = true;
        }
      }

      log['last'] = DateTime.now().toIso8601String();
      log['number'] = log['number'] + 1;

      jsonString = json.encode(jsonData);

      await file.writeAsString(jsonString);
      return json.decode(jsonString);
    }
  }

  Future<void> saveUserDataToFile(UserModel userModel) async {
    if (kIsWeb) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final jsonData = userModel.toJson();
      final jsonString = json.encode(jsonData);

      await prefs.setString('user_data', jsonString);
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/user_data.json');
      final jsonData = userModel.toJson();
      final jsonString = json.encode(jsonData);

      await file.writeAsString(jsonString);
    }
  }
}
