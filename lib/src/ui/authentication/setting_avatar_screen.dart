import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:splat_mobile/constants/icon_custom.dart';
import 'package:splat_mobile/public/bottom_sheet/bottom_sheet.dart';
import 'package:splat_mobile/public/widget_item/app_button.dart';
import 'package:splat_mobile/public/widget_item/layout_screen.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';

import '../../../constants/ui_styles.dart';
import '../../../public/widget_item/svg_icon.dart';
import '../../../widgets_common/button_gen1.dart';

class SettingAvatarScreen extends StatelessWidget {
  const SettingAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
      stream: authenticationBloc.imagePickerBehavior,
      builder: (context, snapshot) {
        return LayoutScreen(
            titleAppbar: "THÔNG TIN CÁ NHÂN",
            resizeToAvoidBottomInset: true,
            bodyLayout: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Ảnh đại diện",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Hình ảnh đại diện cho trang cá nhân của bạn",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color:color_62737A,
                          letterSpacing: -0.4,
                          wordSpacing: -0.4
                      ),
                    ),
                  ),
                  SizedBox(height: 100,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Stack(
                      children: [
                        Container(
                          height: size.width*0.5,
                          width: size.height*0.25,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: color_ECF3FB,
                            image: authenticationBloc.avatarFile.path!=''?DecorationImage(
                              image: FileImage(authenticationBloc.avatarFile),
                              fit: BoxFit.cover
                            ):null,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow:const [
                                BoxShadow(
                                  color: color_F3F7FE,
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                  // offset: Offset(5, 5,),
                                  blurStyle: BlurStyle.solid
                                ),
                                BoxShadow(
                                  color: color_F3F7FE,
                                  blurRadius: 0,
                                  spreadRadius: 7,
                                ),

                            ]
                          ),
                        ),
                        //check ko co anh moi hien thi
                        authenticationBloc.avatarFile.path==''?
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 70,
                          child: GestureDetector(
                            onTap: (){
                              BottomSheetCustom.showBottomSheetSelectImage(
                                  context: context,
                                  onTapCam: () {
                                    authenticationBloc.pickImageFromCam(context);
                                  },
                                  onTapLib: () {
                                    authenticationBloc.pickImageFromLib(context);
                                  }
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: SvgIcon(
                                icon:CustomIcon.icon_add,
                                size: 40,
                              ),
                            ),
                          ),
                        )
                        :Container()
                      ],
                    ),
                  ),

                ],
              ),
            ),
          onTapBack: (){
            authenticationBloc.onBackTabScreen(context, '/settingAvatar');
          },
          // onTapContinue: (){
          //   authenticationBloc.createUserLogin(context);
          // },
          floatingActionButton:Padding(
            padding: EdgeInsets.only(left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffe5601a).withOpacity(0.1)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      const SvgIcon(icon: CustomIcon.icon_light_bulb, size: 40),
                      const SizedBox(width: 10,),
                      Container(
                        alignment: Alignment.bottomCenter,
                        width: size.width*0.7,
                        child: const Text(
                          'Tip: Sử dụng hình ảnh thật và rõ mặt sẽ giúp đồng đội dễ dàng nhận diện bạn',
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            color: color_313A3E,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                ButtonGen1(
                  onTap: (){
                    authenticationBloc.createUserLogin(context);
                  },
                  buttonName: "Hoàn thành",
                  height: 56,
                  width: MediaQuery.sizeOf(context).width * 0.92,
                  enableLoadingAnimation: true,
                ),
                SizedBox(height: 10,),
                authenticationBloc.avatarFile.path!=''?AppButton.btnTextCustom(
                  buttonName: 'Thay đổi ảnh',
                  onTap: (){
                    BottomSheetCustom.showBottomSheetSelectImage(
                        context: context,
                        onTapCam: () {
                          authenticationBloc.pickImageFromCam(context);
                        },
                        onTapLib: () {
                          authenticationBloc.pickImageFromLib(context);
                        }
                    );
                  }
                ):Container()
              ],
            ),
          ),
        );
      }
    );
  }
}
