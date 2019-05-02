import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/blocs/student_bloc_provider.dart';
import 'package:flutter_mcq_checker/src/screens/add_answers.dart';
import '../src/routes/routes.dart';
import 'blocs/module_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModuleProvider(
      child: StudentProvider(
        child: MaterialApp(
          // BottomSheet use material canvas color by default. so to remove this we have to override.
          theme: new ThemeData(canvasColor: Colors.transparent),
          //onGenerateRoute: appRoutes.routes,
          home: AddAnswer(),
        ),
      ),
    );
  }
}
