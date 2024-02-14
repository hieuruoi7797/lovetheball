import 'dart:convert';

import 'package:http/http.dart';
import 'package:splat_mobile/constants/api_paths.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/public/public_methods.dart';
import 'package:splat_mobile/widgets_common/dialogs.dart';

class AuthorizationApiProvider {
  Client client = Client();

  Future<Response?> login({
    required String email,
    required String password,
  }) async {
    Response response;
    var map = <String, dynamic>{};
    map['username'] = email;
    map['password'] = password;
    response = await PublicMethods().post(
        body: map,
        subUri: LOGIN,
        // headers: headerFormDataWithoutToken,
        showLoader: true,
        isFormData: true,
    );

    // DialogWidget().showLoaderDialog();
    // response = await client.post(
    //   Uri.parse(_baseUrl + LOGIN),
    //   body: map,
    //   headers: headerFormData,
    // );
    // Future.delayed(Duration.zero, () => DialogWidget().dismissLoader());
    if (response.statusCode == 200) {
      return response;
    } else {
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(jsonDecode(response.body)['error']));
      return null;
    }
  }

  Future<Response?> testToken() async {
    Response response;
    // DialogWidget().showLoaderDialog();
    response = await PublicMethods().post(
        body: {},
        subUri: TEST_TOKEN,
        showLoader: false,
        isFormData: false
    );
    if (response.statusCode == 200) {
      return response;
    }else{
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(jsonDecode(response.body)['detail']));
      return null;
    }
  }

  Future<Response?> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    Response response;
    response = await PublicMethods().post(
        body: {
            "name": name,
            "gender": 0,
            "birth_date": "07/07/1997",
            "email": email,
            "phone": "",
            "avartar": "",
            "password": password
          },
        subUri: USERS,
        // headers: headerJsonWithoutToken,
        showLoader: true,
        isFormData: false,
    );
    if (response.statusCode == 201) {
      return response;
    } else {
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(ERROR_FAIL));
      return null;
    }
  }
}
