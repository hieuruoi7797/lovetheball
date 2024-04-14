import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:splat_mobile/public/modal/modal_fit.dart';

import '../../../constants/ui_styles.dart';

Widget ModalInputOtp(BuildContext context){

  @override
  TextStyle? createStyle(Color color) {
    ThemeData theme = Theme.of(context);
    return theme.textTheme.headlineSmall?.copyWith(color: color, fontWeight: FontWeight.bold);
  }
  var otpTextStyles = [
    createStyle(Colors.black),
    createStyle(Colors.black),
    createStyle(Colors.black),
    createStyle(Colors.black),
    createStyle(Colors.black),
    createStyle(Colors.black),
  ];

  return ModalFit(
    title: "ĐĂNG KÝ",
    buttonName: "Tiếp tục",
    widget: SingleChildScrollView(
      child: Container(
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
            OtpTextField(
              numberOfFields: 6,
              borderColor: color_ECF3FB,
              focusedBorderColor: color_B3BBC4,
              styles: otpTextStyles,
              borderRadius: BorderRadius.circular(10),
              fieldWidth: 44,
              inputFormatters: [

              ],
              filled: true,
              fillColor: color_ECF3FB,
              // enabledBorderColor: color_B3BBC4,
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode){
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: const Text("Verification Code"),
                        content: Text('Code entered is $verificationCode'),
                      );
                    }
                );
              }, // end onSubmit
            ),
          ],
        ),
      ),
    ),
    widget2:  Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child:  const Column(
        children: [
          Text("Chưa nhận được email?",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color:color_62737A,
                letterSpacing: -0.4,
                wordSpacing: -0.4
            ),),
            Text("Gửi lại mã",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color:Colors.black,
                  letterSpacing: -0.4,
                  wordSpacing: -0.4
              ),
            ),
        ],
      ),
    ),
  );
}