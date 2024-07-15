import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splat_mobile/constants/ui_styles.dart';

class SvgIcon extends StatelessWidget {
  final String icon;
  final Color? color;
  final double size;
  const SvgIcon({Key? key, required this.icon, this.color, required this.size}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/$icon',
      colorFilter: ColorFilter.mode(color??color_62737A,BlendMode.dstIn),
      height: size,
      width: size,
    );
  }
}
