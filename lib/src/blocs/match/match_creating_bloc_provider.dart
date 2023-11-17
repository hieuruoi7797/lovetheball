import 'package:flutter/material.dart';
import 'package:splat_record/public/public_methods.dart';
import 'package:splat_record/src/blocs/match/match_creating_bloc.dart';

class MatchCreatingBlocProvider extends InheritedWidget {
  final MatchCreatingBloc matchBloc;

  MatchCreatingBlocProvider({Key? key, required Widget? child})
      : matchBloc = MatchCreatingBloc(),
        super(key: key, child: child ?? const SizedBox());

  @override
  bool updateShouldNotify(oldWidget) {
    return true;
  }

  static MatchCreatingBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<MatchCreatingBlocProvider>()
            as MatchCreatingBlocProvider)
        .matchBloc;
  }
}
