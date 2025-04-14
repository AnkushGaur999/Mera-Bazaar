/// Network exception handling for API requests.
///
/// This file defines a [NetworkException] class that provides a standardized way
/// to handle and represent network-related errors in the application. It extends
/// [Equatable] for easy comparison and implements [Exception] for proper error handling.

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mera_bazaar/src/core/network/model/network_error_model.dart';

/// A standardized exception for handling network-related errors.
///
/// This class extends [Equatable] and implements [Exception] to provide a
/// consistent way to handle network errors throughout the application. It contains:
/// - [message] - A human-readable error message
/// - [statusCode] - The HTTP status code of the response (if applicable)
///
/// The class provides factory constructors to create instances from different
/// error sources:
/// - [fromDioError] - Creates an instance from a DioException
/// - [fromException] - Creates an instance from a generic Exception
///
/// Example usage:
/// ```dart
/// try {
///   // some network request
/// } on DioException catch (e) {
///   throw NetworkException.fromDioError(e);
/// }
/// ```
class NetworkException extends Equatable implements Exception {
  /// The human-readable error message
  late final String message;

  /// The HTTP status code of the response (if applicable)
  late final int? statusCode;

  /// Creates a [NetworkException] from a [DioException].
  ///
  /// This constructor analyzes the [DioException] and sets appropriate
  /// error messages based on the exception type:
  /// - Connection timeouts
  /// - Request cancellations
  /// - Bad responses
  /// - Network connectivity issues
  /// - And more
  ///
  /// [dioException] - The DioException to convert
  NetworkException.fromDioError(DioException dioException) {
    statusCode = dioException.response?.statusCode;

    switch (dioException.type) {
      case DioExceptionType.cancel:
        message = 'Request to API server was cancelled';
        break;

      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout with API server';
        break;

      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout in connection with API server';
        break;

      case DioExceptionType.sendTimeout:
        message = 'Send timeout in connection with API server';
        break;

      case DioExceptionType.connectionError:
        if (dioException.error.runtimeType == SocketException) {
          message = 'Please check your internet connection';
          break;
        } else {
          message = 'Unexpected error occurred';
          break;
        }

      case DioExceptionType.badCertificate:
        message = 'Bad Certificate';
        break;

      case DioExceptionType.badResponse:
        final model = NetworkErrorModel.fromJson(
          dioException.response?.data as Map<String, dynamic>,
        );
        message = model.statusMessage ?? 'Unexpected bad response';
        break;

      case DioExceptionType.unknown:
        message = 'Unexpected error occurred';
        break;
    }
  }

  /// Creates a [NetworkException] from a generic [Object] exception.
  ///
  /// This constructor handles non-Dio exceptions and provides appropriate
  /// error messages based on the exception type.
  ///
  /// [e] - The exception to convert
  NetworkException.fromException(Object e) {
    statusCode = 500;
    if (e is FormatException) {
      message = 'Unexpected error occurred';
    } else {
      message = "Something went wrong.\nPlease try again later.";
    }
  }

  /// Returns a list of properties to use for equality comparison.
  ///
  /// This method is used by [Equatable] to determine if two instances
  /// of [NetworkException] are equal.
  @override
  List<Object?> get props => [message, statusCode];
}
