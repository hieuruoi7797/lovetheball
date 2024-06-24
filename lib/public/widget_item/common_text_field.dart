import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:splat_mobile/constants/ui_styles.dart';
import 'package:splat_mobile/public/widget_item/svg_icon.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:splat_mobile/src/blocs/common_textfield_bloc/common_textfield_bloc.dart';

import '../../constants/icon_custom.dart';

class Common{
 static Widget CommonTextField(
      BuildContext context, {
        String? labelText,
        String? optionalErrorText,
        bool? enableEmailValidator,
        bool? enablePassWordValidator,
        bool? enableOtpValidator,
       bool? enableResposeValidator,
        TextFieldTypeEnum? type,
        required TextEditingController controller,
        required FocusNode focusNode,
      }) {
    final textController = TextEditingController();
    return StreamBuilder<String>(
        stream: enableEmailValidator == true
            ? commonTextFieldBloc.emailValidateBehavior
            : enablePassWordValidator == true
            ? commonTextFieldBloc.passwordValidateBehavior
            : enableOtpValidator == true
            ? commonTextFieldBloc.otpValidateBehavior
            : enableResposeValidator == true
            ? commonTextFieldBloc.responseErrorStream
            : null
        ,
        builder: (context, snapshotValidate) {
          return StreamBuilder<bool>(
              stream: commonTextFieldBloc.visiblePassword,
              builder: (context, snapshotObscure) {
                // Color for border
                Color _borderColor = Colors.grey;
                _borderColor = snapshotValidate.hasError?Color(0xffff3b30):focusNode.hasFocus ? color_B3BBC4:Colors.transparent;
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xffecf3fb).withOpacity(0.6),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: _borderColor,
                                width: 2
                            )
                          )
                        ),
                        TextField(
                          focusNode: focusNode,
                          autofocus: true,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            filled: false,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10,right: 10, top: 12, bottom: 1),
                            // border: InputBorder.none,
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(16),
                            //   borderSide: const BorderSide(
                            //     width: 2,
                            //   ),
                            // ),
                            // enabledBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(16),
                            //   borderSide: const BorderSide(
                            //       width: 2,
                            //       color: color_B3BBC4
                            //
                            //   ),
                            // ),
                            // focusedBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(16),
                            //   borderSide: const BorderSide(
                            //     width: 2,
                            //     style: BorderStyle.none,
                            //     color: color_main,
                            //   ),
                            // ),
                            // focusColor: color_B3BBC4,
                            labelText:focusNode.hasFocus ?labelText ?? "Email":null,
                            labelStyle: TextStyle(
                              color: Color(0xff677986),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,

                            ),
                            hintText:labelText ?? "Email",
                            hintStyle: TextStyle(
                            color: Color(0xffafbfcf),
                            fontSize: 17,
                            fontWeight: FontWeight.w600,

                            ),
                            suffixIcon: type == TextFieldTypeEnum.password
                                ? IconButton(
                              icon: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Icon(snapshotObscure.data == true
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              color: Colors.black45,
                              onPressed: () {
                                commonTextFieldBloc.changeVisiblePassword(
                                    !(snapshotObscure.data == true));
                              },
                            )
                                : controller.text!=''
                                ? IconButton(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  icon: SvgIcon(icon: CustomIcon.icon_delete_textfield, size: 20),
                                  onPressed: () {
                                    controller.clear();
                                    commonTextFieldBloc.enterMsgCode('');
                                  }
                                )
                                : null,
                            // errorText: optionalErrorText ?? snapshotValidate.error?.toString(),
                            // errorStyle: TextStyle(
                            //     color: Color(0xffff3b30),
                            //     fontWeight: FontWeight.w600,
                            //     fontSize: 13
                            // ),
                            // errorBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(16),
                            //   borderSide: const BorderSide(
                            //     width: 2,
                            //     color: Color(0xffff3b30)
                            //     ,
                            //   ),
                            // ),
                          ),
                          obscureText: type == TextFieldTypeEnum.password ?
                          !(snapshotObscure.data == true):
                          false,
                          onChanged: (value) {
                            type == TextFieldTypeEnum.email
                                ? commonTextFieldBloc.enterEmail(value)
                                : type == TextFieldTypeEnum.password
                                ? commonTextFieldBloc.enterPassword(value)
                                : null;
                          },
                          controller: controller,
                          keyboardType: type == TextFieldTypeEnum.password
                              ? TextInputType.visiblePassword
                              : type == TextFieldTypeEnum.email
                              ? TextInputType.emailAddress
                              : type == TextInputType.number
                              ? TextInputType.number
                              : TextInputType.text,
                          textInputAction: TextInputAction.done,
                        ),

                      ],
                    ),
                    snapshotValidate.error?.toString()!=null?
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          SvgIcon(icon: CustomIcon.icon_error_input, size: 12),
                          SizedBox(width: 6,),
                          Text('${optionalErrorText??snapshotValidate.error?.toString()}',
                            style: TextStyle(
                                color: Color(0xffff3b30),
                                fontWeight: FontWeight.w600,
                                fontSize: 13
                            ),
                          ),
                        ],
                      ),
                    ):Container()
                  ],
                );
              });
        });
  }
  static Widget CommonOtpTextField(
   BuildContext context,{
      Function(String)? onSubmit,
      Function(String)? onCodeChanged,
      required List<TextStyle?> otpTextStyles,
      required TextEditingController controller,
   }){
    return StreamBuilder<Object>(
        stream: authenticationBloc.otpBehavior,
        builder: (context, snapshot) {
          return OtpTextField(
            numberOfFields: 6,
            focusedBorderColor: color_B3BBC4,
            styles: otpTextStyles,
            borderRadius: BorderRadius.circular(10),
            fieldWidth: 44,
            filled: true,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]", unicode: true)),
            ],
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
                errorText: 'ddd'
            ),
            keyboardType: TextInputType.phone,
            fillColor: color_ECF3FB,
            enabledBorderColor: color_ECF3FB,
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: onCodeChanged,
            //runs when every textfield is filled
            onSubmit: onSubmit // end onSubmit
          );
        }
    );
  }
}

enum TextFieldTypeEnum { password, email, nonSpecial, number }
