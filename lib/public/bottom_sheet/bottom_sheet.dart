import 'package:flutter/material.dart';
import 'package:splat_mobile/constants/icon_custom.dart';
import 'package:splat_mobile/public/widget_item/svg_icon.dart';

import '../../constants/ui_styles.dart';

class BottomSheetCustom {
  static Widget showBottomSheetSelectImage({
    required final BuildContext context,
    required Function() onTapCam,
    required Function() onTapLib,
  }){
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height*0.2,
      padding: EdgeInsets.symmetric(horizontal: size.width*0.01, vertical: size.height*0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            onTap: onTapCam,
            leading: const SvgIcon(
              icon: CustomIcon.icon_camera,
              size: 20,
            ),
            title: const Text('Chụp ảnh'),
          ),
          ListTile(
            onTap: onTapLib,
            leading: const SvgIcon(
              icon: CustomIcon.icon_library_image,
              size: 20,
            ),
            title: const Text('Chọn ảnh từ thư viện'),
          ),
        ],
      ),
    );
  }
}