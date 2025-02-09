import 'dart:developer';

// import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:splat_mobile/public/public_methods.dart';

import '../../constants/api_paths.dart';
import '../../constants/constant_values.dart';
import '../../widgets_common/dialogs.dart';

class GameOnApiProvider {

  GameOnApiProvider();

  Future<Response> finishMatch({
    required String matchId,
  }) async {
    Response response;
    response = await PublicMethods().post(
        body: {
          "match_id": matchId,
        },
        subUri: finish_match_path,
        showLoader: true,
        isFormData: false);
    if (response.statusCode == 200) {
      return response;
    } else {
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(error_fail));
      return response;
    }
  }

  setStatsList(data) {

  }
}
