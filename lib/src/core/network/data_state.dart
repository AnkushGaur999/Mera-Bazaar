import 'package:mera_bazaar/src/core/exceptions/network_exception.dart';

sealed class DataState<T> {
  final T? data;
  final NetworkException? exception;

  DataState({this.data, this.exception});
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess({required T data}) : super(data: data);
}

class DataError<T> extends DataState<T> {
  DataError({required NetworkException exception})
    : super(exception: exception);
}
