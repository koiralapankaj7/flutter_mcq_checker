import 'package:flutter/material.dart';
import 'student_bloc.dart';

class StudentProvider extends InheritedWidget {
  //
  //
  final StudentBloc bloc;

  StudentProvider({Key key, Widget child})
      : bloc = StudentBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static StudentBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StudentProvider)
            as StudentProvider)
        .bloc;
  }
}
