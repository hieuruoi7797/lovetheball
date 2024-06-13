import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:splat_mobile/src/models/info_login_model.dart';

import '../constants/constant_values.dart';

class SharePreferUtils {
  static Future<String> getUserLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(USER_LOGIN) ?? '';
  }
  static Future<void> saveInfoRegister(InfoLoginModel infoLogin) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('USER_INFO_REGISTER', jsonEncode(infoLogin.toJson()).toString());
  }
  static Future<dynamic> getInfoLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String info = pref.getString("USER_INFO_REGISTER") ?? '';
    return InfoLoginModel.fromJson(jsonDecode(info));
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