import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
      await showDialog(context: context, builder: (context){
        return AddDialog.AddDialogbuilder(
            onApply: (){
              openAppSettings();
            },
            onclose: (){
              Navigator.pop(context);
            },
            content: "Splat muốn truy cập Máy ảnh của bạn",
            context: context
        );
      });

      return false;
    }
    return true;
  }

  @override
  Future<bool> handlePhotosPermission(BuildContext context) async {
    PermissionStatus photosPermissionStatus = await requestPhotosPermission();

    if (photosPermissionStatus != PermissionStatus.granted) {
      await showDialog(context: context, builder: (context){
        return AddDialog.AddDialogbuilder(
            onApply: (){
              openAppSettings();
            },
            onclose: (){
              Navigator.pop(context);
            },
            content: "Splat muốn truy Thư viện ảnh của bạn",
            context: context
        );
      });

      return false;
    }
    return true;
  }
}
final service = AppService();