import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/blocs/module_bloc.dart';
import 'package:flutter_mcq_checker/src/models/module.dart';
import 'package:flutter_mcq_checker/src/widgets/reveal_edit_textfield.dart';

class EditAnswerScreen extends StatelessWidget {
  final ModuleBloc bloc;
  final Module module;
  EditAnswerScreen({this.bloc, this.module});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edit answer'),
      ),
      body: StreamBuilder(
        stream: bloc.answers,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('You did not add answers for this module'),
            );
          }
          return buildBody(snapshot.data);
        },
      ),
    );
  }

  Widget buildBody(List<String> questionAnswers) {
    return ListView.builder(
      itemCount: questionAnswers.length,
      padding: EdgeInsets.all(8.0),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.grey,
          margin: EdgeInsets.only(bottom: 2.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(
              '${questionAnswers[index]}',
              style: TextStyle(color: Colors.white),
            ),
            trailing: RevealTextField(),
          ),
        );
      },
    );
  }
}
