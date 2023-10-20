import 'package:flutter/material.dart';
import 'ui/home.dart';

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
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

