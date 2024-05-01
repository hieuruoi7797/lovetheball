import 'package:flutter/material.dart';

import '../../constants/icon_custom.dart';
import '../../constants/ui_styles.dart';
import '../../src/ui/authentication/authentication_screen.dart';
import '../widget_item/svg_icon.dart';

class ModalFit extends StatelessWidget {
  final String? title;
  final dynamic widget;
  final String? buttonName;
  final Widget? footerWidget;
  final Widget? widget2;
  final Function()? onClickButton;
  final bool? isShowBack;
  final Function()? onTapBack;
  final bool? enableLoadingForMainButton;

  const ModalFit({super.key,
    this.title,
    this.widget,
    this.buttonName,
    this.footerWidget,
    this.widget2,
    this.onClickButton,
    this.isShowBack,
    this.onTapBack,
    this.enableLoadingForMainButton});


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Material(
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width*0.05,
                    vertical: size.height*0.03
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isShowBack==true?
                    Container(
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
                    ):Container(),
                    Text(
                      title??'',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: color_313A3E,
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: color_E4EBF2,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.all(10),
                            child:SvgIcon(icon:CustomIcon.close, size: 12,)
                        )
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height*0.02,),
              widget??Container(),
              SizedBox(height: size.height*0.02,),
              buttonName!=null?
              buttonGen1(
                onTap: onClickButton??(){},
                parentContext: context,
                buttonName: buttonName??"",
                height: 56,
                width: MediaQuery.sizeOf(context).width * 0.92,
                enableLoadingAnimation: enableLoadingForMainButton,
              ):Container(),
              widget2??Container()

            ],
          ),
        ));
  }
}