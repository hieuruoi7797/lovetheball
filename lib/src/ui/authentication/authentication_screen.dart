import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:splat_mobile/public/modal/modal_tab_view.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:splat_mobile/src/blocs/services_bloc.dart';
import 'package:splat_mobile/src/ui/authentication/modal_input_otp.dart';
import 'package:splat_mobile/src/ui/authentication/modal_login_ui.dart';
import 'package:splat_mobile/src/ui/authentication/modal_register_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class LoginScreen extends StatelessWidget {

  LoginScreen({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
        bottomSheet: BottomSheet(
            onClosing: () => {},
            builder: (BuildContext context) {
              return Container(
                height:MediaQuery.viewInsetsOf(context).bottom == 0 ?
                MediaQuery.of(context).size.height * 0.45 :
                MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(
                  top: 35,
                  left: 40,
                  right: 40,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFECF3FB),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Center(
                      child: buttonGen1(
                          onTap: () => showCupertinoModalBottomSheet(
                              expand: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => ModalLoginContent(context)
                          ),
                          parentContext: context,
                          buttonName: localizations.login,
                          nameStyle: const TextStyle(
                              color: Color(0xFF62737A),
                              fontSize: 17,
                              fontWeight: FontWeight.w600
                          ),
                          height: 56,
                          width: MediaQuery.sizeOf(context).width * 0.775,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white
                          )),

                    ),
                    const SizedBox(height: 16,),

                    Center(
                      child: buttonGen1(
                          parentContext: context,
                          buttonName: localizations.sign_up_gg,
                          leftIconPath: 'assets/svg_pictures/google_icon.svg',
                          nameStyle: const TextStyle(
                              color: Color(0xFF62737A),
                              fontSize: 17,
                              fontWeight: FontWeight.w600
                          ),
                          height: 56,
                          width: MediaQuery.sizeOf(context).width * 0.775,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white
                          )),

                    ),
                    const SizedBox(height: 16,),
                    Text(localizations.or,style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFFB3BBC4),),),
                    const SizedBox(height: 16,),
                    Center(
                      child:  buttonGen1(
                        onTap: () => showCupertinoModalBottomSheet(
                            expand: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return ModalTabView();
                            }
                        ),
                        parentContext: context,
                        buttonName: "Tạo tài khoản mới",
                        height: 56,
                        width: MediaQuery.sizeOf(context).width * 0.775,
                      )
                    ),
                    const SizedBox(height: 37),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                            text: "Bằng cách chọn \"Đăng nhập\" hoặc \"Đăng ký/Tạo tài khoản\", bạn đồng ý với ",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF62737A),
                                fontWeight: FontWeight.w400
                            ),
                            children: [
                              TextSpan(
                                text: "Điều khoản",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF007AFF),
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              TextSpan(
                                text: " của Splat",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400
                                ),
                              )
                            ]
                        ),

                        // child: Text(
                        //    Điều khoản của Splat",
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w400
                        //   ),
                        // ),
                      ),
                    )
                  ],
                ),
              );
            }),
        body: CupertinoPageScaffold(
          child: SizedBox.expand(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage(
                          'assets/png_images/background_login.png'),
                      alignment: Alignment.topCenter)),
              child: Center(
                child: Container(
                    margin: const EdgeInsets.only(bottom: 300),
                    child: SvgPicture.asset('assets/svg_pictures/splat_white_text.svg')),
              ),
            ),
          ),
        ));
  }
}

