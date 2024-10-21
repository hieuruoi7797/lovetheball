const String base_url =
    // 'https://ample-crawdad-kind.ngrok-free.app';
    // 'http://localhost:8080'; //localhost hieutt

    // "http://127.0.0.1:8080/v1";//localhost cua xinh
    //   "http://192.168.1.254:8080/v1";//privateIp cua xinh
    "http://localhost:8080/v1";//privateIp cua mang cong ty
    // "http://192.168.6.59:8080/v1";//privateIp cua mang cong ty

const String matches_path = '/matches';
const String user_path = '/users';
const String login_path = '/authentication/access_token';
const String test_token_path = '/users/current_user';
const String refresh_token_url = '/authentication/refresh_token';
const String logout_path = '/authentication/logout';
const String login_gg_api = '/authentication/google/login';
const String reset_password_path = '/authentication/reset_password';
const String finish_match_path = '/matches/finish';
const String API_REGISTER_EMAIL = "/users/email_registration";
const String API_REGISTER_VERIFI = "/users/email_verification";
const String API_CREATE_USER ="/users";
const String MATCH_SETTING ="/match_setting";
