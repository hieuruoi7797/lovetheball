import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/ui_styles.dart';
import '../../src/blocs/authentication/authentication_bloc.dart';

Widget WidgetRegisterSuccess(BuildContext context){
  final size = MediaQuery.of(context).size;
  return Container(
    height: size.height*0.35,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: color_62737A
              )
          ),
          width: size.width*0.5,
          height: size.height*0.25,
        ),
        StreamBuilder<Object>(
            stream: authenticationBloc.checkRememberPassBehavior,
            builder: (context, snapshot) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    checkColor: Colors.white,
                    activeColor: color_checkbox_remember,
                    value: authenticationBloc.checkRememberPass,
                    onChanged: (bool? value) {
                      authenticationBloc.setCheckRememberPass(value);
                    },
                  ),
                  Text("Ghi nhớ thông tin tài khoản"),
                ],
              );
            }
        ),
      ],
    ),
  );
}