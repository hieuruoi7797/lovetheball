import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowDialogBloc{
  Future<void> dialog(BuildContext context, {required Widget dialogWidget}) async {
    await showDialog(barrierDismissible: false,
    context: context, builder: (context){
      return dialogWidget;
    });
  }
}
ShowDialogBloc show = ShowDialogBloc();
