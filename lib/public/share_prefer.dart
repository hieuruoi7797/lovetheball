import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splat_mobile/src/models/info_login_model.dart';

import '../constants/constant_values.dart';

class SharePreferUtils {
  static const FlutterSecureStorage secure_storage = FlutterSecureStorage();
  static Future<String> getUserLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(USER_LOGIN) ?? '';
  }
  static Future<void> saveInfoRegister(InfoLoginModel infoLogin) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('USER_INFO_REGISTER', jsonEncode(infoLogin.toJson()).toString());
  }
  static Future<void> removeInfoRegister() async {
    await SharePreferUtils.secure_storage.write(key:'USER_INFO_REGISTER',value: "");
  }
  static Future<dynamic> getInfoLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String info = pref.getString("USER_INFO_REGISTER") ?? '';
    return InfoLoginModel.fromJson(jsonDecode(info));
  }

  static Future<String> getAvatar(String userName) async {
    String bannerPath = "";
    SharedPreferences pref = await SharedPreferences.getInstance();
    bannerPath = pref.getString("avatar_$userName") ?? "";
    print('getAvatar ${bannerPath}');
    return bannerPath;
  }

  // Ghi nhớ tài khoản đăng nhập
  static Future<bool> saveLoginSharedPreference(islogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(loginSharedPreference, islogin);
  }

  //kiem tra da login hay chưa
  static Future getUserSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(loginSharedPreference);
  }


  static Future<void> saveAvatar(String avartar, String userName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("avatar_$userName", avartar);
  }

}