import 'package:flutter/material.dart';
import 'module_bloc.dart';
export 'module_bloc.dart';

class ModuleProvider extends InheritedWidget {
  final ModuleBloc bloc;

  ModuleProvider({Key key, Widget child})
      : bloc = ModuleBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static ModuleBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ModuleProvider)
            as ModuleProvider)
        .bloc;
  }
}
