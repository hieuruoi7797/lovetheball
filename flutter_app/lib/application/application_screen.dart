import 'dart:async';
import 'package:flutter_app/fetures/adding_courts/adding_court_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../routers.dart';
import 'application_notifier.dart';

class ApplicationScreen extends StatefulWidget {
  final Iterable<Locale> supportedLocales;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Locale locale;

  const ApplicationScreen(
      {Key? key,
      required this.supportedLocales,
      required this.localizationsDelegates,
      required this.locale})
      : super(key: key);

  @override
  _ApplicationScreenState createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  Timer _timer = Timer.periodic(Duration.zero, (_) {});
  Key key = UniqueKey();

  @override
  void initState() {
    super.initState();
  }

  void _handleUserInteraction() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final appNotifier = Provider.of<ApplicationNotifier>(context);
    return Listener(
        onPointerDown: (_) {
          _handleUserInteraction();
        },
        child: ScreenUtilInit(
            builder: (_, context) => KeyboardDismisser(
                  child: MaterialApp(
                      navigatorKey: appNotifier.materialKey,
                      builder: (context, child) {
                        return MediaQuery(
                          child: child!,
                          data: MediaQuery.of(context)
                              .copyWith(textScaleFactor: 1.0),
                        );
                      },
                      supportedLocales: widget.supportedLocales,
                      localizationsDelegates: widget.localizationsDelegates,
                      locale: widget.locale,
                      theme: appNotifier.themeDefaultData,
                      debugShowCheckedModeBanner: false,
                      onGenerateRoute: Routers.generateRoute,
                      initialRoute: '/adding'),
                )));
  }
}
