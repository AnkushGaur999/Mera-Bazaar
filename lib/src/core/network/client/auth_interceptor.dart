import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final String token;

  AuthInterceptor({required this.token});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer $token';
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    super.onRequest(options, handler);
  }
}
