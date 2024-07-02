import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:splat_mobile/public/widget_item/app_button.dart';
import 'package:splat_mobile/src/ui/authentication/authentication_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/ui_styles.dart';

class AddDialog {
  static AlertDialog dialogCustom({
    required BuildContext context,
    VoidCallback? onclose,
    required VoidCallback onApply,
    required String content,
    Widget? contentWidget,
    String? title,
    String? buttonName,
    String? buttonNameClose,
  }) {
    final localizations = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        insetPadding: EdgeInsets.all(15),
        title: Container(
          alignment: Alignment.topCenter,
          child: Text(title??localizations.noti,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ),
        content: contentWidget??Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            content, textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          onclose!=null?Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: AppButton.buildMaterialButton(
                      context: context,
                      onTap: onclose,
                      width: size.width*0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey
                      ),
                      buttonName: buttonNameClose??"Đóng"
                  )
              ),
              SizedBox(width: size.width*0.1,),
              Container(
                  child: AppButton.buildMaterialButton(
                      context: context,
                      onTap: onApply,
                      width: size.width*0.3,
                      buttonName: buttonName
                  )
              )
            ],
          )
          :Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              alignment: Alignment.center,
              child: AppButton.buildMaterialButton(
                context: context,
                onTap: onApply,
                buttonName: buttonName
              )
            ),
          )
        ]
    );
  }



  static CupertinoAlertDialog cupertinoDialogTwoBtn({
    required BuildContext context,
    required String content,
    required Function() onPressedOK
  }){
    return CupertinoAlertDialog(
      title: Text(content),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          textStyle: textButtonBlue,
          child: const Text('Từ chối'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          textStyle: textButtonBlue,
          onPressed: onPressedOK,
          child: const Text('Xác nhận'),
        ),
      ],
    );
  }
  static CupertinoAlertDialog cupertinoDialogOneBtn({
    required BuildContext context,
    required String content,
  }){
    return CupertinoAlertDialog(
      title: Text(content),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          textStyle: textButtonBlue,
          onPressed: (){Navigator.pop(context);},
          child: const Text('Đóng'),
        ),
      ],
    );
  }
}