import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/src/ui/authentication/authentication_screen.dart';
import 'package:splat_mobile/src/ui/authentication/login_existed_account_screen.dart';
import 'package:splat_mobile/src/ui/authentication/registration_info_screen.dart';
import 'package:splat_mobile/src/ui/authentication/setting_avatar_screen.dart';
import 'package:splat_mobile/src/ui/home/home_screen.dart';
import 'package:splat_mobile/src/ui/lobby/lobby_screen.dart';
import 'package:splat_mobile/src/ui/quick_match/quick_match_screen.dart';
import 'package:splat_mobile/src/ui/setting_match/setting_match_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings){
        switch (settings.name) {
          case '/':
            return MaterialWithModalsPageRoute(
                builder: (_) => LoginScreen(),

                settings: settings);
          case '/home':
            return MaterialWithModalsPageRoute(
                builder: (_) => const HomeScreen(),
                settings: settings);
        }
        return null;
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        // primaryColor: const Color(0xFFE55807),
        // primaryColorLight: const Color(0xFFE55807),
        // primaryIconTheme: const IconThemeData(color: Color(0xFFE55807)),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black.withOpacity(0),
        ),
      ),

      routes: {
      //   '/': (context) => LoginScreen(),
      //   '/sign_up': (context) => const PlayerCreatingScreen(),
        HOME: (context) => const HomeScreen(),
        SETTING_MATCH: (context) => SettingMatchScreen(),
      //   '/game_on': (context) => const GameOnScreen(),
      //   '/overview_history_game': (context) => const OverviewHistoryScreen(),
        REGISTER_INFO: (context) => const RegistrationInfoScreen(),
        SETTING_AVT: (context) => const SettingAvatarScreen(),
        QUICK_MATCH: (context) => const QuickMatchScreen(),
        LOBBY: (context) => const LobbyScreen()
      },
      // home: const MyHomePage(),
    );
  }
}
