import 'package:flutter/material.dart';
import 'package:splat_mobile/src/ui/authorization/login.dart';
import 'package:splat_mobile/src/ui/game_on.dart';
import 'package:splat_mobile/src/ui/authorization/player_creating.dart';
import 'package:splat_mobile/src/ui/history_game/overview_history_screen.dart';

import 'ui/home/home_screen.dart';

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

      theme: ThemeData(
        primaryColor: const Color(0xFFE55807),
        primaryColorLight: const Color(0xFFE55807),
        primaryIconTheme: const IconThemeData(color: Color(0xFFE55807)),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black.withOpacity(0),
        ),
      ),
      routes: {
        '/': (context) => LoginScreen(),
        '/sign_up': (context) => const PlayerCreatingScreen(),
        '/home': (context) => const HomeScreen(),
        '/game_on': (context) => const GameOnScreen(),
        '/overview_history_game': (context) => OverviewHistoryScreen(),
      },
      // home: const MyHomePage(),
    );
  }
}
