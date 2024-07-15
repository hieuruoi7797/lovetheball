import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:splat_mobile/constants/icon_custom.dart';
import 'package:splat_mobile/public/widget_item/svg_icon.dart';

import '../../constants/ui_styles.dart';
import '../../src/blocs/authentication/authentication_bloc.dart';

Widget WidgetRegisterSuccess(BuildContext context){
  final size = MediaQuery.of(context).size;
  return Container(
    height: size.height*0.15,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Lottie.asset(
              CustomIcon.icon_anm_checkmark,
              width: 72,
              height: 72
          ),
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
                    activeColor: color_E5601A,
                    value: authenticationBloc.checkRememberPass,
                    onChanged: (bool? value) {
                      authenticationBloc.setCheckRememberPass(value);
                    },
                  ),
                  Text(
                      "Ghi nhớ thông tin tài khoản",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: color_313A3E
                    ),
                  ),
                ],
              );
            }
        ),
      ],
    ),
  );
}