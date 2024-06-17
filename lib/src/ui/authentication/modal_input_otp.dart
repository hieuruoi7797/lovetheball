import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:splat_mobile/public/modal/modal_fit.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';

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

  return StreamBuilder<Object>(
    stream: authenticationBloc.otpValidateBehavior,
    builder: (context, snapshot) {
      return Container(
        // title: "ĐĂNG KÝ",
        // buttonName: "Tiếp tục",
        padding: EdgeInsets.symmetric(horizontal: 10),
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
            StreamBuilder<Object>(
              stream: authenticationBloc.otpBehavior,
              builder: (context, snapshot) {
                return OtpTextField(
                  numberOfFields: 6,
                  styles: otpTextStyles,
                  borderRadius: BorderRadius.circular(10),
                  fieldWidth: 44,
                  filled: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9]", unicode: true)),
                  ],
                  focusedBorderColor:color_B3BBC4,
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color(0xffff3b30)
                        ,
                      ),
                    ),
                    errorStyle: TextStyle(
                        color: Color(0xffff3b30),
                        fontWeight: FontWeight.w600,
                        fontSize: 13
                    ),
                    errorText: snapshot.error?.toString(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                          width: 2,
                          color: color_B3BBC4

                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                          width: 2,
                          color: color_B3BBC4

                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  fillColor: color_ECF3FB,
                  enabledBorderColor: color_ECF3FB,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    print('$code');
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode){
                    authenticationBloc.setOTP(verificationCode);
                  }, // end onSubmit
                );
              }
            ),
            snapshot.hasError?
            Center(
              child: Text('${snapshot.error?.toString()}',
                style: TextStyle(
                    color: Color(0xffff3b30),
                    fontWeight: FontWeight.w600,
                    fontSize: 13
                ),
                textAlign: TextAlign.center,
              ),
            ):Container()
          ],
        ),
      );
    }
  );
}