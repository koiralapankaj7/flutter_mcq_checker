import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/result_screen.dart';
import '../blocs/module_provider.dart';

class AppRoutes {
  bool firstRun = true;
  Route routes(RouteSettings settings) {
    // Home screen
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          final ModuleBloc bloc = ModuleProvider.of(context);

          // During the lifecycle of the application only fetch data once from database
          if (firstRun) {
            bloc.fetchAllModule();
            firstRun = false;
          }
          return HomeScreen(bloc: bloc);
        },
      );
    }
    // Result screen
    else {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ResultScreen();
        },
      );
    }
  }
}

final AppRoutes appRoutes = AppRoutes();
