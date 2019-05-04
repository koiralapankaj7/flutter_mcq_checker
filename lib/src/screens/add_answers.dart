import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/blocs/module_provider.dart';
import 'package:flutter_mcq_checker/src/models/module.dart';
import 'package:flutter_mcq_checker/src/widgets/circle_check_box.dart';

class AddAnswer extends StatelessWidget {
  final Module module;
  final ModuleBloc bloc;
  // final GlobalKey _scaffold = GlobalKey();

  AddAnswer({this.module, this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffold,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Answers for ${module.module}'),
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
    return Builder(
      builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 24.0),
              child: MaterialButton(
                onPressed: () async {
                  Map<int, String> answerMap;
                  bloc.answers.listen((map) {
                    answerMap = map;
                  });

                  if (answerMap != null && answerMap.length == count) {
                    print(answerMap.toString());
                    module.setAnswers(answerMap);
                    int result = await bloc.addAnswers(module);
                    if (result == module.id) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Successfully added to database..'),
                      ));
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Something went wrong..'),
                      ));
                    }
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content:
                          Text('Please provide answers for all questions..'),
                    ));
                  }
                },
                color: Colors.lightBlue,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Text('Add answers'.toUpperCase()),
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
      },
    );
  }
}
