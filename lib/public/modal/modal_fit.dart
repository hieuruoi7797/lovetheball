import 'package:flutter/material.dart';

import '../../constants/icon_custom.dart';
import '../../constants/ui_styles.dart';
import '../../src/ui/authentication/authentication_screen.dart';
import '../widget_item/svg_icon.dart';

class ModalFit extends StatelessWidget {
  final String? title;
  final dynamic? widget;
  final String? buttonName;
  final Widget? footerWidget;
  final Widget? widget2;

  const ModalFit({super.key,  this.title,  this.widget,  this.buttonName, this.footerWidget, this.widget2});

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
                    SizedBox(width: size.width*0.1,),
                    Text(
                      title??'ĐĂNG NHẬP',
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
              buttonGen1(
                onTap: () => Navigator.of(context).pushNamed('/login'),
                parentContext: context,
                buttonName: buttonName??"Đăng nhập",
                height: 56,
                width: MediaQuery.sizeOf(context).width * 0.92,
              ),
              widget2??Container()

            ],
          ),
        ));
  }
}