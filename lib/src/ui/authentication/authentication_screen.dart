import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:splat_mobile/public/modal/modal_tab_view.dart';
import 'package:splat_mobile/public/widget_item/app_button.dart';
import 'package:splat_mobile/src/resources/show_dialog.dart';
import 'package:splat_mobile/src/ui/authentication/modal_login_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:splat_mobile/widgets_common/button_gen1.dart';



class LoginScreen extends StatelessWidget {

  const LoginScreen({Key? key}):super(key: key);
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
                      child: AppButton.buttonGen1(
                          context: context,
                          onTap: () => show.cupertinoModalBottomSheet(ModalLoginContent(context)),
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
                      child: ButtonGen1(
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
                      child:  AppButton.buttonGen1(
                        context: context,
                        onTap: () => show.cupertinoModalBottomSheet(ModalTabView()),
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

