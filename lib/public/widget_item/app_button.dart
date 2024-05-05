import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../constants/ui_styles.dart';
import '../../src/blocs/services_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppButton {
  static Widget buildMaterialButton({
    required BuildContext context,
    String? buttonName,
    TextStyle? nameStyle,
    double? width,
    double? height,
    BoxDecoration? decoration,
    String leftIconPath = '',
    bool? enableLoadingAnimation = false,
    Function()? onTap,
  }) {
    final localizations = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: width ?? MediaQuery.of(context).size.width * 0.47,
        height: height ?? 48,
        decoration: decoration ?? BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: <Color>[
                Color(0xffE55807),
                Color(0xffFF8A4C),
              ], // Gradient from https://learnui.design/tools/gradient-generator.html
              tileMode: TileMode.mirror,
            )
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leftIconPath.isNotEmpty ? Container(
                  margin: EdgeInsets.only(right: 8),
                  child: SvgPicture.asset(leftIconPath)) :const SizedBox(),
              Text(
                buttonName ?? localizations.close,
                style: nameStyle ?? const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              enableLoadingAnimation == true ?
              StreamBuilder<bool>(
                  stream: applicationBloc.getLoadingStatus,
                  builder: (context, snapshot) {
                    if (snapshot.data == true){
                      return Lottie.asset('assets/animations/dots_loading.json');
                    } else {
                      return const SizedBox();
                    }
                  }
              ):
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}