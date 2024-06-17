
import 'package:flutter/material.dart';
import 'package:splat_mobile/public/widget_item/common_text_field.dart';
import '../../../constants/ui_styles.dart';
import '../../blocs/authentication/authentication_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../blocs/common_textfield_bloc/common_textfield_bloc.dart';


Widget TabRegisterAccount(BuildContext context) {
  final localizations = AppLocalizations.of(context)!;
  return StreamBuilder<Object>(
    stream: commonTextFieldBloc.optionalErrorStream,
    builder: (context, snapshot) {
      return Container(
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Email của bạn là gì?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10,),
              const Text("Đăng ký tài khoản Splat mới bằng email của bạn",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color:color_62737A,
                    letterSpacing: -0.4,
                    wordSpacing: -0.4
                ),
              ),
              const SizedBox(height: 30,),
              Container(
                  child: Common.CommonTextField(
                      context,
                      labelText: localizations.email,
                      type: TextFieldTypeEnum.email,
                      enableEmailValidator: true,
                      optionalErrorText: snapshot.hasError? snapshot.error.toString() : null,
                      controller: authenticationBloc.emailController)
              ),
            ],
          ),
        ),
        // onClickButton:(){
        //   authenticationBloc.createUser(
        //     context,
        //     email: authenticationBloc.emailController.text,
        //   );
        // }
      );
    }
  );
}
