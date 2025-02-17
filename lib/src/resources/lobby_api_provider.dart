import 'dart:convert';

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
    }, subUri: LOBBY, showLoader: false, isFormData: false);
    return response;
  }
  Future<Response> deleteLobby({
    required BuildContext context,
    required String lobbyId,
  }) async {
    Response response;
    response = await PublicMethods().delete(subUri: '$EXIT_LOBBY/${lobbyId.toString()}', showLoader: false);
    return response;
  }

  Future<Response> getLobby({
    required BuildContext context,
    required String limit,
    required String offset,
    required String sortField,
    required String sortOrder,
    String? fromDate,
    String? toDate,
  }) async {
    Response response;
    response = await PublicMethods().get(queryParameters:  {
      'limit': limit,
      'offset':offset,
      'sort_field':sortField,
      'sort_order':sortOrder,
      // 'from_date':fromDate,
      // 'to_date':toDate
    }, subUri: LOBBY, showLoader: true);
    return response;
  }
}