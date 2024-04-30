import 'package:dio/dio.dart';
import 'package:splat_mobile/public/public_methods.dart';
import 'package:splat_mobile/widgets_common/dialogs.dart';

import '../../constants/api_paths.dart';
import '../../constants/constant_values.dart';

class PlayerApiProvider {

  Future<Response> getPlayer({
    String? matchId,
  }) async {
    Response response;
    response = await PublicMethods().get(
        subUri: user_path,
        showLoader: true,
        queryParameters: {'match_id': matchId ?? ""});
    if (response.statusCode == 200) {
      return response;
    } else {
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(error_fail));
      return response;
    }
  }
}


