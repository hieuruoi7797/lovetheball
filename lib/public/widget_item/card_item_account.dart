import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:splat_mobile/constants/icon_custom.dart';
import 'package:splat_mobile/public/widget_item/svg_icon.dart';

import '../../constants/ui_styles.dart';
import '../app_global.dart';

class CardItemAccount extends StatelessWidget {
  final String userName;
  final String? subTitle;
  final String avatarPath;
  final String? iconPath;
  final Function()? onTap;
  const CardItemAccount({
    super.key,
    required this.userName,
    this.subTitle,
    required this.avatarPath,
    this.iconPath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.blue,
                image:
                // homeBloc.nowUserInfo?.avatar!=''?DecorationImage(
                //     image: FileImage(appGlobal.avatarFile),
                //     fit: BoxFit.cover
                // ):
                DecorationImage(
                    image: AssetImage(
                      "assets/png_images/default_avt.png",
                    ),
                    fit: BoxFit.cover
                )
            ),
          ),
          Container(
            child: Column(
              children: [
                Text(
                    'Hoang Mai',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: color_313A3E,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
                Text(
                  'hoangnv07@gmail.com',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: color_677986,
                      overflow: TextOverflow.ellipsis
                  ),
                ),

              ],
            ),
          ),
          GestureDetector(
              onTap: onTap??(){},
              child: SvgIcon(icon: iconPath??CustomIcon.red_xicon, size: 30)
          )
        ],
      ),
    );
  }
}
