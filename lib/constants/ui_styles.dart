import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

///COLORS
const Color color_main = Color(0xFFE55807);
const Color color_loading_background = Colors.blueGrey;
const Color color_button_cancel = Colors.grey;
const Color color_checkbox_remember = Color(0xff30b0c7);
const Color color_007AFF = Color(0xff007aff);
const Color color_FFFFFF = Color(0xFFFFFFFF);
const Color color_62737A = Color(0xff62737a);
const Color color_E4EBF2 = Color(0xffe4ebf2);
const Color color_313A3E = Color(0xff313a3e);
const Color color_ECF3FB = Color(0xffecf3fb);
const Color color_B3BBC4 = Color(0xffb3bbc4);
const Color color_F3F7FE = Color(0xfff3f7fe);
const Color color_E5601A = Color(0xffe5601a);
const Color color_000000 = Color(0xff000000);
const Color color_677986 = Color(0xff677986);
const Color color_627488 = Color(0xff627488);
const Color color_31393E = Color(0xff31393e);
const Color color_ACC7E1 = Color(0xffacc7e1);
///Widgets
const Widget gap_default = SizedBox(height: 16,);
const Widget gap_24 = SizedBox(height: 16,);
const Widget gap_2 = SizedBox(height: 10,);


//TextStyle
const TextStyle title_main_color = TextStyle(
    color: color_main,
    fontSize: 16,
    fontWeight: FontWeight.w600
);

const TextStyle normal_main_color = TextStyle(
    color: color_main,
    fontSize: 14,
    fontWeight: FontWeight.w400
);

const TextStyle title_white_color = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600
);

const TextStyle normal_white_color = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w400
);

const TextStyle title_black_color = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w600
);

const TextStyle name_big_size =  TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700
);

const TextStyle typing_text = TextStyle(
    fontSize: 14
);

const TextStyle headerTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

const TextStyle textButtonBlue = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: color_007AFF,
  fontFamily: 'Inter',
);

const TextStyle textSubTitle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 11,
  letterSpacing: -0.4,
  color: color_627488
);

TextStyle textLabelTab = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13,
    letterSpacing: -0.08,
    color: color_31393E
);
TextStyle textUnSelectLabelTab = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 13,
    letterSpacing: -0.08,
    color: color_627488
);
TextStyle textNameItem = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 17,
    letterSpacing: -0.4,
    color: color_31393E
);
