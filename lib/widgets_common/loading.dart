import 'package:flutter/material.dart';
import 'package:splat_record/constants/ui_styles.dart';

class DialogWidget  {

  showLoaderDialog(BuildContext context){
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50,
            width: 50,
            color: Colors.transparent,
            child: CircularProgressIndicator(
              color: color_main,
              backgroundColor: color_loading_background,
            ),
          ),
        ],
      ));
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

}