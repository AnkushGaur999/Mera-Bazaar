import 'package:dio/dio.dart';

sealed class DataState<T> {
  final T? data;
  final DioException? exception;

  DataState({this.data, this.exception});
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess({required T data}) : super( data: data);
}

class DataError<T> extends DataState<T> {
  DataError({ required DioException exception})
      : super(exception: exception);
}
