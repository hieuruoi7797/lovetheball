
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:splat_record/src/models/player_model.dart';

class PublicMethod {
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
}