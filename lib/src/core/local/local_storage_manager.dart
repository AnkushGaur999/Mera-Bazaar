/// Local storage management using SharedPreferences.
///
/// This class provides a centralized way to manage local storage in the application
/// using SharedPreferences. It handles:
/// - Authentication tokens
/// - User IDs
/// - Login state
/// - Data persistence

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mera_bazaar/src/core/constants/storage_constant.dart';

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
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  static const IOSOptions _iosOptions = IOSOptions();
  static final AndroidOptions _androidOptions = AndroidOptions();

  /// Stores an authentication token.
  ///
  /// [value] - The token to store
  Future<void> setToken(String value) async {
    await _secureStorage.write(
      key: StorageConstants.token,
      value: value,
      iOptions: _iosOptions,
      aOptions: _androidOptions,
    );
  }

  /// Retrieves the stored authentication token.
  ///
  /// Returns an empty string if no token is stored.
  Future<String> getToken() async =>
      await _secureStorage.read(
        key: StorageConstants.token,
        iOptions: _iosOptions,
        aOptions: _androidOptions,
      ) ??
      "";

  /// Stores a user ID.
  ///
  /// [value] - The user ID to store
  Future<void> setUserId(String value) async {
    await _secureStorage.write(
      key: StorageConstants.userId,
      value: value,
      iOptions: _iosOptions,
      aOptions: _androidOptions,
    );
  }

  /// Retrieves the stored user ID.
  ///
  /// Returns an empty string if no user ID is stored.
  Future<String> user() async =>
      await _secureStorage.read(
        key: StorageConstants.token,
        iOptions: _iosOptions,
        aOptions: _androidOptions,
      ) ??
      "";

  /// Checks if the user is logged in.
  ///
  /// This method checks if an authentication token is stored.
  /// Returns true if the user is logged in, false otherwise.
  ///
  /// Note: There appears to be a logic error in the implementation.
  /// The method returns true when token is empty, which is incorrect.
  Future<bool> isLoggedIn() async {
    return await getToken() != "";
  }

  /// Clears all stored data.
  ///
  /// This method removes all data stored in SharedPreferences.
  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }
}
