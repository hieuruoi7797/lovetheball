import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splat_record/src/blocs/game_on/game_on_bloc.dart';

import '../constants/constant_values.dart';
import '../constants/ui_styles.dart';

Widget CommonContainer({
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
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 20.0,
          offset: const Offset(0, 6))
    ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
    child: child ?? const SizedBox(),
  );
}

Widget StatInfoEdittingContainer(
    {required BuildContext context,
    double? width,
    double? height,
    EdgeInsets? margin,
    EdgeInsets? padding,
    Widget? child,
    String? statType,
    Stream? quantityStream,
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
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                      color: Colors.black.withOpacity(0.08),
                      spreadRadius: 0.0)
                ], borderRadius: BorderRadius.circular(100), color: Colors.white),
                child: Center(
                  child: SvgPicture.asset(
                    SUBTRACTING,
                    width: 14,
                    height: 14,
                    fit: BoxFit.none,
                  ),
                ),
              ),
            ),
            StreamBuilder<dynamic>(
                stream: quantityStream,
                builder: (context, snapshot) {
                  return Container(
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xFFF1F1F1),
                    ),
                    child: Center(
                      child: Text(
                        snapshot.hasData ? snapshot.data.toString() : '0',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF818181),
                            fontSize: 14),
                      ),
                    ),
                  );
                }),
            GestureDetector(
              onTap: onTapPlus,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                      color: Colors.black.withOpacity(0.08),
                      spreadRadius: 0.0)
                ], borderRadius: BorderRadius.circular(100), color: Colors.white),
                child: Center(
                  child: SvgPicture.asset(
                    ADDING,
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
