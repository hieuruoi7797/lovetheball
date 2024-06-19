import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/ui_styles.dart';
import '../../src/blocs/authentication/authentication_bloc.dart';

Widget WidgetRegisterSuccess(BuildContext context){
  final size = MediaQuery.of(context).size;
  return Container(
    height: size.height*0.26,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Color(0xff40cbe0)
              ),
              shape: BoxShape.circle,
            color: Color(0xff40cbe0)

          ),
          width: size.width*0.2,
          height: size.height*0.2,
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