import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/fetures/adding_courts/adding_court_notifier.dart';
import 'package:flutter_app/fetures/adding_courts/adding_court_screen.dart';
import 'package:flutter_app/fetures/listing_courts/listing_court_notifier.dart';
import 'package:flutter_app/fetures/listing_courts/listing_court_screen.dart';
import 'package:provider/provider.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case '/adding':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<AddingCourtNotifier>(
                create: (context) => AddingCourtNotifier(context),
                child: AddingCourtScreen()));
      case '/listing':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<ListingCourtNotifier>(
                create: (context) => ListingCourtNotifier(context),
                child: ListingCourtScreen()));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text(
                    'No route defined for ${settings.name}',
                    style: TextStyle(color: Colors.white),
                  )),
                ));
    }
  }
}
