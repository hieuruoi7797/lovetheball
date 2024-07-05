
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../src/models/player_model.dart';

class AppGlobal{
  File _avatarFile = new File('');
  File get avatarFile => _avatarFile;
  final _updateAvatarBehavior= BehaviorSubject<File>();
  Stream<File> get updateAvatarBehavior => _updateAvatarBehavior.stream;
  setAvatarFile(File file) {
    _updateAvatarBehavior.sink.add(_avatarFile = file);
  }

  createFileFromString(PlayerModel? nowUserInfo) async {
    final encodedStr = nowUserInfo?.avatar??'';
    Uint8List bytes = base64.decode(encodedStr);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".jpg");
    await file.writeAsBytes(bytes);
    setAvatarFile(file);
  }
}
final appGlobal = AppGlobal();