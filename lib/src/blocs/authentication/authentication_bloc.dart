import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/public/app_global.dart';
import 'package:splat_mobile/public/app_service.dart';
import 'package:splat_mobile/public/dialog/dialog_notification.dart';
import 'package:splat_mobile/public/widget_item/widget_register_success.dart';
import 'package:splat_mobile/src/app.dart';
import 'package:splat_mobile/src/blocs/common_textfield_bloc/common_textfield_bloc.dart';
import 'package:splat_mobile/src/models/base_api_model.dart';
import 'package:splat_mobile/src/models/player_model.dart';
import 'package:splat_mobile/src/resources/repository.dart';
import 'package:splat_mobile/src/ui/authentication/validate.dart';


import '../../../constants/api_response_codes.dart';
import '../../../constants/public_values.dart';
import '../../../constants/ui_styles.dart';
import '../../../public/share_prefer.dart';
import '../../ui/authentication/modal_input_otp.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthenticationBloc with Validation{

  late BuildContext context;
  bool _passwordVisible=false;
  bool _checkRememberPass = false;
  final _emailBehavior = BehaviorSubject<String>();
  final  picker = ImagePicker();
  File _avatarFile = File('');
  final _imagePickerBehavior = BehaviorSubject<File>();
  Stream<File> get imagePickerBehavior => _imagePickerBehavior.stream;
  File get avatarFile => _avatarFile;
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerOTP = TextEditingController();
  TextEditingController _controllerNickName = TextEditingController();
  TextEditingController get emailController => _controllerEmail;
  TextEditingController get passController => _controllerPassword;
  TextEditingController get nickNameController => _controllerNickName;

  final _otpBehavior = BehaviorSubject<String>();
  Stream<String> get otpBehavior => _otpBehavior.stream;
  TextEditingController get _otpController => _controllerOTP;


  final _passwordVisibleBehavior = BehaviorSubject<bool>();
  final _checkRememberPassBehavior = BehaviorSubject<bool>();
  Stream<bool> get passwordVisibleBehavior => _passwordVisibleBehavior.stream;
  Stream<bool> get checkRememberPassBehavior => _checkRememberPassBehavior.stream;
  Stream<String> get emailBehavior => _emailBehavior.stream;
  Stream<String> get emailValidateBehavior => _emailBehavior.stream.transform(eMailValidate);
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
  void setIconBack()=>{
    if(_currentStep>=0){
      _isShowBackBehavior.sink.add(_isShowBack=!_isShowBack)
    }
    else{
      _isShowBackBehavior.sink.add(_isShowBack=!_isShowBack)
    }
  };
  Future<void> onTapContinue(BuildContext context) async {
    if(_currentStep==0){
      await createUser(context, email: _controllerEmail.text);
    }
    if(_currentStep==1){
      await verifiCreateUser(context, otp: _otpController.text);
    }
    if(_currentStep==2){
      showDialog(context: context, builder: (context){
        final localizations = AppLocalizations.of(context)!;
        return AddDialog.AddDialogbuilder(
            // onclose: (){Navigator.of(context).pop();},
            onApply: (){Navigator.pushNamed(context, "/registerInfoUser");},
            content: "",
            title: "Chúc mừng! Tài khoản của bạn đã được thiết lập",
            contentWidget: WidgetRegisterSuccess(context),
            buttonName: "Đăng nhập",
            context: context);
      });
    }

    if(_resSuccess==true){
      if (_currentStep <= 1) {
        _currentStepBehavior.sink.add(_currentStep += 1);
      }
    }

  }
  void onTapCancel()=>{
    if (_currentStep > 0) {
        _currentStepBehavior.sink.add(_currentStep -= 1),

    }
  };
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
  void setOTP(String value) => _otpBehavior.sink.add(_otpController.text=value);
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
      if(emailController.text==''){
        showDialog(context: context, builder: (context){
          return AddDialog.AddDialogbuilder(
              onApply: (){Navigator.of(context).pop();},
              content: "Vui lòng nhập email",
              context: context);
        });
        return;
      }
      else{
        BaseApiModel? response =
        await repository.createUser( email: email);
        if (response!.message["msg_code"]== MSG_SUCCESS_REGISTER_S605) {
          _resSuccessBehavior.sink.add(_resSuccess=true);
        } else {
          _resSuccessBehavior.sink.add(_resSuccess=false);
          showDialog(context: context, builder: (context){
            return AddDialog.AddDialogbuilder(
              // onclose: (){Navigator.of(context).pop();},
                onApply: (){Navigator.of(context).pop();},
                content: response!.message["msg_name"],
                context: context);
          });
        }
      }


  }
  verifiCreateUser(BuildContext context, {
    String? email,
    required String otp
  }) async {
    BaseApiModel? response =
        await repository.verifiCreateUser(email: _controllerEmail.text, otp: otp);
    if (response!.message["status_code"]== 200) {
      _resSuccessBehavior.sink.add(_resSuccess=true);
    } else {
      _resSuccessBehavior.sink.add(_resSuccess=false);
      showDialog(context: context, builder: (context){
        return AddDialog.AddDialogbuilder(
            // onclose: (){Navigator.of(context).pop();},
            onApply: (){Navigator.of(context).pop();},
            content: response!.message["msg_name"],
            context: context);
      });
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

  Future<void> login() async{
    String email = await commonTextFieldBloc.emailValidateBehavior.first;
    String password = await commonTextFieldBloc.passwordValidateBehavior.first;

    Response? response = await repository.login(email: email, pw: password);
    if (response != null && response.statusCode == 200){
      String accessToken = jsonDecode(response.body)["access_token"];
      String refreshToken = jsonDecode(response.body)["refresh_token"];
      await storage.write(key: access_token_key, value: accessToken);
      await storage.write(key: refresh_token_key, value: refreshToken);
      Response? checkingTokenRes = await repository.testToken();
      if (checkingTokenRes != null){
        publicValues.userNow = PlayerModel.fromJson(jsonDecode(checkingTokenRes.body));
        // Navigator.pushNamed(navigatorKey.currentContext!, '/home');
      }
    }else{
      print('hieuttchecking: ${jsonDecode(response!.body)["message"]["msg_name"]}');
      commonTextFieldBloc.incorrectEmailPass(jsonDecode(response!.body)["message"]["msg_name"]);
    }
  }

  Future<void> refreshToken() async {
    Response? response = await repository.refreshToken();
    if (response != null){
      String accessToken = jsonDecode(response.body)["access_token"];
      await storage.write(key: access_token_key, value: accessToken);
      Response? checkingTokenRes = await repository.testToken();
      if (checkingTokenRes != null) {
        publicValues.userNow =
            PlayerModel.fromJson(jsonDecode(checkingTokenRes.body));
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

  Future<void> pickImageFromLib(BuildContext context) async{
    Navigator.pop(context);
    _imagePickerBehavior.sink.add(_avatarFile=File(''));
    bool permission = await service.handlePhotosPermission(context);
    if(permission){
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        await setImageFile(pickedFile);
      }
    }
  }

  Future<void> pickImageFromCam(BuildContext context) async{
    Navigator.pop(context);
    _imagePickerBehavior.sink.add(_avatarFile=File(''));
    bool permission = await service.handleCameraPermission(context);
    if(permission){
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        _imagePickerBehavior.sink.add(_avatarFile=File(''));
        await  setImageFile(pickedFile);
      }
    }
  }
  void onBackScreenSetAvatar(BuildContext context){
    Navigator.pop(context);
    _imagePickerBehavior.sink.add(_avatarFile=File(''));
  }

  Future<void> setImageFile(XFile? pickedFile) async{
    final Directory basePath = await getApplicationDocumentsDirectory();
    String path = '/image_avatar' + _controllerEmail.text + '.jpg';
    XFile? imageFile = pickedFile != null ? XFile(pickedFile.path) : null;
    final Uint8List uInt8 = await imageFile!.readAsBytes();
    File pathAvartar = await File(basePath.path + path).writeAsBytes(uInt8, mode: FileMode.write);
    imageCache.clear();
    imageCache.clearLiveImages();
    await SharePreferUtils.saveAvatar(pathAvartar.path, _controllerNickName.text);
    appGlobal.setAvatarFile(pathAvartar);
    _imagePickerBehavior.sink.add(_avatarFile=pathAvartar);
  }

  Future<void> createUserLogin() async{
    BaseApiModel? response = await repository.createUserLogin(
        body:{
          "name": _controllerNickName.text,
          "gender": 0,
          "birth_date": "",
          "email": emailController.text,
          "phone": "",
          "avatar": _avatarFile,
          "role_ids": [ ],
          "otp": _otpController.text,
          "password": _controllerPassword.text
        });
    print('Tao tai khaon dang nhap thanh cong: ${jsonEncode(response)}');
  }

}
  final authenticationBloc = AuthenticationBloc();
