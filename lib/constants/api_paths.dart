const String base_url =
    'https://ample-crawdad-kind.ngrok-free.app';
    // 'http://localhost:8080'; //localhost hieutt

    // "http://127.0.0.1:8080/v1";//localhost cua xinh
    //   "http://192.168.1.254:8080/v1";//privateIp cua xinh
    // "http://192.168.6.59:8080/v1";//privateIp cua mang cong ty
const String versions = "/v1";

const String matches_path = '$versions/matches';
const String user_path = '$versions/users';
const String login_path = '$versions/authentication/access_token';
const String test_token_path = '$versions/users/current_user';
const String refresh_token_url = '$versions/authentication/refresh_token';
const String logout_path = '$versions/authentication/logout';
const String login_gg_api = '$versions/authentication/google/login';
const String auth_gg_api = '$versions/authentication/google/auth';
const String reset_password_path = '$versions/authentication/reset_password';
const String finish_match_path = '$versions/matches/finish';
const String API_REGISTER_EMAIL = "$versions/users/email_registration";
const String API_REGISTER_VERIFI = "$versions/users/email_verification";
const String API_CREATE_USER ="$versions/users";
const String MATCH_SETTING ="$versions/match_settings";
const String INVITATION = "$versions/invitations";
const String LOBBY = "$versions/lobbies";
const String EXIT_LOBBY = '$versions/lobbies/exit';

