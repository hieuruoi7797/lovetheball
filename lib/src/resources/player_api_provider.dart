import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:splat_record/widgets_common/loading.dart';

import '../../constants/api_paths.dart';

class PlayerApiProvider {
  Client client = Client();
  final _baseUrl = "https://ample-crawdad-kind.ngrok-free.app/v1";

  Future<Response> createPlayer({
    required BuildContext context,
    required String name,
  }) async {
    Response response;
    DialogWidget().showLoaderDialog(context);
    response = await client.post(Uri.parse(_baseUrl + PLAYERS),
        body: jsonEncode({
          "name": name,
          // "gender": 0,
          // "birth_date": "",
          // "email": "",
          // "phone": ""
        }));
    Future.delayed(Duration.zero, () => Navigator.pop(context));
    if (response.statusCode == 200) {
      return response;
    } else {
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(context, "FAIL"));
      return response;
    }
  }
}
