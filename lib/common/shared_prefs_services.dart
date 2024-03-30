import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SharedPrefsServices {
  final Future<SharedPreferences> sharedPreferences =
      SharedPreferences.getInstance();

  void saveToken(token, refreshToken) async {
    SharedPreferences prefs = await sharedPreferences;
    prefs
        .setString('token', token)
        .then((value) => debugPrint("saved token -> $token"));
    prefs
        .setString('refreshToken', refreshToken)
        .then((value) => debugPrint("saved refreshToken -> $refreshToken"));
  }

  Future<String?> getToken() async {
    SharedPreferences pref = await sharedPreferences;
    return pref.getString('token');
  }

  Future<String?> getRefreshToken() async {
    SharedPreferences pref = await sharedPreferences;
    return pref.getString('refreshToken');
  }
}
