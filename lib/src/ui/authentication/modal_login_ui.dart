import 'package:flutter/material.dart';
import 'package:splat_mobile/public/modal/modal_fit.dart';
import 'package:splat_mobile/public/widget_item/common_text_field.dart';
import '../../../constants/ui_styles.dart';
import '../../blocs/authentication/authentication_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget ModalLoginContent(BuildContext context){
  final size = MediaQuery.sizeOf(context);
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final localizations = AppLocalizations.of(context);

  return ModalFit(
    title: localizations!.login.toUpperCase(),
    widget: Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical:  size.height*0.01, horizontal: size.width*0.04),
            child: CommonTextField(
                context,
                labelText: localizations.email,
                type: TextFieldTypeEnum.email,
                enableEmailValidator: true)
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical:  size.height*0.01, horizontal: size.width*0.04),
          child: CommonTextField(
              context,
              labelText: localizations.pass,
              type: TextFieldTypeEnum.password,
              enablePassWordValidator:true)
          // StreamBuilder<Object>(
          //     stream: authenticationBloc.passwordVisibleBehavior,
          //     builder: (context, snapshot) {
          //       return TextField(
          //         obscureText: authenticationBloc.passwordVisible,
          //         decoration: InputDecoration(
          //           border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(16),
          //             borderSide: const BorderSide(
          //               width: 0,
          //               style: BorderStyle.none,
          //             ),
          //           ),
          //           enabledBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(16),
          //             borderSide: const BorderSide(
          //                 width: 1,
          //                 style: BorderStyle.none,
          //                 color: color_main
          //             ),
          //           ),
          //           focusedBorder:OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(16),
          //             borderSide: const BorderSide(
          //               width: 1,
          //               style: BorderStyle.none,
          //               color: color_main,
          //             ),
          //           ),
          //           hintText: localizations.pass,
          //           helperStyle:TextStyle(color:Colors.red.shade700,fontSize: 16,fontWeight: FontWeight.w600),
          //           suffixIcon: IconButton(
          //             icon: Icon(authenticationBloc.passwordVisible
          //                 ? Icons.visibility
          //                 : Icons.visibility_off),
          //             color: Colors.black45,
          //             onPressed: () {
          //               authenticationBloc.visiblePassword();
          //             },
          //           ),
          //           alignLabelWithHint: false,
          //           filled: true,
          //         ),
          //         controller: _controllerPassword,
          //         keyboardType: TextInputType.visiblePassword,
          //         textInputAction: TextInputAction.done,
          //       );
          //     }
          // ),
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
                    activeColor: color_checkbox_remember,
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
    widget2: GestureDetector(
      onTap: (){},
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text(
          localizations.forgotPass
        ),
      ),
    ),
    onClickButton: () => authenticationBloc.login(email: _controllerEmail.text, pw: _controllerPassword.text),
  );
}

