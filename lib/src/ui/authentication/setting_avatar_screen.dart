import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splat_mobile/constants/icon_custom.dart';
import 'package:splat_mobile/public/bottom_sheet/bottom_sheet.dart';
import 'package:splat_mobile/public/widget_item/layout_screen.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';

import '../../../constants/ui_styles.dart';
import '../../../public/widget_item/svg_icon.dart';

class SettingAvatarScreen extends StatelessWidget {
  const SettingAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutScreen(
        titleAppbar: "THÔNG TIN CÁ NHÂN",
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
                child: Text("Hình ảnh đại  cho trang cá nhân của bạn",
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
              GestureDetector(
                onTap: (){
                    BottomSheetCustom.showBottomSheetSelectImage(
                        context: context,
                        onTapCam: () {
                          authenticationBloc.pickImageFromCam(context);
                        },
                        onTapLib: () {

                        }
                    );
                },
                child: Stack(
                  children: [
                    Container(
                      height: size.width*0.6,
                      width: size.height*0.3,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: color_ECF3FB,
                        // image: DecorationImage(
                        //     image: ExactAssetImage('assets/png_images/bg_home.png'),
                        //   fit: BoxFit.cover
                        // ),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow:const [
                            BoxShadow(
                              color: color_F3F7FE,
                              blurRadius: 20,
                              spreadRadius: 0,
                              offset: Offset(0, 5,),
                            ),
                            BoxShadow(
                              color: color_F3F7FE,
                              blurRadius: 0,
                              spreadRadius: 15,
                            ),
                        ]
                      ),
                    ),
                    //check ko co anh moi hien thi
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 85,
                      child: Container(
                        alignment: Alignment.center,
                        child: SvgIcon(
                          icon:CustomIcon.icon_add,
                          size: 50,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        titleBtnContinue: "Hoàn thành",
        onTapBack: (){
          Navigator.pop(context);
        }
    );
  }
}
