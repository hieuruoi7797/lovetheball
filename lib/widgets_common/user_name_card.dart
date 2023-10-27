import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/ui_styles.dart';

StatelessWidget UserNameCard({
  required BuildContext parentContext,
  double? width,
  double? height,
  String? userName,
  IconData? suffixIcon,
}) {
  return Container(
    width: width ??
        MediaQuery
        .of(parentContext)
        .size
        .width,
    height: height ?? 70,
    decoration: BoxDecoration(
      color: Color(0xFFF1F1F1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
          horizontal: 16),
          width: 50,
          height: 50,
          child: CircleAvatar(
            // radius: 50,
            backgroundImage: AssetImage('assets/png_images/avatar_temp.png'),
          ),
        ),
        // Container(
        //   margin: EdgeInsets.symmetric(
        //       horizontal: 16),
        //   width: 50,
        //   height: 50,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(
        //           100),
        //       color: Colors.blue
        //   ),
        // ),
        Text(userName ?? "Unknown",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16),),
        Spacer(),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: 16),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  100),
              color: Colors.white
          ),
          child: Icon(
            suffixIcon ?? CupertinoIcons.xmark,
            size: 14,
            color: color_main,
          ),
        ),
      ],
    ),
  );
}