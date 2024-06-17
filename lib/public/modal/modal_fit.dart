import 'package:flutter/material.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';

import '../../constants/icon_custom.dart';
import '../../constants/ui_styles.dart';
import '../../widgets_common/button_gen1.dart';
import '../widget_item/svg_icon.dart';

class ModalFit extends StatelessWidget {
  final String? title;
  final Widget? widgetUnderTitle;
  final dynamic widget;
  final String? buttonName;
  final Widget? footerWidget;
  final Widget? widgetUnderButton;
  final Function()? onClickButton;
  final bool? isShowBack;
  final Function()? onTapBack;
  final bool? enableLoadingForMainButton;

  const ModalFit({super.key,
    this.title,
    this.widget,
    this.buttonName,
    this.footerWidget,
    this.widgetUnderButton,
    this.onClickButton,
    this.isShowBack,
    this.onTapBack,
    this.enableLoadingForMainButton,
    this.widgetUnderTitle});


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
                padding: EdgeInsets.only(
                    left: size.width*0.03,
                    right: size.width*0.03,
                    top: size.height*0.03
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isShowBack==true?
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(right: size.width*0.05),
                      child: GestureDetector(
                          onTap: onTapBack,
                          child: Container(
                              child:SvgIcon(icon:CustomIcon.back_arrow_ios, size: 18,)
                          )
                      ),
                    ):SizedBox(width: size.width*0.08,),
                    Container(
                      alignment: Alignment.center,
                      // padding: EdgeInsets.symmetric(horizontal: size.width*0.1),
                      child:Text(
                        title??'',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: color_313A3E,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                          authenticationBloc.clearAllController();
                        },
                        child: Container(
                            child:SvgIcon(icon:CustomIcon.close, size: 30,)
                        )
                    )
                  ],
                ),
              ),
              widgetUnderTitle??Container(),
              SizedBox(height: size.height*0.02,),
              widget??Container(),
              SizedBox(height: size.height*0.02,),
              buttonName!=null?
              ButtonGen1(
                onTap: onClickButton??(){},
                buttonName: buttonName??"",
                height: 56,
                width: MediaQuery.sizeOf(context).width*0.92,
                enableLoadingAnimation: enableLoadingForMainButton,
              ):Container(),
              SizedBox(height: size.height*0.01,),
              widgetUnderButton??Container()

            ],
          ),
        ));
  }
}