import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrimp_care_mobileapp/base/constant/app_constant.dart';

class TokenProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String? _token;
  String? _userId;

  String? get token => _token;
  String? get userId => _userId;

  void setToken(String keyName, dynamic key) async {
    SharedPreferences value = await _pref;

    value.setString(keyName, key);
  }

  Future<String?> getDataLocal(String key) async {
    SharedPreferences value = await _pref;

    String? data = value.getString(key);
    if (key == AppConstants.keySharedPrefToken) {
      if (data != null) {
        _token = data;
        notifyListeners();
      } else {
        _token = null;
        notifyListeners();
      }

      return _token;
    } else if (key == AppConstants.keySharedPrefUserId) {
      if (data != null) {
        _userId = data;
        notifyListeners();
      } else {
        _userId = null;
        notifyListeners();
      }

      return _userId;
    }

    throw Exception('Tidak ada key yang valid: $key');
  }

  void logOut(BuildContext context) async {
    final value = await _pref;

    value.clear();

    // todo: redirect ke login page
  }
}
