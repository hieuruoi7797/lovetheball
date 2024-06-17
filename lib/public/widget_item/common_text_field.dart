import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:splat_mobile/constants/ui_styles.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:splat_mobile/src/blocs/common_textfield_bloc/common_textfield_bloc.dart';

class Common{
 static Widget CommonTextField(
      BuildContext context, {
        String? labelText,
        String? optionalErrorText,
        bool? enableEmailValidator,
        bool? enablePassWordValidator,
        TextFieldTypeEnum? type,
        required TextEditingController controller,
      }) {
    final textController = TextEditingController();
    return StreamBuilder<String>(
        stream: enableEmailValidator == true
            ? commonTextFieldBloc.emailValidateBehavior
            : enablePassWordValidator == true
            ? commonTextFieldBloc.passwordValidateBehavior
            : null,
        builder: (context, snapshotValidate) {
          return StreamBuilder<bool>(
              stream: commonTextFieldBloc.visiblePassword,
              builder: (context, snapshotObscure) {
                // Use it to change color for border when textFiled in focus
                FocusNode _focusNode = FocusNode();

                // Color for border
                Color _borderColor = Colors.grey;
                _borderColor = _focusNode.hasFocus ? Colors.orange : Colors.grey;
                return TextField(
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    fillColor: Color(0xffecf3fb).withOpacity(0.6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                          width: 2,
                          color: color_B3BBC4

                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        width: 2,
                        style: BorderStyle.none,
                        color: color_main,
                      ),
                    ),
                    focusColor: color_B3BBC4,
                    hintText: labelText ?? "Email",
                    suffixIcon: type == TextFieldTypeEnum.password
                        ? IconButton(
                      icon: Icon(snapshotObscure.data == true
                          ? Icons.visibility
                          : Icons.visibility_off),
                      color: Colors.black45,
                      onPressed: () {
                        commonTextFieldBloc.changeVisiblePassword(
                            !(snapshotObscure.data == true));
                      },
                    )
                        : controller.text!=''
                        ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          controller.clear();
                        })
                        : null,
                    alignLabelWithHint: false,
                    filled: true,
                    errorText: optionalErrorText ?? snapshotValidate.error?.toString(),
                    errorStyle: TextStyle(
                        color: Color(0xffff3b30),
                        fontWeight: FontWeight.w600,
                        fontSize: 13
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color(0xffff3b30)
                        ,
                      ),
                    ),
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
                      : TextInputType.text,
                  textInputAction: TextInputAction.done,
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

enum TextFieldTypeEnum { password, email, nonSpecial }
