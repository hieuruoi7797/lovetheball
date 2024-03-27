import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splat_mobile/src/ui/authentication/authentication_screen.dart';

import '../../../constants/ui_styles.dart';
import '../../blocs/authentication/authentication_bloc.dart';

class ModalFit extends StatelessWidget {
  const ModalFit({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    var _controllerEmail = TextEditingController();
    var _controllerPassword = TextEditingController();
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width*0.03,
              vertical: size.height*0.03
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: size.width*0.1,),
                Text(
                    'ĐĂNG NHẬP',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black38
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset("assets/svg_pictures/XICON.svg"),
                )
              ],
            ),
          ),
          SizedBox(height: size.height*0.02,),
          Container(
            padding: EdgeInsets.symmetric(vertical:  size.height*0.01, horizontal: size.width*0.04),
            child: StreamBuilder<Object>(
              stream: authenticationBloc.emailValidateBehavior,
              builder: (context, snapshot) {
                return TextField(
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

                    errorText:snapshot.error?.toString(),
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
                    authenticationBloc.setEmail(value);

                  },
                  controller: _controllerEmail,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                );
              }
            )
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical:  size.height*0.01, horizontal: size.width*0.04),
            child: StreamBuilder<Object>(
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
                    hintText: "Password",
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
                  controller: _controllerPassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                );
              }
            ),
          ),

          SizedBox(height: size.height*0.02,),

          StreamBuilder<Object>(
            stream: authenticationBloc.checkRememberPassBehavior,
            builder: (context, snapshot) {
              return Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.blue,
                    value: authenticationBloc.checkRememberPass,
                    onChanged: (bool? value) {
                     authenticationBloc.setCheckRememberPass(value);
                    },
                  ),
                  Text("Ghi nhớ mật khẩu"),
                ],
              );
            }
          ),
          buttonGen1(
            onTap: () => Navigator.of(context).pushNamed('/login'),
            parentContext: context,
            buttonName: "Đăng nhập",
            height: 56,
            width: MediaQuery.sizeOf(context).width * 0.92,)

        ],
      ),
    ));
  }
}
