
const String svg_home_setting = "assets/svg_pictures/setting_orange.svg";
const String svg_home_setting_disable = "assets/svg_pictures/SETTING.svg";
const String svg_basket_home = "assets/svg_pictures/BASKETBALL.svg";
const String svg_basket_home_disable = "assets/svg_pictures/basketball_grey.svg";
const String svg_chart_home = "assets/svg_pictures/matches_orange.svg";
const String svg_chart_home_disable = "assets/svg_pictures/CHART.svg";
const String png_background_home = "assets/png_images/bg_home.png";
const String subtracting = "assets/svg_pictures/SUBTRACTING.svg";
const String svg_adding = "assets/svg_pictures/ADD_PLAYER.svg";
const String svg_matches_list = "assets/svg_pictures/listing_matches_icon.svg";



const String mid_range = 'Mid-Range Shot';
const String layup = 'Lay-Up';
const String three_points = '3-Pointer';
const String assist = 'Assist';
const String rebound = 'rebound';

const String error_unknown = "UNKNOWN";
const String error_fail = "FAIL";

const String access_token_key = 'access_token';
const String refresh_token_key = 'refresh_token';
const String user_info = 'user_info';

const String USER_LOGIN = 'USER_LOGIN';
const String loginSharedPreference = "LOGGEDINKEY";
const String STANDARD_3v3 = "Standard_3v3";
const String STANDARD_5v5 = "Standard_5v5";
const String CUSTOM_MATCH = "Custom";


Map<String, String> headerWithToken(String token) => {
  'Content-Type': 'application/json; charset=UTF-8',
  'Authorization': 'Bearer $token',
};
  Map<String, String> headerWithTokenFormData(String token) => {
  'Content-Type': 'application/x-www-form-urlencoded',
  'Authorization': 'Bearer $token',
};


///Routes
const String HOME = '/home';
const String SETTING_MATCH = '/settingMatch';
const String REGISTER_INFO = '/registerInfoUser';
const String SETTING_AVT = '/settingAvatar';
const String QUICK_MATCH = '/quickMatch';
