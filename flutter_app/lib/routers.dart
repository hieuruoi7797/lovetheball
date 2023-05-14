import 'package:flutter_app/fetures/adding_courts/adding_court_screen.dart';
import 'package:flutter_app/fetures/adding_courts/listing_court_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => AddingCourtScreen(),
      routes: [
        GoRoute(
          path: 'listing_court_screen',
          builder: (context, state) => ListingCourtScreen(),
        ),
      ]
    ),
  ],
);