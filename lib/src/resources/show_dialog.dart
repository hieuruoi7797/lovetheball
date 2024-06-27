import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app.dart';

class ShowDialogBloc{
  Future<void> dialog({required Widget dialogWidget}) async {
    await showDialog(barrierDismissible: false,
    context: navigatorKey.currentContext!, builder: (context){
      return dialogWidget;
    });
  }
}
ShowDialogBloc show = ShowDialogBloc();
