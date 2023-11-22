import 'package:flutter/material.dart';
import 'package:splat_record/src/ui/game_on.dart';
import 'package:splat_record/src/ui/player_creating.dart';
import 'ui/match_creating.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        primaryColor: const Color(0xFFE55807),
        primaryColorLight: const Color(0xFFE55807),
        primaryIconTheme: const IconThemeData(color: Color(0xFFE55807)),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black.withOpacity(0),
        ),
      ),
      routes: {
        '/': (context) => const PlayerCreatingScreen(),
        '/home': (context) => const MatchCreatingScreen(),
        '/game_on': (context) => GameOnScreen()
      },
      // home: const MyHomePage(),
    );
  }
}
