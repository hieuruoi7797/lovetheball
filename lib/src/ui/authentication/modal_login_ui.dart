import 'package:flutter/material.dart';
import 'package:splat_mobile/public/modal/modal_fit.dart';
import 'package:splat_mobile/public/widget_item/common_text_field.dart';
import 'package:splat_mobile/src/blocs/common_textfield_bloc/common_textfield_bloc.dart';
import '../../../constants/ui_styles.dart';
import '../../blocs/authentication/authentication_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget ModalLoginContent(BuildContext context){
  final size = MediaQuery.sizeOf(context);
  final localizations = AppLocalizations.of(context);

  return ModalFit(
    title: localizations!.login.toUpperCase(),
    enableLoadingForMainButton: true,
    widget: Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical:  size.height*0.01, horizontal: size.width*0.04),
            child: StreamBuilder<String>(
              stream: commonTextFieldBloc.responseErrorStream,
              builder: (context, AsyncSnapshot<String> snapshotError) {
                return Common.CommonTextField(
                    context,
                    labelText: localizations.email,
                    type: TextFieldTypeEnum.email,
                    typeEnableValidate:snapshotError.hasError?TypeEnableValidateEnum.response:TypeEnableValidateEnum.email,
                    // enableEmailValidator: true,
                    hideErrorText: snapshotError.hasError?true:false,
                    focusNode: authenticationBloc.focusNodeEmail,
                    controller: authenticationBloc.emailController);
              }
            )
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical:  size.height*0.01, horizontal: size.width*0.04),
          child: StreamBuilder<String>(
            stream: commonTextFieldBloc.responseErrorStream,
            builder: (context, AsyncSnapshot<String> snapshotError) {
              return Common.CommonTextField(
                  context,
                  labelText: localizations.pass,
                  type: TextFieldTypeEnum.password,
                  typeEnableValidate:snapshotError.hasError?TypeEnableValidateEnum.response:null,

                  optionalErrorText: snapshotError.hasError? snapshotError.error.toString() : null,
                  focusNode: authenticationBloc.focusNodePass,
                  controller: authenticationBloc.passController);
            }
          )
        ),
        StreamBuilder<Object>(
            stream: authenticationBloc.checkRememberPassBehavior,
            builder: (context, snapshot) {
              return Row(
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
                  Text(localizations.rememberPass),
                ],
              );
            }
        ),
      ],
    ),
    buttonName: localizations.login,
    widgetUnderButton: GestureDetector(
      onTap: (){},
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text(
          localizations.forgotPass
        ),
      ),
    ),
    onClickButton: () => authenticationBloc.login(),
  );
}

