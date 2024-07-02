
import 'dart:io';

class AppGlobal{
  File _avatarFile = new File('');
  File get avatarFile => _avatarFile;

  setAvatarFile(File file) {
    _avatarFile = file;
  }
}
final appGlobal = AppGlobal();