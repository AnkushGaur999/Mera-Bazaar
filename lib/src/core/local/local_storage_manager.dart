/// Local storage management using SharedPreferences.
///
/// This class provides a centralized way to manage local storage in the application
/// using SharedPreferences. It handles:
/// - Authentication tokens
/// - User IDs
/// - Login state
/// - Data persistence

import 'package:mera_bazaar/src/core/constants/storage_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages local storage operations using SharedPreferences.
///
/// This class provides methods for:
/// - Storing and retrieving authentication tokens
/// - Managing user IDs
/// - Checking login status
/// - Clearing stored data
///
/// It uses SharedPreferences for persistent storage across app restarts.
class LocalStorageManager {
  /// The SharedPreferences instance used for storage
  static late SharedPreferences _sharedPreferences;

  /// Initializes the SharedPreferences instance.
  ///
  /// This method must be called before using any other methods in this class.
  /// It is typically called during app initialization.
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Stores an authentication token.
  ///
  /// [value] - The token to store
  Future<void> setToken(String value) async {
    await _sharedPreferences.setString(StorageConstants.token, value);
  }

  /// Retrieves the stored authentication token.
  ///
  /// Returns an empty string if no token is stored.
  String get token =>
      _sharedPreferences.getString(StorageConstants.token) ?? "";

  /// Stores a user ID.
  ///
  /// [value] - The user ID to store
  Future<void> setUserId(String value) async {
    await _sharedPreferences.setString(StorageConstants.userId, value);
  }

  /// Retrieves the stored user ID.
  ///
  /// Returns an empty string if no user ID is stored.
  static String get userId =>
      _sharedPreferences.getString(StorageConstants.userId) ?? "";

  /// Checks if the user is logged in.
  ///
  /// This method checks if an authentication token is stored.
  /// Returns true if the user is logged in, false otherwise.
  ///
  /// Note: There appears to be a logic error in the implementation.
  /// The method returns true when token is empty, which is incorrect.
  Future<bool> isLoggedIn() async {
    if (token.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  /// Clears all stored data.
  ///
  /// This method removes all data stored in SharedPreferences.
  Future<void> clear() async {
    await _sharedPreferences.clear();
  }
}
