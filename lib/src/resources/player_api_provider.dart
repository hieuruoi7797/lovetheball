import 'package:http/http.dart' show Client, Response;
import 'package:splat_mobile/public/public_methods.dart';
import 'package:splat_mobile/widgets_common/dialogs.dart';

import '../../constants/api_paths.dart';
import '../../constants/constant_values.dart';

class PlayerApiProvider {
  Client client = Client();



  Future<Response> getPlayer({
    String? matchId,
  }) async {
    Response response;
    response = await PublicMethods().get(
        subUri: USERS,
        showLoader: true,
        queryParameters: {'match_id': matchId ?? ""});
    // DialogWidget().showLoaderDialog();
    // String token = await storage.read(key: "access_token") ?? '';
    // response = await client.get(
    //   Uri.parse(_baseUrl + USERS)
    //       .replace(queryParameters: {'match_id': matchId ?? ""}),
    //   headers: headerWithToken(token),
    // );
    // Future.delayed(Duration.zero, () => Navigator.pop(navigatorKey.currentContext!));
    if (response.statusCode == 200) {
      return response;
    } else {
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(ERROR_FAIL));
      return response;
    }
  }
}


