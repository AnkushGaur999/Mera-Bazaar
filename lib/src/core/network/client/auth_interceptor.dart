/// Authentication interceptor for Dio HTTP client.
///
/// This interceptor automatically adds authentication headers to all requests:
/// - Authorization header with Bearer token
/// - Content-Type header for JSON
/// - Accept header for JSON responses

import 'package:dio/dio.dart';

/// Interceptor that adds authentication and content type headers to requests.
///
/// This class extends Dio's [Interceptor] to automatically inject:
/// - Authorization header with the provided token
/// - Content-Type header for JSON requests
/// - Accept header for JSON responses
class AuthInterceptor extends Interceptor {
  /// The authentication token to include in requests
  final String token;

  /// Creates a new [AuthInterceptor] with the specified token.
  ///
  /// [token] - The authentication token to include in the Authorization header
  AuthInterceptor({required this.token});

  /// Adds authentication and content type headers to the request.
  ///
  /// This method is called before each request is sent and adds:
  /// - Authorization: Bearer {token}
  /// - Content-Type: application/json
  /// - Accept: application/json
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer $token';
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    super.onRequest(options, handler);
  }
}
