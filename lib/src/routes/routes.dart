import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/models/module.dart';
import 'package:flutter_mcq_checker/src/screens/student_screen.dart';
import '../screens/home_screen.dart';
import '../screens/result_screen.dart';
import '../blocs/module_provider.dart';

class AppRoutes {
  //
  //
  bool firstRun = true;

  Route routes(RouteSettings settings) {
    // switch (settings.name) {
    //   case '/':
    //     return openHomeScreen(settings);
    //     break;
    //   case '/resultScreen,':
    //     return openResultScreen(settings);
    //     break;
    //   case '/studentScreen':
    //     return openStudentScreen(settings);
    //     break;
    //   default:
    //     return null;
    // }

    if (settings.name == '/') {
      return openHomeScreen(settings);
    } else if (settings.name.startsWith('resultScreen')) {
      return openResultScreen(settings);
    } else if (settings.name.startsWith('studentScreen')) {
      return openStudentScreen(settings);
    } else {
      throw new Exception('Invalid route: ${settings.name}');
    }

    // Home screen
    // if (settings.name == '/') {
    //   return MaterialPageRoute(
    //     builder: (BuildContext context) {
    //       final ModuleBloc bloc = ModuleProvider.of(context);

    //       // During the lifecycle of the application only fetch data once from database
    //       if (firstRun) {
    //         bloc.fetchAllModule();
    //         firstRun = false;
    //       }
    //       return HomeScreen(bloc: bloc);
    //     },
    //   );
    // }

    // Result screen
    // else if (settings.name == '/resultScreen') {
    //   return MaterialPageRoute(
    //     builder: (BuildContext context) {
    //       Module module = settings.arguments;
    //       print(module);

    //       return ResultScreen(module: module);
    //     },
    //   );
    // }

    // Student screen
    // else {
    //   return MaterialPageRoute(
    //     builder: (BuildContext context) {
    //       return StudentScreen();
    //     },
    //   );
    // }
  }

  MaterialPageRoute openHomeScreen(RouteSettings settings) {
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

  MaterialPageRoute openResultScreen(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        Module module = settings.arguments;
        print(module);

        return ResultScreen(module: module);
      },
    );
  }

  MaterialPageRoute openStudentScreen(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return StudentScreen();
      },
    );
  }
}

final AppRoutes appRoutes = AppRoutes();
