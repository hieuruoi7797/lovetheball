import 'package:flutter/material.dart';
import 'package:splat_mobile/public/widget_item/svg_icon.dart';

import '../../constants/icon_custom.dart';
import '../../constants/ui_styles.dart';
import '../../src/ui/authentication/authentication_screen.dart';

class LayoutScreen extends StatelessWidget {
  final String titleAppbar;
  final Widget bodyLayout;
  final Function() onTapBack;
  final Widget? floatingActionButton;
  final Function()? onTapContinue;
  final String? titleBtnContinue;
  final bool? enableLoadingForMainButton;
  final bool? resizeToAvoidBottomInset;
  const LayoutScreen({super.key,
    required this.titleAppbar,
    required this.bodyLayout,
    required this.onTapBack,
    this.floatingActionButton,
    this.onTapContinue,
    this.titleBtnContinue,
    this.enableLoadingForMainButton,
    this.resizeToAvoidBottomInset}
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            titleAppbar,
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
                  child:SvgIcon(icon:CustomIcon.back_arrow_ios, size: 12,)
              )
          ),
        ),
      ),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: bodyLayout,
      floatingActionButton: floatingActionButton??buttonGen1(
        onTap: onTapContinue??(){},
        parentContext: context,
        buttonName: titleBtnContinue??"Tiếp tục",
        height: 56,
        width: MediaQuery.sizeOf(context).width * 0.92,
        enableLoadingAnimation: enableLoadingForMainButton??false,
      ),
    );
  }
}
