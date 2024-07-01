import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoundedImage extends StatelessWidget {
  String? assetImage;
  BoxFit? fit;
  Color? color;
  double? width;
  double? height;
  bool? usingSvg;
  RoundedImage({
    super.key,
    this.assetImage,
    this.fit,
    this.color,
    this.width,
    this.height,
    this.usingSvg});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 49,
      height: height ?? 49,
      margin: const EdgeInsets.only(top: 16,bottom: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: color??const Color(0xFFE9F0F9),
          image: usingSvg != true ? DecorationImage(
              fit: fit ?? BoxFit.cover,
              image: AssetImage(assetImage??"assets/png_images/dumb_team_avt.png")
          ):null
      ),
      child: usingSvg == true ?
      SvgPicture.asset(
        assetImage??"",
      ):
      const SizedBox(),
    );
  }
}
