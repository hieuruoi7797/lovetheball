import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/ui_styles.dart';
import 'dialog/dialog_notification.dart';

class AppService{
  @override
  Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }

  @override
  Future<PermissionStatus> requestPhotosPermission() async {
    return await Permission.photos.request();
  }
  @override
  Future<bool> handleCameraPermission(BuildContext context) async {
    PermissionStatus cameraPermissionStatus = await requestCameraPermission();

    if (cameraPermissionStatus != PermissionStatus.granted) {
      AddDialog.showAlertDialog(
          context,
          "Splat muốn truy cập Máy ảnh của bạn",
          () {openAppSettings();});

      return false;
    }
    return true;
  }

  @override
  Future<bool> handlePhotosPermission(BuildContext context) async {
    PermissionStatus photosPermissionStatus = await requestPhotosPermission();

    if (photosPermissionStatus != PermissionStatus.granted) {
      AddDialog.showAlertDialog(
          context,
          "Splat muốn truy cập Thư viện ảnh của bạn",
          (){openAppSettings();});

      return false;
    }
    return true;
  }
}
final service = AppService();