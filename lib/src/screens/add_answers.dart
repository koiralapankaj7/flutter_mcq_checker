import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/blocs/module_provider.dart';
import 'package:flutter_mcq_checker/src/models/module.dart';
import 'package:flutter_mcq_checker/src/widgets/circle_check_box.dart';

class AddAnswer extends StatelessWidget {
  //
  //
  final Module module;
  final ModuleBloc bloc;
  // This list is used just for setting size of the list as per number of question
  // This list is accessed by circle check box to initialize list with fixed size
  static List<String> answersList;

  AddAnswer({this.module, this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Answers for ${module.module}'),
      ),
      // body: StreamBuilder(
      //   stream: bloc.totalQuestions,
      //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      //     if (snapshot.data == null) {
      //       return askForTotalQuestionWidget();
      //     }
      //     return selectAnswersWidget(snapshot.data);
      //   },
      // ),
      body: StreamBuilder(
        stream: bloc.answers,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (!snapshot.hasData) {
            return askForTotalQuestionWidget();
          } else {
            return Center(
              child: Text('Answer has been already added for this module.'),
            );
          }
          //return selectAnswersWidget(snapshot.data);
        },
      ),
    );
  }

  Widget askForTotalQuestionWidget() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(24.0),
        child: StreamBuilder(
          stream: bloc.totalNoOfQuestions,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            //
            //
            if (!snapshot.hasData) {
              return totalNoOfQuestionWidget(snapshot);
            }

            selectAnswersWidget(snapshot.data);
          },
        ),
      ),
    );
  }

  Widget totalNoOfQuestionWidget(AsyncSnapshot<String> snapshot) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextField(
              onChanged: bloc.changeTotalNoOfQuestion,
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
            onPressed: !snapshot.hasData
                ? null
                : () {
                    bloc.changeTotalNoOfQuestion(snapshot.data);
                  },
            icon: Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget selectAnswersWidget(String totalQuestions) {
    final int totalNoOfQuestion = int.parse(totalQuestions);
    answersList = List(totalNoOfQuestion);

    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: totalNoOfQuestion + 1,
      itemBuilder: (BuildContext context, int index) {
        // Button
        if (index == totalNoOfQuestion) {
          return buttons();
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
              CircleCheckBox(index: index, answer: 'A'),
              CircleCheckBox(index: index, answer: 'B'),
              CircleCheckBox(index: index, answer: 'C'),
              CircleCheckBox(index: index, answer: 'D'),
            ],
          ),
        );
      },
    );
  }

  Widget buttons() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 24.0),
          child: StreamBuilder(
              stream: bloc.answers,
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                this.context = context;

                bool activateBUtton = false;
                if (snapshot.hasData) {
                  snapshot.data.forEach((String answer) {
                    if (answer == null) {
                      activateBUtton = false;
                    } else {
                      activateBUtton = true;
                    }
                  });
                }

                return MaterialButton(
                  onPressed: activateBUtton ? addAnswer : null,
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Text('Add answers'.toUpperCase()),
                );
              }),
        ),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          child: MaterialButton(
            onPressed: () {
              bloc.changeTotalQuestion(null);
              bloc.changeTotalNoOfQuestion('');
            },
            color: Colors.lightBlue,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Text('Reset'.toUpperCase()),
          ),
        ),
      ],
    );
  }

  BuildContext context;

  addAnswer() async {
    try {
      int result = await bloc.updateModule(module);
      print('Result is $result');
      print('Module id is ${module.id}');
      if (result == module.id) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Answers added successfully ..'),
        ));
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Something went wrong..'),
        ));
      }
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(e),
      ));
    }
  }
}
