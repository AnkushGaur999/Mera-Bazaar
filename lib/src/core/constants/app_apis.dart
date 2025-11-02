/// API endpoint constants for the application.
///
/// This class defines constant string values for all API endpoints used in the application.
/// It provides a centralized place for managing API URLs, making it easier to update
/// endpoints if the API changes.

/// Constants for API endpoints.
///
/// This class provides a centralized place for all API endpoints used in the application.
/// Using constants instead of string literals helps prevent typos and makes it easier
/// to update endpoints if the API changes.
class AppApis {
  /// Base URL for all API requests
  static const BASE_URL = "https://fakestoreapi.in/api/";

  /// Endpoint for sending OTP to a phone number
  static const SEND_OTP = "sendOtp";

  /// Endpoint for verifying an OTP
  static const VERIFY_OTP = "verifyOtp";

  /// Endpoint for retrieving user information
  static const GET_USER = "user";

  /// Endpoint for retrieving products
  static const GET_PRODUCTS = "products";

  /// Endpoint for retrieving a product
  static const GET_PRODUCT = "products";

}
