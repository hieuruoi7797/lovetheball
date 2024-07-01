import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';

import '../../../public/app_global.dart';
import '../../../public/app_service.dart';
import '../../../public/share_prefer.dart';

class SettingAvatarBloc{
  final  picker = ImagePicker();
  File _avatarFile = File('');
  final _imagePickerBehavior = BehaviorSubject<File>();
  Stream<File> get imagePickerBehavior => _imagePickerBehavior.stream;
  File get avatarFile => _avatarFile;

  void setAvatarFile(String value) => _imagePickerBehavior.sink.add(_avatarFile=File(value));

  //Cat anh
  Future<XFile?> _cropImage(XFile? _pickedFile) async {
    if (_pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              cropFrameColor: Colors.black,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
            showCancelConfirmationDialog: true,
            doneButtonTitle: 'Hoàn thành',
            cancelButtonTitle: 'Huỷ'
          ),
          // WebUiSettings(
          //   context: ApplicationService.materialKey.currentContext!,
          // ),
        ],
      );
      if (croppedFile != null) {
        XFile myImage = XFile(croppedFile.path);
        return myImage;
      }
      return null;
    }
  }
  //chon anh tu thu vien
  Future<void> pickImageFromLib(BuildContext context) async{
    Navigator.pop(context);
    _imagePickerBehavior.sink.add(_avatarFile=File(''));
    bool permission = await service.handlePhotosPermission(context);
    if(permission){
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      XFile? imageFile = pickedFile != null ? XFile(pickedFile.path) : null;
      if (imageFile != null) {
        XFile? croppedImage = await _cropImage(imageFile);
        await setImageFile(croppedImage);
      }
    }
  }
  //chon anh tu camera
  Future<void> pickImageFromCam(BuildContext context) async{
    Navigator.pop(context);
    _imagePickerBehavior.sink.add(_avatarFile=File(''));
    bool permission = await service.handleCameraPermission(context);
    if(permission){
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera,preferredCameraDevice: CameraDevice.front);
      XFile? imageFile = pickedFile != null ? XFile(pickedFile.path) : null;
      if (imageFile != null) {
        XFile? croppedImage = await _cropImage(imageFile);
        await setImageFile(croppedImage);
      }
    }
  }
  //luu anh vao local data
  Future<void> setImageFile(XFile? pickedFile) async{
    final Directory basePath = await getApplicationDocumentsDirectory();
    String path = '/image_avatar' + authenticationBloc.registerEmailController.text + '.jpg';
    XFile? imageFile = pickedFile != null ? XFile(pickedFile.path) : null;
    final Uint8List uInt8 = await imageFile!.readAsBytes();
    File pathAvartar = await File(basePath.path + path).writeAsBytes(uInt8, mode: FileMode.write);
    imageCache.clear();
    imageCache.clearLiveImages();
    await SharePreferUtils.saveAvatar(pathAvartar.path, authenticationBloc.nickNameController.text);
    appGlobal.setAvatarFile(pathAvartar);
    _imagePickerBehavior.sink.add(_avatarFile=pathAvartar);
  }
}
SettingAvatarBloc settingAvatarBloc = SettingAvatarBloc();