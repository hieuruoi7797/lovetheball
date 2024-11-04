import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splat_mobile/constants/ui_styles.dart';
import 'package:splat_mobile/public/widget_item/svg_icon.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:splat_mobile/src/blocs/home_bloc/home_bloc.dart';
import 'package:splat_mobile/src/models/player_model.dart';

import '../../../constants/icon_custom.dart';
import '../../../public/app_global.dart';

class SettingScreen extends StatelessWidget {
  final int tab;
  const SettingScreen({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Container(
          color: color_8DA3BC.withOpacity(0.2),
        ),
        SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Thiet Lap',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 28,
                    color: color_31393E,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color_FFFFFF
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 48,
                        height:48,
                        decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blue,
                            image: DecorationImage(
                                image: FileImage(appGlobal.avatarFile),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Container(
                        width: 280,
                        child: Text('Xinh dddddd',
                          style: TextStyle(
                            fontSize: 22,
                            color: color_31393E,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SvgIcon(icon: CustomIcon.icon_edit, size: 17,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _itemSetting(
    {required String label, required String iconPath}) {
  return Container(
    width: 127,
    height: 125,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 22,
          height: 22,
          child: SvgPicture.asset(iconPath),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),
        ),
        // SizedBox(
        //   height: 23,
        // ),
      ],
    ),
  );
}

Widget _itemAchivement(
    {required String label, int? value, required String iconPath}) {
  return Column(
    children: [
      Text(
        label,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 16,
      ),
      Row(
        children: [
          Container(
            width: 22,
            height: 22,
            child: SvgPicture.asset(iconPath),
          ),
          SizedBox(
            width: 10,
          ),
          value != null
              ? Text(
                  value.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 28),
                )
              : const SizedBox()
        ],
      ),
      SizedBox(
        height: 23,
      ),
    ],
  );
}
