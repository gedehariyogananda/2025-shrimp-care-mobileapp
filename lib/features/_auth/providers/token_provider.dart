import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  void setToken(String keyName, dynamic key) async {
    SharedPreferences value = await _pref;

    value.setString(keyName, key);
  }

  Future<String?> getDataLocal(String key) async {
    SharedPreferences value = await _pref;

    return value.getString(key);
  }

  void logOut(BuildContext context, {VoidCallback? onSuccess}) async {
    final value = await _pref;

    value.clear();

    onSuccess?.call();
  }
}
