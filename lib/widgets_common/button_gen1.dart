import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:splat_mobile/src/blocs/services_bloc.dart';

class ButtonGen1 extends StatelessWidget {
  ButtonGen1({super.key,
    this.buttonName,
    this.nameStyle,
    this.width,
    this.height,
    this.decoration,
    this.leftIconPath = '',
    this.enableLoadingAnimation = false,
    this.onTap,});

  String? buttonName;
  TextStyle? nameStyle;
  double? width;
  double? height;
  BoxDecoration? decoration;
  String leftIconPath = '';
  bool? enableLoadingAnimation = false;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        // width: width ?? MediaQuery
        //     .of(context)
        //     .size
        //     .width * 0.47,
        height: height ?? 48,
        decoration: decoration ?? BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: <Color>[
                Color(0xffE55807),
                Color(0xffFF8A4C),
              ],
              // Gradient from https://learnui.design/tools/gradient-generator.html
              tileMode: TileMode.mirror,
            )
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leftIconPath.isNotEmpty ? Container(
                  margin: EdgeInsets.only(right: 8),
                  child: SvgPicture.asset(leftIconPath)) : const SizedBox(),
              Text(
                buttonName ?? "Hoàn tất",
                style: nameStyle ?? const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              enableLoadingAnimation == true ?
              StreamBuilder<bool>(
                  stream: applicationBloc.getLoadingStatus,
                  builder: (context, snapshot) {
                    if (snapshot.data == true) {
                      return Lottie.asset(
                          'assets/animations/dots_loading.json');
                    } else {
                      return const SizedBox();
                    }
                  }
              ) :
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}