/// Network client implementation using Dio.
///
/// This class provides a wrapper around the Dio HTTP client with:
/// - Configurable base URL
/// - Timeout settings
/// - Authentication interceptor
/// - Error handling
/// - Simplified API for common HTTP methods

import 'package:dio/dio.dart';
import 'package:mera_bazaar/src/core/local/local_storage_manager.dart';

import 'auth_interceptor.dart';

/// A wrapper around Dio HTTP client with authentication and error handling.
///
/// This class provides a simplified API for making HTTP requests with:
/// - Automatic authentication token injection
/// - Consistent timeout settings
/// - Error handling
/// - Base URL configuration
class DioClient {
  /// Local storage manager for accessing authentication tokens
  final LocalStorageManager localStorageManager;

  /// The underlying Dio instance
  late Dio _dio;

  /// Creates a new DioClient with the specified local storage manager.
  ///
  /// Initializes the Dio instance with:
  /// - Base URL configuration
  /// - Timeout settings (30 seconds for connect, receive, and send)
  /// - Authentication interceptor
  DioClient({required this.localStorageManager}) {
    _dio =
        Dio()
          ..options.baseUrl = "https://demo.com/"
          ..options.connectTimeout = const Duration(seconds: 30)
          ..options.receiveTimeout = const Duration(seconds: 30)
          ..options.sendTimeout = const Duration(seconds: 30)
          ..interceptors.add(AuthInterceptor(token: ""));
  }

  /// Performs a GET request to the specified URL.
  ///
  /// [url] - The endpoint to request (will be appended to the base URL)
  /// [queryParameters] - Optional query parameters to include in the request
  ///
  /// Returns a [Response] object containing the server's response.
  /// Throws [DioException] if the request fails.
  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  /// Performs a POST request to the specified URL.
  ///
  /// [url] - The endpoint to request (will be appended to the base URL)
  /// [queryParameters] - Optional query parameters to include in the request
  /// [data] - The data to send in the request body
  ///
  /// Returns a [Response] object containing the server's response.
  /// Throws [DioException] if the request fails.
  Future<Response> post({
    required String url,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _dio.post(
        url,
        queryParameters: queryParameters,
        data: data,
      );
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
