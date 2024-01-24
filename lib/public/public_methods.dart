import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:splat_record/constants/api_paths.dart';
import 'package:splat_record/constants/constant_values.dart';
import 'package:splat_record/constants/public_values.dart';
import 'package:splat_record/src/blocs/player/user_bloc.dart';
import 'package:splat_record/src/models/player_model.dart';

import '../widgets_common/dialogs.dart';

class PublicMethods {
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
    required Map body,
    required String subUri,
    // required Map<String, String> headers,
    required bool showLoader,
    required bool isFormData,
  }) async {
    Client client = Client();
    Response response;
    const baseUrl = BASEURL;
    String? token = await storage.read(key: "access_token");
    showLoader ? DialogWidget().showLoaderDialog() : null;
    response = await client.post(Uri.parse(baseUrl + subUri),
        body: isFormData ? body : jsonEncode(body),
        headers: isFormData
            ? headerWithTokenFormData(token ?? '')
            : headerWithToken(token ?? ''));
    showLoader ? DialogWidget().dismissLoader() : null;
    return response;
  }

  Future<Response> get({
    required String subUri,
    required bool showLoader,
    required Map<String, dynamic> queryParameters,
  }) async {
    Client client = Client();
    Response response;
    showLoader ? DialogWidget().showLoaderDialog() : null;
    String token = await storage.read(key: "access_token") ?? '';
    response = await client.get(
      Uri.parse(BASEURL + subUri).replace(queryParameters: queryParameters),
      headers: headerWithToken(token),
    );
    showLoader ? DialogWidget().dismissLoader() : null;
    return response;
  }
}
