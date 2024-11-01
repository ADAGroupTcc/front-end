
import 'package:addaproject/sdk/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'model/Channel.dart';

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

  Future<List<Channel>?> listChannelCached() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonChannels = prefs.getString('channels');
    if (jsonChannels == null) {
      return null;
    }

    final res = jsonDecode(jsonChannels) as List<dynamic>;
    return res.map((channel) => Channel.fromJson(channel)).toList();
  }

  Future<void> saveChannels(List<Channel> channels) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonChannels = jsonEncode(channels.map((channel) => channel.toJson()).toList());
    await prefs.setString('channels', jsonChannels);
  }
}