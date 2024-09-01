import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:splat_mobile/constants/api_paths.dart';

import '../../public/public_methods.dart';

class InvitationApiProvider{
  Future<Response> getUser({
    required BuildContext context,
  }) async {
    Response response;
    response = await PublicMethods().get(
        subUri: user_path,
        showLoader: false,
        queryParameters:  {
          'limit':'100',
          'offset':'0'
        });
    return response;
  }

  Future<Response> getUserById({
    required BuildContext context,
    required String userId,
  }) async {
    Response response;
    response = await PublicMethods().get(
        subUri: "$user_path/$userId",
        showLoader: false,
        queryParameters:  {});
    return response;
  }

}