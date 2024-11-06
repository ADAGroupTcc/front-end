
import 'package:addaproject/sdk/model/User.dart';
import 'package:addaproject/utils/circularlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'model/Channel.dart';
import 'model/Message.dart';

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

  Future<List<Message>?> listMessagesCached() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonMessages = prefs.getString('messages');
    if (jsonMessages == null) {
      return null;
    }

    final res = jsonDecode(jsonMessages) as List<dynamic>;
    return res.map((message) => Message.fromJson(message)).toList();;
  }

  Future<void> saveMessages(CircularList<Message> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonMessages = jsonEncode(messages.map((message) => message.toJson()).toList());
    await prefs.setString('messages', jsonMessages);
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}