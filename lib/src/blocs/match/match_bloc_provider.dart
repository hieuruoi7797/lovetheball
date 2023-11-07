import 'package:flutter/material.dart';
import 'package:splat_record/public/public_methods.dart';
import 'package:splat_record/src/blocs/match/match_bloc.dart';

class MatchBlocProvider extends InheritedWidget {
  final MatchBloc matchBloc;

  MatchBlocProvider({Key? key, required Widget? child})
      : matchBloc = MatchBloc(),
        super(key: key, child: child ?? const SizedBox());

  @override
  bool updateShouldNotify(oldWidget) {
    return true;
  }

  static MatchBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<MatchBlocProvider>()
            as MatchBlocProvider)
        .matchBloc;
  }
}
