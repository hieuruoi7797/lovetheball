import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SquareButton extends StatelessWidget {
  double? width;
  double? height;
  Color? color;
  String? iconAssetName;

  SquareButton({super.key, this.width,this.height,this.color,this.iconAssetName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width??40 ,
      height: height??40 ,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color??Colors.white
      ),
      child: SizedBox(
        child: SvgPicture.asset(
            height: 20, width: 20,
            fit: BoxFit.scaleDown,
            iconAssetName??"assets/svg_pictures/menu.svg"),),
    );
  }

}