
import 'package:flutter/material.dart';
import 'package:splat_mobile/public/widget_item/common_text_field.dart';
import '../../../constants/ui_styles.dart';
import '../../blocs/authentication/authentication_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../blocs/common_textfield_bloc/common_textfield_bloc.dart';


Widget TabRegisterAccount(BuildContext context) {
  final localizations = AppLocalizations.of(context)!;
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
              child: StreamBuilder<String>(
                  stream: commonTextFieldBloc.responseErrorStream,
                  builder: (context, AsyncSnapshot<String> snapshotError) {
                    return Common.CommonTextField(
                        context,
                        labelText: localizations.email,
                        type: TextFieldTypeEnum.email,
                        typeEnableValidate: snapshotError.hasError?TypeEnableValidateEnum.response:TypeEnableValidateEnum.email,
                        optionalErrorText: snapshotError.hasError? snapshotError.error.toString() : null,
                        focusNode: authenticationBloc.focusNodeReE,
                        controller: authenticationBloc.registerEmailController);
                  }
              )
          ),
        ],
      ),
    ),
  );
}
