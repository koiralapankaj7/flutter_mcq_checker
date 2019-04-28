import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/blocs/student_bloc_provider.dart';
import 'package:flutter_mcq_checker/src/models/module.dart';
import 'package:flutter_mcq_checker/src/screens/edit_answer_screen.dart';
import 'package:flutter_mcq_checker/src/screens/student_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens/home_screen.dart';
import '../screens/result_screen.dart';
import '../blocs/module_provider.dart';

class AppRoutes {
  //
  //
  bool firstRun = true;

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return openHomeScreen(settings);
    } else if (settings.name.startsWith('resultScreen')) {
      return openResultScreen(settings);
    } else if (settings.name.startsWith('studentScreen')) {
      return openStudentScreen(settings);
    } else if (settings.name.startsWith('editAnswers')) {
      return openEditAnswerScreen(settings);
    } else {
      throw new Exception('Invalid route: ${settings.name}');
    }
  }

  // Home Page
  MaterialPageRoute openHomeScreen(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        // Initialize ScreenUtil
        ScreenUtil.instance =
            ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
              ..init(context);

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

  // Result Page
  MaterialPageRoute openResultScreen(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        Module module = settings.arguments;
        StudentBloc bloc = StudentProvider.of(context);
        bloc.fetchAllStudent();
        return ResultScreen(module: module, bloc: bloc);
      },
    );
  }

  // Student page
  MaterialPageRoute openStudentScreen(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return StudentScreen();
      },
    );
  }
}

// Edit Answers Page
MaterialPageRoute openEditAnswerScreen(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (BuildContext context) {
      return EditAnswerScreen();
    },
  );
}

final AppRoutes appRoutes = AppRoutes();
