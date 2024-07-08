import 'dart:convert';
import 'dart:io';

// import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:splat_mobile/constants/api_paths.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/constants/public_values.dart';
import 'package:splat_mobile/public/dialog/dialog_notification.dart';
import 'package:splat_mobile/src/blocs/services_bloc.dart';
import 'package:splat_mobile/src/models/player_model.dart';
import 'package:splat_mobile/src/resources/show_dialog.dart';

import '../src/app.dart';
import '../widgets_common/dialogs.dart';

class PublicMethods {
  Client client = Client();
  // final dio = Dio();
  /// Check xem có mạng không
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    // For your reference print the AppDoc directory
    return directory.path;
  }

  Future<File> get localPlayerFile async {
    final path = await localPath;
    return File('$path/player.txt');
  }

  Future<File> writeContentPlayerFile(Map playerInfo) async {
    final file = await localPlayerFile;
    return file.writeAsString(jsonEncode(playerInfo));
  }

  Future<dynamic> readContentPlayer() async {
    try {
      final file = await localPlayerFile;
      // Read the file
      String contents = await file.readAsString();
      PlayerModel playerCreated = PlayerModel.fromJson(jsonDecode(contents));
      return playerCreated;
    } catch (e) {
      // If there is an error reading, return a default String
      return 'Error';
    }
  }

  Future<Response> post({
    required dynamic body,
    required String subUri,
    required bool showLoader,
    required bool isFormData,
  }) async {
    // Client client = Client();
    var connectivityResult = await (Connectivity().checkConnectivity());
    switch(connectivityResult){
      case ConnectivityResult.wifi:
      // TODO: Handle this case.
        break;
      case ConnectivityResult.mobile:
      // TODO: Handle this case.
        break;
      case ConnectivityResult.none:
        show.dialog(dialogWidget: AddDialog.cupertinoDialogTwoBtn(
            context: navigatorKey.currentContext!,
            content: 'No Internet connection found',
            onPressedOK: (){}));
        break;
      case ConnectivityResult.bluetooth:
      // TODO: Handle this case.
        break;
      case ConnectivityResult.ethernet:
      // TODO: Handle this case.
        break;
      case ConnectivityResult.vpn:
      // TODO: Handle this case.
        break;
      case ConnectivityResult.other:
      // TODO: Handle this case.
        break;
    }
    Response response;
    const baseUrl = base_url;
    String? token = '';
   switch(subUri){
     case refresh_token_url:
       token = await storage.read(key: refresh_token_key);
       break;
     default:
       token = await storage.read(key: access_token_key);
       break;
   }
    applicationBloc.changeLoadingStatus();
    await Future.delayed(Duration(seconds: 2));
    try{
      response = await client.post(Uri.parse(baseUrl + subUri),
        body: isFormData ? body : jsonEncode(body),
        headers: isFormData ? headerWithTokenFormData(token??''):headerWithToken(token??''),
      );
    } catch (e) {
      if (applicationBloc.isLoading == true) applicationBloc.changeLoadingStatus();
      response = Response(
          {
          "message": {
          "msg_name":'Service error'
          }
          }['message']!['msg_name'].toString(), 505);
      // if (kDebugMode) {
        print('HieuttError: $e');
      // }
    }

    if (applicationBloc.isLoading == true) applicationBloc.changeLoadingStatus();
    return response;
  }

  Future<Response> get({
    required String subUri,
    required bool showLoader,
    required Map<String, dynamic> queryParameters,
  }) async {
    // Client client = Client();
    Response response;
    showLoader ? DialogWidget().showLoaderDialog() : null;
    String token = await storage.read(key: access_token_key) ?? '';
    response = await client.get(
      // Uri.parse(base_url + subUri),
      Uri.parse(base_url + subUri).replace(queryParameters: queryParameters),
    );
    showLoader ? DialogWidget().dismissLoader() : null;
    return response;
  }

  Future<Response> delete({
    required String subUri,
    required bool showLoader,
  }) async {
    Response response;
    showLoader ? DialogWidget().showLoaderDialog() : null;
    String token = await storage.read(key: access_token_key) ?? '';
    response = await client.delete(Uri.parse(base_url + subUri),
      headers: headerWithToken(token),
    );
    showLoader ? DialogWidget().dismissLoader() : null;
    return response;
  }

  static Future<PlayerModel?> getNowUser() async {
    String? stringUserNow = await storage.read(
        key: user_info);
    PlayerModel? userNow = PlayerModel.fromJson(jsonDecode(stringUserNow??''));
    return userNow;
  }
}

