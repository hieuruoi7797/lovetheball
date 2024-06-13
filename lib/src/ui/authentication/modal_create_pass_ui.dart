import 'package:flutter/material.dart';
import '../../../constants/ui_styles.dart';
import '../../../public/widget_item/common_text_field.dart';
import '../../blocs/authentication/authentication_bloc.dart';
import '../../blocs/common_textfield_bloc/common_textfield_bloc.dart';


Widget TabRegisterPass(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
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
              child: StreamBuilder<String>(
                  stream: commonTextFieldBloc.optionalErrorStream,
                  builder: (context, AsyncSnapshot<String> snapshotError) {
                    return CommonTextField(
                        context,
                        labelText: "Mật khẩu mới",
                        type: TextFieldTypeEnum.password,
                        enablePassWordValidator:true,
                        optionalErrorText: snapshotError.hasError? snapshotError.error.toString() : null,
                        controller: authenticationBloc.passController);
                  }
              )
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