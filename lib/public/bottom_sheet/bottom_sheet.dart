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

  static Future<void> showLeftModal(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 1.0,
          child: Row(
            children: [
              Expanded(
                flex: 3, // Control the width of the left-side modal
                child: Container(
                  color: Colors.redAccent,
                  child: Center(
                    child: Text(
                      'Left-Side Modal Sheet',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent, // Close modal on tap outside
                  ),
                ),
              ),
            ],
          ),
        );
      },
      backgroundColor: Colors.transparent, // Make the background transparent
      isScrollControlled: true, // Allows full-height display
    );
  }
}