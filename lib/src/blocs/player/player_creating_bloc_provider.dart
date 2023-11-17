import 'package:flutter/cupertino.dart';
import 'package:splat_record/src/blocs/player/player_creating_bloc.dart';

class PlayerCreatingBlocProvider extends InheritedWidget {
  final PlayerCreatingBloc playerBloc;

  PlayerCreatingBlocProvider({Key? key, required Widget? child})
      : playerBloc = PlayerCreatingBloc(),
        super(key: key, child: child ?? const SizedBox());

  @override
  bool updateShouldNotify(oldWidget) {
    return true;
  }

  static PlayerCreatingBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<PlayerCreatingBlocProvider>()
            as PlayerCreatingBlocProvider)
        .playerBloc;
  }
}
