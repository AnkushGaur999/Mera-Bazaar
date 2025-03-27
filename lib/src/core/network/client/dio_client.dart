import 'package:dio/dio.dart';

class DioClient {
  late Dio _dio;

  DioClient() {
    _dio = Dio()
      ..options.baseUrl = "https://demo.com/"
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..options.sendTimeout = const Duration(seconds: 30);
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
      final response =
          await _dio.post(url, queryParameters: queryParameters, data: data);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
