import 'package:flutter/material.dart';
import 'package:splat_record/src/blocs/match/match_creating_bloc_provider.dart';
import 'package:splat_record/src/ui/game_on.dart';
import 'package:splat_record/src/ui/player_creator.dart';
import 'ui/match_creator.dart';

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
        '/': (context) => const PlayerCreatorScreen(),
        '/home': (context) => const MatchCreatorScreen(),
        '/game_on': (context) => const GameOnScreen()
      },
      // home: const MyHomePage(),
    );
  }
}
