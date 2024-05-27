import 'dart:convert';

// import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:splat_mobile/constants/api_paths.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/public/public_methods.dart';
import 'package:splat_mobile/src/app.dart';
import 'package:splat_mobile/src/models/base_api_model.dart';
import 'package:splat_mobile/widgets_common/dialogs.dart';

class AuthenticationiApiProvider {
  Response? response;


  Future<Response?> login({
    required String inputEmail,
    required String inputPasswords,
  }) async {
    var map = 'username=$inputEmail&password=$inputPasswords';
    response = await PublicMethods().post(
        body: map,
        subUri: login_path,
        showLoader: true,
        isFormData: true,
    );
    if (response != null){
      if (response!.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    }

  }

  Future<Response?> testToken() async {
    response = await PublicMethods().post(
        body: {},
        subUri: test_token_path,
        showLoader: false,
        isFormData: false
    );
      if (response!.statusCode == 200) {
        return response;
      }else{
        await Future.delayed(
            Duration.zero, () => DialogWidget().showFailDialog(jsonDecode(response!.body)['detail']));
        return null;
      }

  }

  Future<Response?> refreshToken() async {
    response = await PublicMethods().post(
        body: {},
        subUri: refresh_token_url,
        showLoader: true,
        isFormData: false
    );
    if (response!.statusCode == 200) {
      return response;
    }else{
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(jsonDecode(response!.body)['detail']));
      return null;
    }
  }

  Future<BaseApiModel?> createUser({
    required String email,
  }) async {
    Response response;
    response = await PublicMethods().post(
        body: {
            "email": email,
          },
        subUri: API_REGISTER_EMAIL,
        showLoader: true,
        isFormData: false,
    );
    BaseApiModel _res = BaseApiModel.fromJson(jsonDecode(response.body));
    if (_res.message["status_code"] == 200) {
      if (kDebugMode) {
        print(_res);
      }
      return _res;
    } else {
      return _res;
    }
  }
  Future<BaseApiModel?> verifiCreateUser({
    required String email,
    required String otp,
  }) async {
    Response response;
    response = await PublicMethods().post(
      body: {
        "email":email,
        "otp":otp
      },
      subUri: API_REGISTER_VERIFI,
      showLoader: true,
      isFormData: false,
    );
    BaseApiModel _res = BaseApiModel.fromJson(jsonDecode(response.body));
    if (_res.message["status_code"] == 200) {
      if (kDebugMode) {
        print(_res);
      }
      return _res;
    } else {
      // await Future.delayed(
      //     Duration.zero, () => DialogWidget().showFailDialog(error_fail));
      return _res;
    }
  }

  Future<BaseApiModel?> createUserLogin({
    required Map body,
  }) async {
    Response response;
    response = await PublicMethods().post(
      body: body,
      subUri: API_CREATE_USER,
      showLoader: true,
      isFormData: false,
    );
    BaseApiModel _res = BaseApiModel.fromJson(jsonDecode(response.body));
    if (_res.message["status_code"] == 200) {
      if (kDebugMode) {
        print(_res);
      }
      return _res;
    } else {
      return _res;
    }
  }

  Future<Response?> logout() async {
    Response response;
    response = await PublicMethods().delete(
      subUri: logout_path,
      showLoader: true,
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      // await Future.delayed(
      //     Duration.zero, () => DialogWidget().showFailDialog(error_fail));
      return null;
    }
  }
}
