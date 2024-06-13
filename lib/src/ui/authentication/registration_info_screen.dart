import 'package:flutter/material.dart';
import 'package:splat_mobile/public/widget_item/layout_screen.dart';

import '../../../constants/icon_custom.dart';
import '../../../constants/ui_styles.dart';
import '../../../public/widget_item/svg_icon.dart';
import '../../blocs/authentication/authentication_bloc.dart';
import 'authentication_screen.dart';

class RegistrationInfoScreen extends StatelessWidget {
  const RegistrationInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                        width: 2,
                        color: color_B3BBC4
                    ),
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      width: 2,
                      color: color_B3BBC4,
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
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
        onTapBack: (){
          authenticationBloc.onBackTabScreen(context, '/registerInfoUser');
        },
        // onTapContinue: (){
        //   Navigator.pushNamed(context, "/settingAvatar");
        // },
      resizeToAvoidBottomInset: true,
        floatingActionButton:Padding(
          padding: EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffecf3fb).withOpacity(0.9)
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    const SvgIcon(icon: CustomIcon.icon_hand_note, size: 40),
                    const SizedBox(width: 10,),
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: size.width*0.7,
                      child: const Text(
                        'Tip: Sử dụng tên gọi ở trên sân bóng sẽ giúp đồng đội dễ dàng nhận ra bạn hơn',
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
              SizedBox(height: 20,),
              buttonGen1(
                onTap: (){
                  Navigator.pushNamed(context, "/settingAvatar");
                },
                height: size.height*0.065,
                parentContext: context,
                buttonName: "Tiếp tục",
                width: MediaQuery.sizeOf(context).width * 0.92,
                enableLoadingAnimation: true,
              ),
            ],
          ),
        ),
    );
  }
}
