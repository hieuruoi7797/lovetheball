import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splat_mobile/constants/ui_styles.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:splat_mobile/src/blocs/common_textfield_bloc/common_textfield_bloc.dart';

Widget CommonTextField(
  BuildContext context, {
  String? labelText,
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
              return TextField(
                decoration: InputDecoration(
                  fillColor: Color(0xffecf3fb).withOpacity(0.6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      width: 2,
                      style: BorderStyle.none,
                      color: color_main,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                        width: 1,
                        style: BorderStyle.none,
                        color: Color(0xffb3bbc4)

                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      width: 1,
                      style: BorderStyle.none,
                      color: color_main,
                    ),
                  ),
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
                  errorText: snapshotValidate.error?.toString(),
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

enum TextFieldTypeEnum { password, email, nonSpecial }
