import 'package:flutter/material.dart';
import 'package:splat_mobile/public/widget_item/app_button.dart';
import 'package:splat_mobile/src/ui/authentication/authentication_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddDialog {
  static AlertDialog AddDialogbuilder({
    required BuildContext context,
    required VoidCallback onclose,
    required VoidCallback onApply,
    required String content,
    String? title
  }) {
    final localizations = AppLocalizations.of(context)!;
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        insetPadding: EdgeInsets.zero,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // IconButton(
            //   alignment: Alignment.centerLeft,
            //   onPressed: onclose,
            //   icon: Icon(Icons.close),
            // ),
            Container(
              alignment: Alignment.topCenter,
              child: Text(title??localizations.noti,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            content, textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              alignment: Alignment.center,
              child: AppButton.buildMaterialButton(
                  context: context,
                onTap: onApply
              )
            ),
          )
        ]
    );
  }
}