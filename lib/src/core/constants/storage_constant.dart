/// Storage key constants for local storage.
///
/// This class defines constant string keys used for storing and retrieving
/// data from local storage. These keys are used by the [LocalStorageManager]
/// to ensure consistent access to stored data.

/// Constants for local storage keys.
///
/// This class provides a centralized place for all storage keys used in the application.
/// Using constants instead of string literals helps prevent typos and makes it easier
/// to update keys if needed.
class StorageConstants {
  /// Key for storing the authentication token
  static const String token = "token";

  /// Key for storing the user ID
  static const String userId = "userId";
}
