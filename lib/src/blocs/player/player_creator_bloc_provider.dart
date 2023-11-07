import 'package:flutter/cupertino.dart';
import 'package:splat_record/src/blocs/player/player_creator_bloc.dart';

class PlayerCreatorBlocProvider extends InheritedWidget {
  final PlayerCreatorBloc playerBloc;

  PlayerCreatorBlocProvider({Key? key, required Widget? child})
      : playerBloc = PlayerCreatorBloc(),
        super(key: key, child: child ?? const SizedBox());

  @override
  bool updateShouldNotify(oldWidget) {
    return true;
  }

  static PlayerCreatorBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<PlayerCreatorBlocProvider>()
            as PlayerCreatorBlocProvider)
        .playerBloc;
  }
}
