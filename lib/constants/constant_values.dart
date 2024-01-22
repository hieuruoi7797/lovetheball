import 'package:splat_record/constants/public_values.dart';
import 'package:splat_record/src/blocs/player/user_bloc.dart';

const String SVG_SETTING_HOME = "assets/svg_pictures/setting_orange.svg";
const String SVG_SETTING_HOME_DISABLE = "assets/svg_pictures/SETTING.svg";
const String SVG_BASKETBALL_HOME = "assets/svg_pictures/BASKETBALL.svg";
const String SVG_BASKETBALL_HOME_DISABLE = "assets/svg_pictures/basketball_grey.svg";
const String SVG_CHART_HOME = "assets/svg_pictures/matches_orange.svg";
const String SVG_CHART_HOME_DISABLE = "assets/svg_pictures/CHART.svg";
const String PNG_BACKGROUND_HOME = "assets/png_images/bg_home.png";
const String SUBTRACTING = "assets/svg_pictures/SUBTRACTING.svg";
const String ADDING = "assets/svg_pictures/ADD_PLAYER.svg";
const String LISTING_MATCHES_ICON = "assets/svg_pictures/listing_matches_icon.svg";


const String TWO = 'Mid-Range Shot';
const String LAYUP = 'Lay-Up';
const String THREE = '3-Pointer';
const String ASSIST = 'Assist';
const String REBOUND = 'rebound';

const String ERROR_UNKNOWN = "UNKNOWN";
const String ERROR_FAIL = "FAIL";

Map<String, String> headerWithToken(String token) => {
  'Content-Type': 'application/json; charset=UTF-8',
  'Authorization': 'Bearer $token',
};
Map<String, String> headerWithTokenFormData(String token) => {
  'Authorization': 'Bearer $token',
};