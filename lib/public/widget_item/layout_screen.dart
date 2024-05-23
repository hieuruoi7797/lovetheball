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
  const LayoutScreen({super.key,
    required this.titleAppbar,
    required this.bodyLayout,
    required this.onTapBack,
    this.floatingActionButton,
    this.onTapContinue,
    this.titleBtnContinue,
    this.enableLoadingForMainButton}
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
          child: GestureDetector(
              onTap: onTapBack,
              child: Container(
                  decoration: BoxDecoration(
                      color: color_E4EBF2,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.all(10),
                  child:SvgIcon(icon:CustomIcon.back_arrow_ios, size: 12,)
              )
          ),
        ),
      ),
      body: bodyLayout,
      floatingActionButton: floatingActionButton??buttonGen1(
        onTap: onTapContinue??(){},
        parentContext: context,
        buttonName: titleBtnContinue??"Tiep tuc",
        height: 56,
        width: MediaQuery.sizeOf(context).width * 0.92,
        enableLoadingAnimation: enableLoadingForMainButton??false,
      ),
    );
  }
}
