import 'dart:convert';

import 'package:ecommerce_app/features/auth/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  static String _isFirstTime = "isFirstTime";
  static String _user = "user";
  static String _token = "token";

  static Future<void> setAppOpenFlag() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(_isFirstTime, false);
  }

  static Future<bool> get isFirstTime async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final result = await pref.getBool(_isFirstTime);
    return result ?? true;
  }

  static Future<User?> get user async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final encryptedUser = await pref.getString(_user);
    if (encryptedUser != null) {
      return User.fromJson(json.decode(encryptedUser));
    }
    else {
      return null;
    }
  }

  static setUser(User user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final mappedUser = user.toJson();
    final encryptedUser = json.encode(mappedUser);
    await pref.setString(_user, encryptedUser);
  }

  static removeUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(_user);
  }

  static Future<String> get token async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getString(_token) ?? "";
  }

  static Future<void> setToken(String token) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(_token, token);
  }

  static removeToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(_token);
  }
}
