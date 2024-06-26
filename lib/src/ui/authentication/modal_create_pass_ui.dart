import 'package:flutter/material.dart';
import '../../../constants/icon_custom.dart';
import '../../../constants/ui_styles.dart';
import '../../../public/widget_item/common_text_field.dart';
import '../../../public/widget_item/svg_icon.dart';
import '../../blocs/authentication/authentication_bloc.dart';
import '../../blocs/common_textfield_bloc/common_textfield_bloc.dart';


Widget TabRegisterPass(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  return StreamBuilder<String>(
    stream: commonTextFieldBloc.checkRePassBehavior,
    builder: (context, AsyncSnapshot<String> snapshot) {
      return Container(
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Thiết lập mật khẩu",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10,),
              const Text("Tạo mật khẩu cho tài khoản của bạn",
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
                  // padding: EdgeInsets.symmetric(vertical:  size.height*0.01, horizontal: size.width*0.04),
                  child:Common.CommonTextField(
                      context,
                      labelText: "Mật khẩu mới",
                      type: TextFieldTypeEnum.password,
                      // typeEnableValidate: TypeEnableValidateEnum.password,
                      onChange: (value){
                        commonTextFieldBloc.checkInputRePass(value);
                      },
                      // enablePassWordValidator:true,
                      // optionalErrorText: snapshotError.hasError? snapshotError.error.toString() : null,
                      controller: authenticationBloc.registerPassController,
                      focusNode: authenticationBloc.focusNodeRePass)

              ),
              SizedBox(height: 20,),
              Container(
                child: Row(
                  children: [
                    snapshot.error.toString()=='Mật khẩu phải có ít nhất 8 ký tự'
                        ?const SvgIcon(icon: CustomIcon.icon_warning, size: 13)
                        :authenticationBloc.registerPassController.text==''
                        ?const SvgIcon(icon: CustomIcon.icon_warning, size: 13)
                        :snapshot.error.toString()=='all'
                        ?const SvgIcon(icon: CustomIcon.icon_warning, size: 13)
                        :const SvgIcon(icon: CustomIcon.icon_check, size: 13),
                    const SizedBox(width: 10,),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: const Text(
                        'Mật khẩu phải có ít nhất 8 ký tự',
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          color: color_62737A,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                child: Row(
                  children: [
                    snapshot.error.toString()=='Mật khẩu phải có ít nhất 1 chữ số'
                    ?const SvgIcon(icon: CustomIcon.icon_warning, size: 13)
                    :authenticationBloc.registerPassController.text==''
                    ?const SvgIcon(icon: CustomIcon.icon_warning, size: 13)
                    :snapshot.error.toString()=='all'
                    ?const SvgIcon(icon: CustomIcon.icon_warning, size: 13)
                    :const SvgIcon(icon: CustomIcon.icon_check, size: 13),
                    const SizedBox(width: 10,),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: const Text(
                        'Mật khẩu phải có ít nhất 1 chữ số',
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          color: color_62737A,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
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