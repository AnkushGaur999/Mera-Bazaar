/// Data state representation for handling API responses.
///
/// This file defines a sealed class hierarchy for representing the state of data
/// operations, particularly API responses. It provides a type-safe way to handle
/// both successful responses and errors.

import 'package:mera_bazaar/src/core/exceptions/network_exception.dart';

/// Base class for representing the state of data operations.
///
/// This sealed class provides a unified way to represent both successful and
/// failed data operations. It contains:
/// - [data] - The successful data result (if any)
/// - [exception] - The error that occurred (if any)
///
/// Subclasses [DataSuccess] and [DataError] provide specific implementations
/// for success and error cases respectively.
sealed class DataState<T> {
  /// The data result of the operation, if successful
  final T? data;

  /// The exception that occurred, if the operation failed
  final MyBazaarException? exception;

  /// Creates a new [DataState] with optional data and exception.
  ///
  /// [data] - The successful data result
  /// [exception] - The error that occurred
  DataState({this.data, this.exception});
}

/// Represents a successful data operation.
///
/// This class extends [DataState] to represent a successful data operation
/// with the resulting data.
class DataSuccess<T> extends DataState<T> {
  /// Creates a new [DataSuccess] with the specified data.
  ///
  /// [data] - The successful data result
  DataSuccess({required T data}) : super(data: data);
}

/// Represents a failed data operation.
///
/// This class extends [DataState] to represent a failed data operation
/// with the exception that occurred.
class DataError<T> extends DataState<T> {
  /// Creates a new [DataError] with the specified exception.
  ///
  /// [exception] - The error that occurred
  DataError({required MyBazaarException exception})
    : super(exception: exception);
}
