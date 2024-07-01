
import 'dart:io';

class AppGlobal{
  File _avatarFile = new File('');
  File get avatarFile => _avatarFile;

  setAvatarFile(String file) {
    _avatarFile = File(file);
  }
}
final appGlobal = AppGlobal();