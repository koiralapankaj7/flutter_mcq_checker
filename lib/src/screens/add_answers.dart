import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/blocs/module_provider.dart';
import 'package:flutter_mcq_checker/src/widgets/circle_check_box.dart';

class AddAnswer extends StatefulWidget {
  @override
  _AddAnswerState createState() => _AddAnswerState();
}

class _AddAnswerState extends State<AddAnswer> {
  //int count = -1;
  int count = 11;
  TextEditingController totalQuestion = TextEditingController();
  ModuleBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = ModuleProvider.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Add answers'),
      ),
      body: count < 0 ? askForTotalQuestion() : setAnswers(),
    );
  }

  Widget askForTotalQuestion() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(24.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: totalQuestion,
                  decoration: InputDecoration(
                    hintText: '10',
                    labelText: 'Number of questions',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            CircleAvatar(
              child: IconButton(
                onPressed: () {
                  setState(() {
                    count = int.parse(totalQuestion.text) + 1;
                    totalQuestion.text = '';
                  });
                },
                icon: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget setAnswers() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        final int questionNo = index + 1;

        // Button
        if (index == count - 1) {
          return buttons();
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

  Widget buttons() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 24.0),
          child: MaterialButton(
            onPressed: () {
              bloc.answers.listen((map) {
                print(map.length);
              });
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
              setState(() {
                count = -1;
              });
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
