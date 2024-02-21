import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants/ui_styles.dart';

class DialogBuilder{
  static AlertDialog BaseDialog({
    required String title,
    required String content,
    required Function() onCancel,
    required Function() onSuccess,
  }){
    return AlertDialog(
      title: Text(title, textAlign: TextAlign.center,),
      content: Text(content, textAlign: TextAlign.center,),
      actions: <Widget>[
        TextButton(
            onPressed: onCancel,
            child: Container(
                decoration: const BoxDecoration(
                  color: color_button_cancel,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text('Huỷ', style: normal_white_color,),
                )
            )
        ),
          TextButton(
              onPressed: onSuccess,
              child: Container(
                  decoration: const BoxDecoration(
                    color: color_main,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text('Xác nhận', style: normal_white_color,),
                  )
              )
          ),
      ],
    );
  }
  static AlertDialog BaseDialogOneButton({
    required String title,
    required String content,
    required Function() onCancel,
  }){
    return AlertDialog(
        title: Text(title, textAlign: TextAlign.center,),
        content: Text(content, textAlign: TextAlign.center,),
        actions: <Widget>[
            TextButton(
            onPressed: onCancel,
            child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: color_button_cancel,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text('Đóng', style: normal_white_color,),
                )
            )
          ),
        ]
    );
  }
}