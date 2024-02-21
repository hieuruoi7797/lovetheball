import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/constant_values.dart';

Widget commonContainer({
  required BuildContext parentContext,
  double? width,
  double? height,
  EdgeInsets? margin,
  EdgeInsets? padding,
  Widget? child,
}) {
  return Container(
    width: width ?? MediaQuery.of(parentContext).size.width * 0.9,
    height: height,
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
        //     boxShadow: [
        //   BoxShadow(
        //       color: Colors.black.withOpacity(0.1),
        //       blurRadius: 20.0,
        //       offset: const Offset(0, 6))
        // ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)),
    child: child ?? const SizedBox(),
  );
}

Widget statInfoEdittingContainer({
  required BuildContext context,
  double? width,
  double? height,
  EdgeInsets? margin,
  EdgeInsets? padding,
  String? statType,
  String? quantity,
  Function()? onTapPlus,
  Function()? onTapSub,
}) {
  return Container(
    margin: margin ?? const EdgeInsets.only(top: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          statType ?? "Lay-up",
          style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF818181),
              fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: onTapSub,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                          color: Colors.black.withOpacity(0.08),
                          spreadRadius: 0.0)
                    ],
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white),
                child: Center(
                  child: SvgPicture.asset(
                    subtracting,
                    width: 14,
                    height: 14,
                    fit: BoxFit.none,
                  ),
                ),
              ),
            ),
            Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xFFF1F1F1),
              ),
              child: Center(
                child: Text(
                  quantity ?? '0',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF818181),
                      fontSize: 14),
                ),
              ),
            ),
            GestureDetector(
              onTap: onTapPlus,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                          color: Colors.black.withOpacity(0.08),
                          spreadRadius: 0.0)
                    ],
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white),
                child: Center(
                  child: SvgPicture.asset(
                    svg_adding,
                    width: 14,
                    height: 14,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget statContainer({
  required BuildContext context,
  EdgeInsets? margin,
  EdgeInsets? padding,
  Widget? child,
  String? statType,
  SvgPicture? svgPicture,
  SvgPicture? svgPicturePicked,
  String? quantity,
  bool? isPicked,
  Function()? onTap,

}) {
  return GestureDetector(
    onTap: onTap ?? () => {},
    child: Container(
      width: MediaQuery.sizeOf(context).width * 0.26,
      height: MediaQuery.sizeOf(context).width * 0.26,
      decoration: BoxDecoration(
        color: isPicked == true ? const Color(0xFFFD8F51) : Colors.white,
        borderRadius: BorderRadius.circular(16)
      ),
      // padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(statType??'',style: TextStyle(
              fontSize: 9,
              color: isPicked == true ? Colors.white : const Color(0xFF818181) ),),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                  width: 24,
                  height: 24,
                  child: isPicked == true ? svgPicturePicked : svgPicture),
              Text(quantity ??'0',style: TextStyle(
                  fontSize: 28,
                  color: isPicked == true ? Colors.white :  const Color(0xFF818181)),)
            ],
          ),
          const Spacer(),
          const Spacer(),
        ],
      )
    ),
  );
}
