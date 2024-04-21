import 'package:flutter/material.dart';
import '../../../constants/ui_styles.dart';
import '../../blocs/authentication/authentication_bloc.dart';


Widget TabRegisterPass(BuildContext context) {
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
          StreamBuilder<Object>(
              stream: authenticationBloc.passwordVisibleBehavior,
              builder: (context, snapshot) {
                return TextField(
                  obscureText: authenticationBloc.passwordVisible,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                          width: 1,
                          style: BorderStyle.none,
                          color: color_main
                      ),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        width: 1,
                        style: BorderStyle.none,
                        color: color_main,
                      ),
                    ),
                    hintText: "Mật khẩu mới",
                    helperStyle:TextStyle(color:Colors.red.shade700,fontSize: 16,fontWeight: FontWeight.w600),
                    suffixIcon: IconButton(
                      icon: Icon(authenticationBloc.passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      color: Colors.black45,
                      onPressed: () {
                        authenticationBloc.setPassword();
                      },
                    ),
                    alignLabelWithHint: false,
                    filled: true,
                  ),
                  controller: authenticationBloc.passController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                );
              }
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