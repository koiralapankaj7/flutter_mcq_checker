import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/blocs/module_provider.dart';
import 'package:flutter_mcq_checker/src/models/module.dart';
import 'package:flutter_mcq_checker/src/widgets/circle_check_box.dart';

class AnswerScreen extends StatelessWidget {
  //
  //
  final Module module;
  final ModuleBloc bloc;
  final bool isEdit;

  AnswerScreen({this.module, this.bloc, this.isEdit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: isEdit
            ? Text('Edit answers for ${module.module}')
            : Text('Add answers for ${module.module}'),
      ),
      body: isEdit ? buildEditBody() : buildAddBody(),
    );
  }

  // Widget to add new answers
  Widget buildAddBody() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(24.0),
        child: StreamBuilder(
          stream: bloc.validTotalQuestion,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.hasData) {
              List<String> answersList = List(snapshot.data);
              return selectAnswersWidget(answersList);
            }
            return totalNoOfQuestionWidget();
          },
        ),
      ),
    );
  }

  // Widget to update existing answers
  Widget buildEditBody() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(24.0),
        child: StreamBuilder(
          stream: bloc.answers,
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.hasData) {
              return selectAnswersWidget(snapshot.data);
            }
            return Container();
          },
        ),
      ),
    );
  }

  // Widget to ask number of questions that user want to add answers for.
  Widget totalNoOfQuestionWidget() {
    return StreamBuilder(
      stream: bloc.totalQuestions,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextField(
                  onChanged: bloc.changeTotalQuestion,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '10',
                    labelText: 'Number of questions',
                    errorText: snapshot.error,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            CircleAvatar(
              child: IconButton(
                onPressed: snapshot.data == null
                    ? null
                    : () {
                        bloc.changeValidTotalQuestion(int.parse(snapshot.data));
                      },
                icon: Icon(Icons.add),
              ),
            ),
          ],
        );
      },
    );
  }

  // Widget which create selectable answers list
  Widget selectAnswersWidget(List<String> answersList) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: answersList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        // Button
        if (index == answersList.length) {
          return buttons(context);
        }

        return Container(
          margin: EdgeInsets.only(bottom: 2.0),
          color: Colors.white70,
          child: Row(
            children: <Widget>[
              SizedBox(width: 16.0),
              CircleAvatar(
                child: Text('${index + 1}'),
              ),
              SizedBox(width: 24.0),
              CircleCheckBox(index: index, answer: 'A', answers: answersList),
              CircleCheckBox(index: index, answer: 'B', answers: answersList),
              CircleCheckBox(index: index, answer: 'C', answers: answersList),
              CircleCheckBox(index: index, answer: 'D', answers: answersList),
            ],
          ),
        );
      },
    );
  }

  // Submit button and cancle button
  Widget buttons(BuildContext cont) {
    bool activateButton = false;
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 24.0),
          child: StreamBuilder(
              stream: bloc.answers,
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.hasData) {
                  for (var ans in snapshot.data) {
                    if (ans == null) {
                      activateButton = false;
                      break;
                    } else {
                      activateButton = true;
                    }
                  }
                }

                return MaterialButton(
                  onPressed: activateButton
                      ? () {
                          submit(cont);
                        }
                      : null,
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Text(
                    isEdit
                        ? 'Update answers'.toUpperCase()
                        : 'Add answers'.toUpperCase(),
                  ),
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

  submit(BuildContext context) async {
    try {
      int result = await bloc.updateModule(module);

      if (result == 1) {
        // Scaffold.of(context).showSnackBar(SnackBar(
        //   content: isEdit
        //       ? Text('Answers updated successfully ..')
        //       : Text('Answers added successfully ..'),
        // ));

        if (!isEdit) {
          bloc.changeValidTotalQuestion(null);
          bloc.changeTotalQuestion('');
        } else {
          //bloc.changeAnswer(null);
        }
        Navigator.pop(context, result);
      } else {
        // Scaffold.of(context).showSnackBar(SnackBar(
        //   content: Text('Something went wrong..'),
        // ));
      }
    } catch (e) {
      print(e);
    }
  }
}
