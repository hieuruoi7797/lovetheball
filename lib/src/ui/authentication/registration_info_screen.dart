import 'package:flutter/material.dart';
import 'package:splat_mobile/public/widget_item/app_button.dart';
import 'package:splat_mobile/public/widget_item/common_text_field.dart';
import 'package:splat_mobile/public/widget_item/layout_screen.dart';
import 'package:splat_mobile/src/blocs/common_textfield_bloc/common_textfield_bloc.dart';

import '../../../constants/icon_custom.dart';
import '../../../constants/ui_styles.dart';
import '../../../public/widget_item/svg_icon.dart';
import '../../../widgets_common/button_gen1.dart';
import '../../blocs/authentication/authentication_bloc.dart';

class RegistrationInfoScreen extends StatelessWidget {
  const RegistrationInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutScreen(
        titleAppbar: "THÔNG TIN CÁ NHÂN",
        bodyLayout: StreamBuilder<String>(
          stream: commonTextFieldBloc.checkReNickNameBehavior,
          builder: (context,  AsyncSnapshot<String> snapshot) {
            return Container(
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
                  StreamBuilder<String>(
                    stream: commonTextFieldBloc.responseErrorStream,
                    builder: (context, AsyncSnapshot<String> snapshotError) {
                      return Container(
                        child: Common.CommonTextField(context,
                            controller: authenticationBloc.nickNameController,
                            labelText: 'Họ và tên',
                            type: TextFieldTypeEnum.nonSpecial,
                            typeEnableValidate:snapshotError.hasError?TypeEnableValidateEnum.response:null,
                            optionalErrorText: snapshotError.hasError? snapshotError.error.toString() : null,
                            onChange: (value){
                              commonTextFieldBloc.checkInputReNickName(value);
                              commonTextFieldBloc.enterMsgCode('');
                            },
                            focusNode: authenticationBloc.focusNodeNickName),
                      );
                    }
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Row(
                      children: [
                        snapshot.error.toString()=='Bao gồm cả họ và tên'
                            ?const SvgIcon(icon: CustomIcon.icon_warning, size: 13)
                            :authenticationBloc.nickNameController.text==''
                            ?const SvgIcon(icon: CustomIcon.icon_warning, size: 13)
                            :snapshot.error.toString()=='all'
                            ?const SvgIcon(icon: CustomIcon.icon_warning, size: 13)
                            :const SvgIcon(icon: CustomIcon.icon_check, size: 13),
                        const SizedBox(width: 10,),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: const Text(
                            'Bao gồm cả họ và tên',
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
                        snapshot.error.toString()=='Không có ký tự đặc biệt'
                            ?const SvgIcon(icon: CustomIcon.icon_warning, size: 13)
                            :authenticationBloc.nickNameController.text==''
                            ?const SvgIcon(icon: CustomIcon.icon_warning, size: 13)
                            :snapshot.error.toString()=='all'
                            ?const SvgIcon(icon: CustomIcon.icon_warning, size: 13)
                            :const SvgIcon(icon: CustomIcon.icon_check, size: 13),
                        const SizedBox(width: 10,),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: const Text(
                            'Không có ký tự đặc biệt',
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
                  SizedBox(height: 20,),
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
                            'Tip: Sử dụng tên gọi ở trên sân bóng sẽ giúp đồng đội dễ dàng nhận ra bạn hơn',
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
                  AppButton.buttonGen1(
                    context: context,
                    onTap: (){
                      if(authenticationBloc.nickNameController.text==''){
                        commonTextFieldBloc.enterMsgCode('N000');
                        return;
                      }
                      else{
                        Navigator.popAndPushNamed(context, "/settingAvatar");
                      }
                    },
                    height: size.height*0.065,
                    buttonName: "Tiếp tục",
                    width: MediaQuery.sizeOf(context).width * 0.92,
                    enableLoadingAnimation: true,
                  )
                ],
              ),
            );
          }
        ),
        onTapBack: (){
          authenticationBloc.onBackTabScreen(context, '/registerInfoUser');
        },
        // onTapContinue: (){
        //   Navigator.pushNamed(context, "/settingAvatar");
        // },
      resizeToAvoidBottomInset: true,
      floatingActionButton: Container(),
        // floatingActionButton:Padding(
        //   padding: EdgeInsets.only(left: 30, top: 100),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Container(
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             color: Color(0xffe5601a).withOpacity(0.1)
        //         ),
        //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //         child: Row(
        //           children: [
        //             const SvgIcon(icon: CustomIcon.icon_light_bulb, size: 40),
        //             const SizedBox(width: 10,),
        //             Container(
        //               alignment: Alignment.bottomCenter,
        //               width: size.width*0.7,
        //               child: const Text(
        //                 'Tip: Sử dụng tên gọi ở trên sân bóng sẽ giúp đồng đội dễ dàng nhận ra bạn hơn',
        //                 overflow: TextOverflow.visible,
        //                 style: TextStyle(
        //                   color: color_313A3E,
        //                   fontSize: 13,
        //                   fontWeight: FontWeight.w500,
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       SizedBox(height: 20,),
        //       AppButton.buttonGen1(
        //         context: context,
        //         onTap: (){
        //           Navigator.pushNamed(context, "/settingAvatar");
        //         },
        //         height: size.height*0.065,
        //         buttonName: "Tiếp tục",
        //         width: MediaQuery.sizeOf(context).width * 0.92,
        //         enableLoadingAnimation: true,
        //       ),
        //     ],
        //   ),
        // ),
    );
  }
}
