import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:splat_record/src/models/player_model.dart';
final storage = new FlutterSecureStorage();

// Write value

class PublicValues {
  PlayerModel userNow = PlayerModel(id: '', name: '');
}
PublicValues publicValues = PublicValues();
