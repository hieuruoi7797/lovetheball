import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constant_values.dart';

class SharePreferUtils {
  static Future<String> getUserLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(USER_LOGIN) ?? '';
  }

  static Future<String> getAvatar(String userName) async {
    String bannerPath = "";
    SharedPreferences pref = await SharedPreferences.getInstance();
    bannerPath = pref.getString("avatar$userName") ?? "";
    return bannerPath;
  }

  static Future<void> saveAvatar(String avartar, String userName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("avatar$userName", avartar);
  }

}