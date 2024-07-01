import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../constants/ui_styles.dart';
import '../app.dart';

class ShowDialogBloc{
  Future<void> dialog({required Widget dialogWidget}) async {
    await showDialog(barrierDismissible: false,
    context: navigatorKey.currentContext!, builder: (context){
      return dialogWidget;
    });
  }
  
  Future<void> cupertinoModalBottomSheet(Widget contentView) async{
    await showCupertinoModalBottomSheet(
        context: navigatorKey.currentContext!,
        expand: true,
        backgroundColor: Colors.transparent,
        builder: (context){
          return contentView;
        });
  }

  Future<void> listTileBottomSheet(Widget contentView) async{
    await showModalBottomSheet(
        context: navigatorKey.currentContext!,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0)
          ),
        ),
        backgroundColor: color_FFFFFF,
        builder: (context){
          return contentView;
        });
  }
}
ShowDialogBloc show = ShowDialogBloc();
