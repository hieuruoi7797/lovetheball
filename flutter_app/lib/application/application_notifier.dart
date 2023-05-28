import 'package:flutter/material.dart';

class ApplicationNotifier with ChangeNotifier {
  ThemeData themeDefaultData = ThemeData(

      fontFamily: 'Inter',
      textTheme: const TextTheme(
        bodyText2: TextStyle(color: Colors.black45),
      ),
      appBarTheme: const AppBarTheme(centerTitle: true));
  GlobalKey<NavigatorState> materialKey = GlobalKey<NavigatorState>();

  /// Láy device ID

  ApplicationNotifier(BuildContext context) {
  }
}