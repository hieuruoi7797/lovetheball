import 'package:flutter/material.dart';
import 'package:splat_mobile/public/widget_item/app_button.dart';
import 'package:splat_mobile/src/ui/authentication/authentication_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddDialog {
  static AlertDialog AddDialogbuilder({
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
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        insetPadding: EdgeInsets.all(15),
        title: Container(
          alignment: Alignment.topCenter,
          child: Text(title??localizations.noti,
            textAlign: TextAlign.center,
          ),
        ),
        content: contentWidget??Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            content, textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          onclose!=null?Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
                alignment: Alignment.center,
                child: AppButton.buildMaterialButton(
                    context: context,
                    onTap: onclose,
                    buttonName: buttonNameClose??"Đóng"
                )
            ),
          ):Container(),
          Padding(
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
}