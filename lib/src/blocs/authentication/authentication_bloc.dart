import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/public/app_service.dart';
import 'package:splat_mobile/public/dialog/dialog_notification.dart';
import 'package:splat_mobile/src/resources/show_dialog.dart';
import 'package:splat_mobile/public/widget_item/widget_register_success.dart';
import 'package:splat_mobile/src/app.dart';
import 'package:splat_mobile/src/blocs/common_textfield_bloc/common_textfield_bloc.dart';
import 'package:splat_mobile/src/blocs/setting/setting_avatar_bloc.dart';
import 'package:splat_mobile/src/models/base_api_model.dart';
import 'package:splat_mobile/src/models/info_login_model.dart';
import 'package:splat_mobile/src/models/player_model.dart';
import 'package:splat_mobile/src/resources/repository.dart';
import 'package:splat_mobile/src/resources/timer_counter_bloc.dart';
import 'package:splat_mobile/src/ui/authentication/validate.dart';
import '../../../constants/api_response_codes.dart';
import '../../../constants/public_values.dart';
import '../../../public/share_prefer.dart';
import '../../ui/authentication/modal_input_otp.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthenticationBloc with Validation{

  late BuildContext context;
  bool _passwordVisible=false;
  bool _checkRememberPass = false;
  bool _stopTap = false;
  final _emailBehavior = BehaviorSubject<String>();
  String _verifyOTP = '';
  String _msgCode = '';

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerOTP = TextEditingController();
  TextEditingController _controllerNickName = TextEditingController();
  TextEditingController _controllerRegisterEmail = TextEditingController();
  TextEditingController _controllerRegisterPass = TextEditingController();

  TextEditingController get emailController => _controllerEmail;
  TextEditingController get passController => _controllerPassword;
  TextEditingController get nickNameController => _controllerNickName;
  TextEditingController get otpController => _controllerOTP;
  TextEditingController get registerEmailController => _controllerRegisterEmail;
  TextEditingController get registerPassController => _controllerRegisterPass;

  FocusNode _focusNodeEmail = FocusNode();
  FocusNode _focusNodePass = FocusNode();
  FocusNode _focusNodeOtp = FocusNode();
  FocusNode _focusNodeReE = FocusNode();
  FocusNode _focusNodeReP = FocusNode();
  FocusNode _focusNodeNickName = FocusNode();
  FocusNode _focusNodeRePass = FocusNode();

  FocusNode get focusNodeEmail => _focusNodeEmail;
  FocusNode get focusNodePass => _focusNodePass;
  FocusNode get focusNodeOtp=> _focusNodeOtp;
  FocusNode get focusNodeReE=> _focusNodeReE;
  FocusNode get focusNodeReP=> _focusNodeReP;
  FocusNode get focusNodeNickName=> _focusNodeNickName;
  FocusNode get focusNodeRePass => _focusNodeRePass;


  final _otpBehavior = BehaviorSubject<String>();
  final _sendOTPBehavior = BehaviorSubject<String>();



  final _passwordVisibleBehavior = BehaviorSubject<bool>();
  final _checkRememberPassBehavior = BehaviorSubject<bool>();
  Stream<bool> get passwordVisibleBehavior => _passwordVisibleBehavior.stream;
  Stream<bool> get checkRememberPassBehavior => _checkRememberPassBehavior.stream;
  Stream<String> get emailBehavior => _emailBehavior.stream;
  bool get passwordVisible => _passwordVisible;
  bool get checkRememberPass => _checkRememberPass;


  int _currentStep = 0;
  final _currentStepBehavior = BehaviorSubject<int>();
  Stream<int> get currentStepBehavior => _currentStepBehavior.stream;
  int get currentStep => _currentStep;
  bool _isShowBack =false;
  bool get isShowBack => _isShowBack;
  final _isShowBackBehavior = BehaviorSubject<bool>();
  Stream<bool> get isShowBackBehavior => _isShowBackBehavior.stream;
  bool _resSuccess =false;
  bool get resSuccess => _resSuccess;
  final _resSuccessBehavior = BehaviorSubject<bool>();
  Stream<bool> get resSuccessBehavior => _resSuccessBehavior.stream;

  bool _showButtonContinue = false;
  bool get showButtonContinue => _showButtonContinue;
  final _showButtonContinueBehavior = BehaviorSubject<bool>();
  Stream<bool> get showButtonContinueBehavior => _showButtonContinueBehavior.stream;

  void setIconBack(){
    if(_currentStep>=0){
      _isShowBackBehavior.sink.add(_isShowBack=!_isShowBack);
      _resSuccess = false;
    }
    else{
      _isShowBackBehavior.sink.add(_isShowBack=!_isShowBack);
      _resSuccess = false;
    }
  }
  Future<void> onTapContinue(BuildContext context) async {
    if(!_stopTap) {
      _stopTap=true;
      if (_currentStep == 0) {
        await createUser(context, email: _controllerRegisterEmail.text);
        timerBloc.setCountDown();
        _stopTap=false;
      }
      if (_currentStep == 1) {
        await verifiCreateUser(context, otp: otpController.text);
        _stopTap=false;
      }
      if (_currentStep == 2) {
        if (_controllerRegisterPass.text == '') {
          commonTextFieldBloc.enterMsgCode('P000');
        }
        else {
          await SharePreferUtils.removeInfoRegister();
          show.dialog(dialogWidget: AddDialog.dialogCustom(
              onApply: () async {
                Navigator.popAndPushNamed(context, "/registerInfoUser");
                _currentStepBehavior.sink.add(_currentStep = 0);
                _resSuccess = false;
                if (checkRememberPass == true) {
                  InfoLoginModel infoLoginModel = InfoLoginModel(
                      email: _controllerRegisterEmail.text,
                      password: _controllerRegisterPass.text);
                  await SharePreferUtils.saveInfoRegister(infoLoginModel);
                }
              },
              content: "",
              title: "Chúc mừng! Tài khoản của bạn đã được thiết lập",
              contentWidget: WidgetRegisterSuccess(context),
              buttonName: "Đăng nhập",
              context: navigatorKey.currentContext!));
              _stopTap=false;
        }
      }
    }

    if(_resSuccess==true){
      if (_currentStep <= 1) {
        _currentStepBehavior.sink.add(_currentStep += 1);
        _resSuccess==false;
      }
    }

  }
  
  void onTapCancel(BuildContext context){
    if (_currentStep > 0) {
        _currentStepBehavior.sink.add(_currentStep -= 1);
        _resSuccess==false;
        _stopTap=false;
        switch (_currentStep){
          case 1:
            onBackTabScreen(context, '/inputOTP');
          case 2:
            onBackTabScreen(context, '/inputPass');


        }
    }

  }
  void onStepTapped(step) =>{
    _currentStepBehavior.sink.add(_currentStep = step)
  };
  /// show/hide password
  void setPassword() =>{
    _passwordVisibleBehavior.sink.add(_passwordVisible=!_passwordVisible)
  };
  void setCheckRememberPass(bool? value)=> _checkRememberPassBehavior.sink.add(_checkRememberPass=value!);
  void clearEmail() => _emailBehavior.sink.add("");
  void setEmail(String value) => _emailBehavior.sink.add(value);
  void setOTP(String value) => _otpBehavior.sink.add(otpController.text=value);
  void setShowButton()=> {
    if(emailController.text!=''){
      _showButtonContinueBehavior.sink.add(_showButtonContinue=true)
    }
    else{
      _showButtonContinueBehavior.sink.add(_showButtonContinue=false)
    }
  };

  ///Create a player and save user info in storage
  createUser(BuildContext context,{
    required String email,
  }) async {
      if(_controllerRegisterEmail.text==''){
        commonTextFieldBloc.enterMsgCode("E000");
        return;
      }
      else{
        BaseApiModel? response =
        await repository.createUser( email: email);
        if(response!=null) {
          if (response!.message["msg_code"] == MSG_SUCCESS_REGISTER_S605) {
            commonTextFieldBloc.enterMsgCode("");
            _resSuccessBehavior.sink.add(_resSuccess = true);
          } else {
            commonTextFieldBloc.enterMsgCode(
                response!.message["msg_code"].toString());
            _resSuccessBehavior.sink.add(_resSuccess = false);
            // commonTextFieldBloc.addOptionalError(response!.message["msg_name"]);
          }
        }
      }


  }
  verifiCreateUser(BuildContext context, {
    String? email,
    required String otp
  }) async {
    if(_controllerOTP.text==''){
      commonTextFieldBloc.enterResVerifyOtp("M000");
      return;
    }
    else{
      BaseApiModel? response =
      await repository.verifiCreateUser(email: _controllerRegisterEmail.text, otp: otp);
      if (response!.message["status_code"]== 200) {
        _resSuccessBehavior.sink.add(_resSuccess=true);
        _verifyOTP = response.message['msg_name'].toString();
        _msgCode = response.message['msg_code'].toString();
        _sendOTPBehavior.sink.add(_msgCode);
        commonTextFieldBloc.enterResVerifyOtp("");
      } else {
        _resSuccessBehavior.sink.add(_resSuccess=false);
        _msgCode = response.message['msg_code'].toString();
        commonTextFieldBloc.enterResVerifyOtp(_msgCode);
      }
    }
  }

  dispose() {
    _emailBehavior.close();
  }

  _playerCreatedSuccess(BaseApiModel response, BuildContext context,) {
      showCupertinoModalBottomSheet(
          expand: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => TabInputOtp(context)
      );
  }

  Future<void> login(BuildContext context,String router,{String? emailRegister, String? passRegister}) async{
    if(router=='/login'&& _controllerEmail.text==''){
      commonTextFieldBloc.enterMsgCode("E000");
      return;
    }
    else if( router=='/login' && _controllerPassword.text ==''){
      commonTextFieldBloc.enterMsgCode("P000");
      return;
    }
    else{
      // String email = await commonTextFieldBloc.emailValidateBehavior.first;
      // String password = await commonTextFieldBloc.passwordValidateBehavior.first;

      Response? response = await repository.login(email: emailRegister??_controllerEmail.text, pw: passRegister??_controllerPassword.text);
      if (response != null && response.statusCode == 200){
        String accessToken = jsonDecode(response.body)["access_token"];
        String refreshToken = jsonDecode(response.body)["refresh_token"];
        await storage.write(key: access_token_key, value: accessToken);
        await storage.write(key: refresh_token_key, value: refreshToken);
        // Response? checkingTokenRes = await repository.testToken();
        // commonTextFieldBloc.enterMsgCode("");
        // if (checkingTokenRes != null){
        //   await storage.write(
        //     key: user_info,
        //     value: jsonEncode(PlayerModel.fromJson(
        //         json.decode(utf8.decode(checkingTokenRes.body.codeUnits))).toJson()));
        //   //lỗi ký tự khi jsonDecode tu varchar database
        //   print('xinhcheck${json.decode(utf8.decode(checkingTokenRes.body.codeUnits))}');
        //   // Navigator.of(context).popUntil(ModalRoute.withName('/'));

          Navigator.popAndPushNamed(navigatorKey.currentContext!, '/home');
        // }
      }else{
        if (router=='/login') {
          commonTextFieldBloc.enterMsgCode(
              jsonDecode(response!.body)["message"]["msg_code"].toString());
        }else{
          show.dialog(
              dialogWidget:AddDialog.dialogCustom(
              context: navigatorKey.currentContext!,
              onApply: (){Navigator.popAndPushNamed(context, "/");},
              content: jsonDecode(response!.body)["message"]["msg_name"],
              ));
          // showDialog(
          //     barrierDismissible: false,
          //     context: context, builder: (context){
          //   return AddDialog.AddDialogbuilder(
          //       onApply: (){Navigator.popAndPushNamed(context, "/");},
          //       content: jsonDecode(response!.body)["message"]["msg_name"],
          //       context: context);
          // });
        }
        // print('hieuttchecking: ${jsonDecode(response!.body)["message"]["msg_name"]}');
        // commonTextFieldBloc.addOptionalError(jsonDecode(response!.body)["message"]["msg_name"]);

      }
    }
  }

  Future<void> refreshToken() async {
    Response? response = await repository.refreshToken();
    if (response != null){
      String accessToken = jsonDecode(response.body)["access_token"];
      await storage.write(key: access_token_key, value: accessToken);
      Response? checkingTokenRes = await repository.testToken();
      if (checkingTokenRes != null) {
        await storage.write(
            key: user_info,
            value: jsonEncode(PlayerModel.fromJson(
                jsonDecode(checkingTokenRes.body)).toJson()));
        Navigator.pushNamed(navigatorKey.currentContext!, '/home');
      }
    }
  }

  Future<void> logout() async {
    Response? response = await repository.logout();
    if (response != null){
      Navigator.pushNamed(navigatorKey.currentContext!, '/');
    }
  }


  Future<void> onBackTabScreen(BuildContext context, String router) async {
    switch(router){
      case '/settingAvatar':
        settingAvatarBloc.setAvatarFile('');
        await SharePreferUtils.removeInfoRegister();
        clearAllController();
        Navigator.pop(context);
        break;
      case '/registerInfoUser':
        _controllerNickName.clear();
        Navigator.pop(context);
        break;
      case '/inputEmail':
        _controllerEmail.clear();
        _sendOTPBehavior.sink.add('');
        break;
      case '/inputOTP':
        _controllerOTP.clear();
        commonTextFieldBloc.enterResVerifyOtp('');
        timerBloc.dispose();
        break;
      case '/inputPass':
        _controllerPassword.clear();
        break;
    }

  }

  Future<void> createUserLogin(BuildContext context) async{
    // InfoLoginModel info = await SharePreferUtils.getInfoLogin();
    BaseApiModel? response = await repository.createUserLogin(
        body:{
          "name": _controllerNickName.text,
          "gender": 0,
          "birth_date": "12/02/2000",//type timestamp: "" lỗi format trên backend khi truyền rỗng
          "email": _controllerRegisterEmail.text,
          "phone": "",
          "avatar": '${settingAvatarBloc.base64Image}',
          "role_ids": [],
          "otp": _verifyOTP,
          "password": _controllerRegisterPass.text
        });
    if (response!.message["status_code"]== 201) {
        await login(context,'/register' ,emailRegister: _controllerRegisterEmail.text, passRegister: _controllerRegisterPass.text);
        await SharePreferUtils.saveAvatar(settingAvatarBloc.base64Image, authenticationBloc.nickNameController.text);
        await SharePreferUtils.getAvatar(authenticationBloc.nickNameController.text);
        clearAllController();
    } else {
      show.dialog(
          dialogWidget:AddDialog.dialogCustom(
          onApply: (){
            Navigator.popAndPushNamed(context, "/");
            clearAllController();
          },
          content: response!.message["msg_name"],
          context: navigatorKey.currentContext!));
    }
  }

  void clearAllController(){
    _controllerEmail.clear();
    _controllerPassword.clear();
    _controllerRegisterEmail.clear();
    otpController.clear();
    _controllerRegisterPass.clear();
    nickNameController.clear();
    _currentStepBehavior.sink.add(_currentStep =0);
    _resSuccess=false;
    _sendOTPBehavior.sink.add('');
    commonTextFieldBloc.enterMsgCode('');
    commonTextFieldBloc.enterEmail('');
    commonTextFieldBloc.enterPassword("");
    settingAvatarBloc.setAvatarFile('');
    commonTextFieldBloc.enterResVerifyOtp('');
    clearEmail();
    timerBloc.dispose();
  }

  Future<void> resendPin(BuildContext context) async {
    await createUser(context, email: _controllerRegisterEmail.text);
    otpController.clear();
  }

  Future<void> loginWithGoogle() async {
    Response? response = await repository.loginGG();
    print('xinhcheck${response!.body}');
    // show.cupertinoModalBottomSheet(contentView)
  }
}
  final authenticationBloc = AuthenticationBloc();
