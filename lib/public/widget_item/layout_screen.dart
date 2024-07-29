import 'package:flutter/material.dart';
import 'package:splat_mobile/public/widget_item/app_button.dart';
import 'package:splat_mobile/public/widget_item/svg_icon.dart';

import '../../constants/icon_custom.dart';
import '../../constants/ui_styles.dart';
import '../../src/ui/authentication/authentication_screen.dart';
import '../../widgets_common/button_gen1.dart';

class LayoutScreen extends StatelessWidget {
  final String? titleAppbar;
  final Widget bodyLayout;
  final Function()? onTapBack;
  final Widget? floatingActionButton;
  final Function()? onTapContinue;
  final String? titleBtnContinue;
  final bool? enableLoadingForMainButton;
  final bool? resizeToAvoidBottomInset;
  final PreferredSizeWidget? bottomAppbar;
  final Function()? onClose;
  final String? subTitle;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomSheet;
  const LayoutScreen({super.key,
    this.titleAppbar,
    required this.bodyLayout,
    this.onTapBack,
    this.floatingActionButton,
    this.onTapContinue,
    this.titleBtnContinue,
    this.enableLoadingForMainButton,
    this.resizeToAvoidBottomInset,
    this.bottomAppbar,
    this.onClose,
    this.subTitle,
    this.floatingActionButtonLocation,
    this.bottomSheet}
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppbar!=null?AppBar(
        title: subTitle!=null?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                titleAppbar??"",
                style: headerTextStyle,
                textAlign: TextAlign.center,
            ),
            SizedBox(height: 5,),
            Text(
              subTitle??"",
              style: textSubTitle,
              textAlign: TextAlign.center,
            ),
          ],
        ):
        Text(
          titleAppbar??"",
          style: headerTextStyle,
          textAlign: TextAlign.center,
        ),
        leading: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
              onTap: onTapBack,
              child: Container(
                  padding: EdgeInsets.all(10),
                  child:SvgIcon(icon:CustomIcon.back_arrow_ios, size: 20,)
              )
          ),
        ),
        bottom: bottomAppbar,
        actions: onClose!=null?[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
                onTap: onClose,
                child: Container(
                    padding: EdgeInsets.all(10),
                    child:SvgIcon(icon:CustomIcon.close, size: 30,)
                )
            ),
          )
        ]:null,
      ):null,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: bodyLayout,
      floatingActionButtonLocation: floatingActionButtonLocation?? FloatingActionButtonLocation.centerFloat,
      floatingActionButton: titleBtnContinue!=null?floatingActionButton??AppButton.buttonGen1(
        onTap: onTapContinue??(){},
        buttonName: titleBtnContinue??"Tiếp tục",
        height: 56,
        width: MediaQuery.sizeOf(context).width * 0.92,
        enableLoadingAnimation: enableLoadingForMainButton??false,
        context: context,
      ):null,
      bottomSheet: bottomSheet,
    );
  }
}
