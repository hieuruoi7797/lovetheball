import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/dialogs.dart';

class BaseService {
  Dio dio;

  BaseService(this.dio);

  Future<dynamic> createPost(String subUri,
      {bool showLoading = false,
      dynamic,
      dynamic body,
      required BuildContext context}) async {
    if (showLoading == true) {
      DialogAlert.showLoading(context);
    }
    try {
      final Response response = await dio.post(subUri, data: body?? {});
      if (showLoading == true) {
        DialogAlert.dismissLoading(context);
      }
      return response;
    }catch (e){
    }
  }
}
