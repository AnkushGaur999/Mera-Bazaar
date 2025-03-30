import 'package:mera_bazaar/src/core/constants/storage_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageManager {
  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setToken(String value) async {
    await _sharedPreferences.setString(StorageConstants.token, value);
  }

  String get token =>
      _sharedPreferences.getString(StorageConstants.token) ?? "";

   Future<void> setUserId(String value) async {
    await _sharedPreferences.setString(StorageConstants.userId, value);
  }

  static String get userId =>
      _sharedPreferences.getString(StorageConstants.userId) ?? "";

  Future<bool> isLoggedIn() async {
    if (token.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> clear() async {
    await _sharedPreferences.clear();
  }
}
