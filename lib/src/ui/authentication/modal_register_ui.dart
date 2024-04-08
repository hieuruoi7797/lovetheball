
import 'package:flutter/material.dart';
import 'package:splat_mobile/public/modal/modal_fit.dart';

import '../../../constants/ui_styles.dart';


Widget ModalRegisterAccount(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  final _controllerEmail = TextEditingController();
  return ModalFit(
    title: "ĐĂNG KÝ",
    buttonName: "Tiếp tục",
    widget:Padding(
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
              suffixIcon: _controllerEmail.text !=""
                  ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _controllerEmail.clear();
                  })
                  : null,
              alignLabelWithHint: false,
              filled: true,
            ),
            onChanged: (value){
              // authenticationBloc.setEmail(value);

            },
            controller: _controllerEmail,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
          )
        ],
      ),
    ),
  );
}
