
import 'package:addaproject/sdk/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalCache {
  Future<void> saveUserSession(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  Future<User?> getUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonUser = prefs.getString('user');
    if (jsonUser == null) {
      return null;
    }

    final res = jsonDecode(jsonUser);
    return User.fromJson(res);
  }
}