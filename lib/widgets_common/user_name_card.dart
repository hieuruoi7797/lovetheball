import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splat_record/src/app.dart';

import '../constants/constant_values.dart';
import '../constants/ui_styles.dart';

StatelessWidget userNameCard({
  required BuildContext parentContext,
  double? width,
  double? height,
  String? userName,
  Widget? suffixIcon,
  Function()? onTapSuffix,
}) {
  return Container(
    width: width ?? MediaQuery.of(parentContext).size.width,
    height: height ?? 70,
    decoration: BoxDecoration(
      color: const Color(0xFFF1F1F1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          // width: 50,
          height: 50,
          child: const CircleAvatar(
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
        SizedBox(
          width: width ?? MediaQuery.of(parentContext).size.width * 0.4,
          child: Text(
            userName ?? ERROR_UNKNOWN,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 16),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTapSuffix,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.white),
            child: suffixIcon ?? const Icon(
              CupertinoIcons.xmark,
              size: 14,
              color: color_main,
            ),
          ),
        ),
      ],
    ),
  );
}
