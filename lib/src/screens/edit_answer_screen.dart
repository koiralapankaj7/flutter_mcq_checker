import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/blocs/module_bloc.dart';
import 'package:flutter_mcq_checker/src/models/module.dart';
import 'package:flutter_mcq_checker/src/widgets/reveal_edit_textfield.dart';

class EditAnswerScreen extends StatelessWidget {
  final ModuleBloc bloc;
  final Module module;
  EditAnswerScreen({this.bloc, this.module});

  static List<String> questionAnswers;

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
          if (snapshot.hasData) {
            print('Stream is called');
            questionAnswers = snapshot.data;
            return buildBody();
          } else {
            return Center(
              child: Text('You did not add answers for this module'),
            );
          }
        },
      ),
    );
  }

  Widget buildBody() {
    return ListView.builder(
      itemCount: questionAnswers.length + 1,
      padding: EdgeInsets.all(8.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == questionAnswers.length) {
          return buttons();
        }
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
            trailing: RevealTextField(index: index),
          ),
        );
      },
    );
  }

  Widget buttons() {
    bool activateBUtton = false;
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 24.0),
          child: StreamBuilder(
              stream: bloc.answers,
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.hasData) {
                  snapshot.data.forEach((String answer) {
                    if (answer == null) {
                      activateBUtton = false;
                      return;
                    } else {
                      activateBUtton = true;
                    }
                  });
                }
                return MaterialButton(
                  onPressed: activateBUtton
                      ? () {
                          //addAnswer(context);
                        }
                      : null,
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Text('Update'.toUpperCase()),
                );
              }),
        ),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          child: MaterialButton(
            onPressed: () {
              bloc.changeValidTotalQuestion(null);
              bloc.changeTotalQuestion('');
            },
            color: Colors.lightBlue,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Text('Cancle'.toUpperCase()),
          ),
        ),
      ],
    );
  }
}
