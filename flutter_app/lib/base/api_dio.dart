import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'base_service.dart';

class ApiDio {
  static ApiDio? instance;
  static BaseService? baseService;

  ApiDio(BuildContext context) {
    final BaseOptions options = BaseOptions(
      baseUrl: "https://google.com/",
    );

    final Dio dio = Dio(options);

    dio
      ..interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
      ));

    baseService = BaseService(dio);
  }

  static BaseService? getInstance(BuildContext context) {
    instance = ApiDio(context);
    return _getBaseService();
  }

  static BaseService? _getBaseService() {
    return baseService;
  }
}