// class LoginScreen extends StatelessWidget {
//
//   LoginScreen({Key? key}):super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context)!;
//     return Scaffold(
//         bottomSheet: BottomSheet(
//             onClosing: () => {},
//             builder: (BuildContext context) {
//               return Container(
//                 height:MediaQuery.viewInsetsOf(context).bottom == 0 ?
//                 MediaQuery.of(context).size.height * 0.45 :
//                 MediaQuery.of(context).size.height * 0.3,
//                 width: MediaQuery.of(context).size.width,
//                 padding: const EdgeInsets.only(
//                   top: 35,
//                   left: 40,
//                   right: 40,
//                 ),
//                 decoration: const BoxDecoration(
//                   color: Color(0xFFECF3FB),
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(30),
//                       topLeft: Radius.circular(30)),
//                 ),
//                 child: Column(
//                   children: [
//                     Center(
//                       child: buttonGen1(
//                           onTap: () => showCupertinoModalBottomSheet(
//                           expand: true,
//                           context: context,
//                           backgroundColor: Colors.transparent,
//                           builder: (context) => ModalLoginContent(context)
//                           ),
//                           parentContext: context,
//                           buttonName: localizations.login,
//                           nameStyle: const TextStyle(
//                             color: Color(0xFF62737A),
//                             fontSize: 17,
//                             fontWeight: FontWeight.w600
//                           ),
//                           height: 56,
//                           width: MediaQuery.sizeOf(context).width * 0.775,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16),
//                               color: Colors.white
//                           )),
//
//                     ),
//                     const SizedBox(height: 16,),
//
//                     Center(
//                       child: buttonGen1(
//                           parentContext: context,
//                           buttonName: localizations.sign_up_gg,
//                           leftIconPath: 'assets/svg_pictures/google_icon.svg',
//                           nameStyle: const TextStyle(
//                               color: Color(0xFF62737A),
//                               fontSize: 17,
//                               fontWeight: FontWeight.w600
//                           ),
//                           height: 56,
//                           width: MediaQuery.sizeOf(context).width * 0.775,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16),
//                               color: Colors.white
//                           )),
//
//                     ),
//                     const SizedBox(height: 16,),
//                     Text(localizations.or,style: const TextStyle(
//                         fontSize: 13,
//                         color: Color(0xFFB3BBC4),),),
//                     const SizedBox(height: 16,),
//                     Center(
//                       child: buttonGen1(
//                           onTap: () => showCupertinoModalBottomSheet(
//                             expand: true,
//                             context: context,
//                             backgroundColor: Colors.transparent,
//                             builder: (context) {
//                               return SingleChildScrollView(
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: <Widget>[
//                                     TabBar(
//                                       tabs: [
//                                         Tab(text: "email",),
//                                         Tab(text: "otp",),
//                                       ],
//                                       controller: TabController(length: 2, vsync: null,),
//                                       indicatorSize: TabBarIndicatorSize.tab,
//                                     ),
//                                     Expanded(
//                                         child: TabBarView(
//                                           children: [TabRegisterAccount(context),TabInputOtp(context)],
//                                         )
//                                     )
//                                   ],
//                                 ),
//                               );
//                             }
//                           ),
//                           parentContext: context,
//                           buttonName: "Tạo tài khoản mới",
//                           height: 56,
//                           width: MediaQuery.sizeOf(context).width * 0.775,
//                       ),
//                     ),
//                     const SizedBox(height: 37),
//                     Center(
//                       child: RichText(
//                         textAlign: TextAlign.center,
//                         text: const TextSpan(
//                           text: "Bằng cách chọn \"Đăng nhập\" hoặc \"Đăng ký/Tạo tài khoản\", bạn đồng ý với ",
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 color: Color(0xFF62737A),
//                                 fontWeight: FontWeight.w400
//                             ),
//                           children: [
//                             TextSpan(
//                               text: "Điều khoản",
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   color: Color(0xFF007AFF),
//                                   decoration: TextDecoration.underline,
//                                   fontWeight: FontWeight.w400
//                               ),
//                             ),
//                             TextSpan(
//                               text: " của Splat",
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400
//                               ),
//                             )
//                           ]
//                         ),
//
//                         // child: Text(
//                         //    Điều khoản của Splat",
//                         //   textAlign: TextAlign.center,
//                         //   style: TextStyle(
//                         //     fontSize: 12,
//                         //     fontWeight: FontWeight.w400
//                         //   ),
//                         // ),
//                       ),
//                     )
//                   ],
//                 ),
//               );
//             }),
//         body: CupertinoPageScaffold(
//           child: SizedBox.expand(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               decoration: const BoxDecoration(
//                   image: DecorationImage(
//                       fit: BoxFit.fitWidth,
//                       image: AssetImage(
//                           'assets/png_images/background_login.png'),
//                       alignment: Alignment.topCenter)),
//               child: Center(
//                 child: Container(
//                     margin: const EdgeInsets.only(bottom: 300),
//                     child: SvgPicture.asset('assets/svg_pictures/splat_white_text.svg')),
//               ),
//             ),
//           ),
//         ));
//
//   }
//
// }

Widget buttonGen1(
{
  required BuildContext parentContext,
  String? buttonName,
  TextStyle? nameStyle,
  double? width,
  double? height,
  BoxDecoration? decoration,
  String leftIconPath = '',
  bool? enableLoadingAnimation = false,
  Function()? onTap,
}
    ) {
  return GestureDetector(
    onTap: onTap ?? () {},
    child: Container(
      width: width ?? MediaQuery.of(parentContext).size.width * 0.47,
      height: height ?? 48,
      decoration: decoration ?? BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: <Color>[
              Color(0xffE55807),
              Color(0xffFF8A4C),
            ], // Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.mirror,
          )
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leftIconPath.isNotEmpty ? Container(
                margin: EdgeInsets.only(right: 8),
                child: SvgPicture.asset(leftIconPath)) :const SizedBox(),
            Text(
              buttonName ?? "Hoàn tất",
              style: nameStyle ?? const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            enableLoadingAnimation == true ?
                StreamBuilder<bool>(
                  stream: applicationBloc.getLoadingStatus,
                  builder: (context, snapshot) {
                    if (snapshot.data == true){
                      return Lottie.asset('assets/animations/dots_loading.json');
                    } else {
                      return const SizedBox();
                    }
                  }
                ):
                const SizedBox(),
          ],
        ),
      ),
    ),
  );
}