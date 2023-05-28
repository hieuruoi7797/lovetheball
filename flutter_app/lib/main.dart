import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'application/application_notifier.dart';
import 'application/application_screen.dart';

void main() {
  const String languageCurrent = 'vi';
  runApp(EasyLocalization(
    supportedLocales: [Locale('en', 'US'), Locale('vi', 'VN')],
    path: 'assets/translations',
    startLocale: Locale(languageCurrent),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApplicationNotifier>(
        create: (context) => ApplicationNotifier(context),
        child: ApplicationScreen(
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
        ));
  }
}
