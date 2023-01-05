import 'package:enhance/app/shared/models/community_model.dart';
import 'package:enhance/app/shared/models/user_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<bool> setPassword(String password) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString('password', password);
  }

  static Future<String> getPassword() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String password = pref.getString('password');
    return password;
  }

  static Future<bool> setSelectedCommunity(CommunityModel community) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString('community', jsonEncode(community.toJson()));
  }

  static Future<CommunityModel> getSelectedCommunity() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String jsonUser = pref.getString('community');
    if (jsonUser != null) {
      final CommunityModel community =
          CommunityModel.fromJson(jsonDecode(jsonUser));
      return community;
    } else {
      return null;
    }
  }

  static Future<bool> setUser(UserModel user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString('user', jsonEncode(user.toJson()));
  }

  static Future<UserModel> getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String jsonUser = pref.getString('user');
    if (jsonUser != null) {
      final UserModel user = UserModel.fromJson(jsonDecode(jsonUser));
      return user;
    } else {
      return null;
    }
  }

  static Future deleteUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("user", null);
  }
  static Future deleteSelectedCommunity() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("community", null);
  }
}
