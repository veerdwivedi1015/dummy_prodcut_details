import 'package:dio/dio.dart';

class DioConfig {
  static Dio? _instance;

  DioConfig._internal() {
    final options = BaseOptions(
      baseUrl: 'https://fakestoreapi.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
    _instance = Dio(options);
  }

  static Dio get instance {
    if (_instance == null) {
      DioConfig._internal();
    }
    return _instance!;
  }
}
