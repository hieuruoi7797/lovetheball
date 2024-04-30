import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:splat_mobile/constants/api_paths.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/constants/public_values.dart';
import 'package:splat_mobile/src/models/player_model.dart';

import '../widgets_common/dialogs.dart';

class PublicMethods {
  final dio = Dio();

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
    // String encodedData = Uri.encodeQueryComponent(body.toString());
    // final formData = FormData.fromMap(isFormData? body:{});
    // showLoader ? DialogWidget().showLoaderDialog() : null;
   response = await dio.post(baseUrl + subUri,
        data: isFormData ? body : jsonEncode(body),
        options: Options(
          contentType: isFormData ?
                        Headers.formUrlEncodedContentType :
                          Headers.jsonContentType,
          headers: headerWithToken(token ?? ''),
        )
        );
    // showLoader ? DialogWidget().dismissLoader() : null;
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
    response = await dio.get(
      base_url + subUri,
      queryParameters: queryParameters,
      options: Options(
        headers:  headerWithToken(token)
      ),
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
    response = await dio.delete(base_url + subUri,
      options: Options(
          headers:  headerWithToken(token)
      ),
    );
    showLoader ? DialogWidget().dismissLoader() : null;
    return response;
  }
}
