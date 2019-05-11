import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/blocs/student_bloc_provider.dart';
import 'package:flutter_mcq_checker/src/models/module.dart';
import 'package:flutter_mcq_checker/src/screens/add_answers.dart';
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
    } else if (settings.name.startsWith('addAnswers')) {
      return openAddAnswerScreen(settings);
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
        ModuleBloc moduleBloc = ModuleProvider.of(context);
        StudentBloc bloc = StudentProvider.of(context);

        if (module.answers != null && module.answers.length > 0) {
          // We stored list as dynamic in database  as List<dynamic>
          // In stream we declared list as List<String>
          // If we pass answers fetched from db directly to stream we will get an exception
          // dart type 'list dynamic ' is not a subtype of type 'list string '
          // So we are creating new list of type string
          List<String> list = List();
          module.answers.forEach((answer) {
            list.add(answer);
          });
          moduleBloc.changeAnswer(list);
        }

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

  // Edit Answers Page
  MaterialPageRoute openEditAnswerScreen(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        Module module = settings.arguments;
        ModuleBloc bloc = ModuleProvider.of(context);

        return EditAnswerScreen(bloc: bloc, module: module);
      },
    );
  }

  // Add Answers Page
  MaterialPageRoute openAddAnswerScreen(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        Module module = settings.arguments;
        ModuleBloc bloc = ModuleProvider.of(context);
        return AddAnswer(module: module, bloc: bloc);
      },
    );
  }
}

final AppRoutes appRoutes = AppRoutes();

// This is just for github
// Second day without coding
// Third day without coding
// Fourth day without coding
// Fifth day missing update to github
// Sixth day without coding
