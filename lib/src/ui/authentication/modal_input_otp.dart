import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:splat_mobile/public/modal/modal_fit.dart';
import 'package:splat_mobile/public/widget_item/common_text_field.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:splat_mobile/src/blocs/common_textfield_bloc/common_textfield_bloc.dart';

import '../../../constants/ui_styles.dart';

Widget TabInputOtp(BuildContext context){

  @override
  TextStyle? createStyle(Color color) {
    ThemeData theme = Theme.of(context);
    return theme.textTheme.headlineSmall?.copyWith(color: color, fontWeight: FontWeight.bold,fontSize:28,);
  }
  var otpTextStyles = [
    createStyle(Colors.black,),
    createStyle(Colors.black),
    createStyle(Colors.black),
    createStyle(Colors.black),
    createStyle(Colors.black),
    createStyle(Colors.black),
  ];

  return Container(
    // title: "ĐĂNG KÝ",
    // buttonName: "Tiếp tục",
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Nhập mã xác thực",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10,),
        const Text("Mã xác thực đã được gửi đến email của bạn",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color:color_62737A,
              letterSpacing: -0.4,
              wordSpacing: -0.4
          ),
        ),
        const SizedBox(height: 30,),
        Common.CommonTextField(context,
            controller: authenticationBloc.otpController,
            labelText: 'Mã xác thực',
            type: TextFieldTypeEnum.numberOtp,
            typeEnableValidate: TypeEnableValidateEnum.otp,
            focusNode: authenticationBloc.focusNodeOtp),
      ],
    ),
  );
}