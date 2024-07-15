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
        TypeEnableValidateEnum? typeEnableValidate,
        bool? hideErrorText,
        List<TextInputFormatter>? inputFormatters,
        required TextFieldTypeEnum type,
        required TextEditingController controller,
        required FocusNode focusNode,
        Function(String)? onChange,
      }) {
    final textController = TextEditingController();
    return StreamBuilder<String>(
        stream:
        typeEnableValidate == TypeEnableValidateEnum.email
        ? commonTextFieldBloc.emailValidateBehavior
        : typeEnableValidate == TypeEnableValidateEnum.password
        ? commonTextFieldBloc.passwordValidateBehavior
        : typeEnableValidate == TypeEnableValidateEnum.otp
        ? commonTextFieldBloc.otpValidateBehavior
        : typeEnableValidate == TypeEnableValidateEnum.response
        ? commonTextFieldBloc.responseErrorStream
        : null,
        builder: (context, snapshotValidate) {
          final size = MediaQuery.of(context).size;
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
                            ):
                          type == TextFieldTypeEnum.numberOtp?
                            TextButton(
                                onPressed: (){
                                  commonTextFieldBloc.pasteText();
                                },
                                child: const Text('Paste',
                                  style: TextStyle(
                                      color: color_E5601A,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600
                                  ),
                                )
                            )
                                :controller.text!=''
                                ?IconButton(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  icon: SvgIcon(icon: CustomIcon.icon_delete_textfield, size: 20),
                                  onPressed: () {
                                    commonTextFieldBloc.clearTextField(type, controller);
                                    commonTextFieldBloc.enterMsgCode('');
                                  }
                                )
                            :null,
                          ),
                          obscureText: type == TextFieldTypeEnum.password ?
                          !(snapshotObscure.data == true):
                          false,
                          onChanged: onChange??(value) {
                            type == TextFieldTypeEnum.email
                                ? commonTextFieldBloc.enterEmail(value)
                                : type == TextFieldTypeEnum.password
                                ? commonTextFieldBloc.enterPassword(value)
                                : type == TextFieldTypeEnum.numberOtp
                                ? commonTextFieldBloc.enterResVerifyOtp("")
                                : null;
                          },
                          controller: controller,
                          keyboardType: type == TextFieldTypeEnum.password
                              ? TextInputType.visiblePassword
                              : type == TextFieldTypeEnum.email
                              ? TextInputType.emailAddress
                              : type == TextFieldTypeEnum.numberOtp
                              ? TextInputType.number
                              : TextInputType.text,
                          textInputAction: TextInputAction.done,
                          inputFormatters: inputFormatters,
                        ),

                      ],
                    ),
                    hideErrorText==true?Container()
                    :snapshotValidate.error?.toString()!=null?
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgIcon(icon: CustomIcon.icon_error_input, size: 12),
                          SizedBox(width: 6,),
                          Container(
                            width: size.width*0.85,
                            child: Text('${optionalErrorText??snapshotValidate.error?.toString()}',
                              style: TextStyle(
                                  color: Color(0xffff3b30),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  overflow: TextOverflow.visible
                              ),
                              textAlign: TextAlign.start,
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

}

enum TextFieldTypeEnum { password, email, nonSpecial, numberOtp }
enum TypeEnableValidateEnum { email, password, otp, rePass, reNickname, response,}
