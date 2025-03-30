import 'package:dio/dio.dart';
import 'package:mera_bazaar/src/core/local/local_storage_manager.dart';

import 'auth_interceptor.dart';

class DioClient {
  final LocalStorageManager localStorageManager;

  late Dio _dio;

  DioClient({required this.localStorageManager}) {
    _dio =
        Dio()
          ..options.baseUrl = "https://demo.com/"
          ..options.connectTimeout = const Duration(seconds: 30)
          ..options.receiveTimeout = const Duration(seconds: 30)
          ..options.sendTimeout = const Duration(seconds: 30)
          ..interceptors.add(AuthInterceptor(token: localStorageManager.token));
  }

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
