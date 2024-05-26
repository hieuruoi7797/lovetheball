import 'package:flutter/material.dart';
import 'package:splat_mobile/public/widget_item/layout_screen.dart';

import '../../../constants/ui_styles.dart';
import '../../blocs/authentication/authentication_bloc.dart';

class RegistrationInfoScreen extends StatelessWidget {
  const RegistrationInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutScreen(
        titleAppbar: "THÔNG TIN CÁ NHÂN",
        bodyLayout: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child:  Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text("Tên của bạn là gì?",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
               SizedBox(height: 10,),
              Container(
                alignment: Alignment.centerLeft,
                child: Text("Tên của bạn sẽ hiển thị trên trang cá nhân",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color:color_62737A,
                      letterSpacing: -0.4,
                      wordSpacing: -0.4
                  ),
                ),
              ),
               SizedBox(height: 30,),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:  const BorderSide(
                      width: 2,
                      style: BorderStyle.none,
                      color: color_main,
                    ),
                  ),
                  fillColor: Color(0xffecf3fb).withOpacity(0.9),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                        width: 1,
                        style: BorderStyle.none,
                        color: Color(0xffb3bbc4)

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
                  hintText: "Họ và tên",
                  suffixIcon: authenticationBloc.nickNameController.text !=""
                      ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        authenticationBloc.nickNameController.clear();
                      })
                      : null,
                  alignLabelWithHint: false,
                  filled: true,
                ),
                style: TextStyle(
                    color: Colors.black
                ),
                onChanged: (value){
                },
                controller: authenticationBloc.nickNameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
        onTapBack: (){
          Navigator.pop(context);
        },
        onTapContinue: (){
          Navigator.pushNamed(context, "/settingAvatar");
        },
    );
  }
}
