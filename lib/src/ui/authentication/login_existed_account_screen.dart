import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:splat_mobile/constants/icon_custom.dart';
import 'package:splat_mobile/constants/ui_styles.dart';
import 'package:splat_mobile/public/widget_item/layout_screen.dart';
import 'package:splat_mobile/public/widget_item/svg_icon.dart';

class LoginExistedAccount extends StatelessWidget {
  const LoginExistedAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutScreen(
        bodyLayout: Stack(
          children: [
            Container(
              color: color_FFFFFF,
            ),
            Positioned(
              top: 150,
              left: 50,
              right: 50,
              child: Container(
                height: size.height*0.5,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.symmetric(horizontal: size.width*0.1, vertical: size.height*0.03),
                child: SvgIcon(icon: CustomIcon.logo_splat_orange, size: 60),
              ),
            ),
            Container(
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: [

                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
    );
  }
}
