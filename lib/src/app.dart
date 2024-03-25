import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:splat_mobile/src/ui/authentication/authentication_screen.dart';

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
        }
        return null;
      },
      theme: ThemeData(
        primaryColor: const Color(0xFFE55807),
        primaryColorLight: const Color(0xFFE55807),
        primaryIconTheme: const IconThemeData(color: Color(0xFFE55807)),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black.withOpacity(0),
        ),
      ),
      // routes: {
      //   '/': (context) => LoginScreen(),
      //   '/sign_up': (context) => const PlayerCreatingScreen(),
      //   '/home': (context) => const HomeScreen(),
      //   '/game_on': (context) => const GameOnScreen(),
      //   '/overview_history_game': (context) => const OverviewHistoryScreen(),
      // },
      // home: const MyHomePage(),
    );
  }
}
