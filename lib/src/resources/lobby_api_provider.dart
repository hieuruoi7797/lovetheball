import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../../constants/api_paths.dart';
import '../../public/public_methods.dart';

class LobbyApiProvider{
  Future<Response> createLobby({
    required BuildContext context,
    required String name,
    required String matchSettingId,
    required String scheduledAt,
  }) async {
    Response response;
    response = await PublicMethods().post(body:{
      "name": name,
      "match_setting_id": matchSettingId,
      "scheduled_at": scheduledAt
    }, subUri: LOBBY, showLoader: true, isFormData: false);
    return response;
  }
}