
import 'package:flutter/material.dart';
import '../../../constants/ui_styles.dart';
import '../../blocs/authentication/authentication_bloc.dart';


Widget TabRegisterAccount(BuildContext context) {
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
          TextField(
            decoration: InputDecoration(
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
              hintText: "Email",

              // errorText:snapshot.error?.toString(),
              // helperText:"Username must contain special character",
              // helperStyle:TextStyle(color:Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
              suffixIcon: authenticationBloc.emailController.text !=""
                  ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    authenticationBloc.emailController.clear();
                  })
                  : null,
              alignLabelWithHint: false,
              filled: true,
            ),
            onChanged: (value){
              // authenticationBloc.setEmail(value);

            },
            controller: authenticationBloc.emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
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
