import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/blocs/module_provider.dart';
import 'package:flutter_mcq_checker/src/widgets/circle_check_box.dart';

// class AddAnswer extends StatefulWidget {
//   // final ModuleBloc bloc;
//   // AddAnswer({this.bloc});

//   @override
//   _AddAnswerState createState() => _AddAnswerState();
// }

class AddAnswer extends StatelessWidget {
  ModuleBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = ModuleProvider.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Add answers'),
      ),
      body: StreamBuilder(
        stream: bloc.totalQuestions,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            return askForTotalQuestion();
          }
          return setAnswers(snapshot.data);
        },
      ),
    );
  }

  Widget askForTotalQuestion() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(24.0),
        child: StreamBuilder(
          stream: bloc.totalNoOfQuestions,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
                            bloc.changeTotalQuestion(snapshot.data);
                          },
                    icon: Icon(Icons.add),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget setAnswers(String totalQuestions) {
    final int count = int.parse(totalQuestions);

    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: count + 1,
      itemBuilder: (BuildContext context, int index) {
        final int questionNo = index + 1;

        // Button
        if (index == count) {
          return buttons(count);
        }

        return Container(
          margin: EdgeInsets.only(bottom: 2.0),
          color: Colors.white70,
          child: Row(
            children: <Widget>[
              SizedBox(width: 16.0),
              CircleAvatar(
                child: Text(questionNo.toString()),
              ),
              SizedBox(width: 24.0),
              CircleCheckBox(questionNo: questionNo, answer: 'A'),
              CircleCheckBox(questionNo: questionNo, answer: 'B'),
              CircleCheckBox(questionNo: questionNo, answer: 'C'),
              CircleCheckBox(questionNo: questionNo, answer: 'D'),
            ],
          ),
        );
      },
    );
  }

  Widget buttons(int count) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 24.0),
          child: StreamBuilder(
            stream: bloc.answers,
            builder: (BuildContext context,
                AsyncSnapshot<Map<int, String>> snapshot) {
              return MaterialButton(
                onPressed: () {
                  // if (!snapshot.hasData || snapshot.data.length < count) {
                  //   return null;
                  // }
                  // print('${snapshot.data.toString()}');
                },
                color: Colors.lightBlue,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Text('Add answers'.toUpperCase()),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          child: MaterialButton(
            onPressed: () {
              // setState(() {
              //   count = -1;
              // });
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
}
