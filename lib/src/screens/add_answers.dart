import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/widgets/circle_check_box.dart';

class AddAnswer extends StatefulWidget {
  @override
  _AddAnswerState createState() => _AddAnswerState();
}

class _AddAnswerState extends State<AddAnswer> {
  //int count = -1;
  int count = 11;
  TextEditingController totalQuestion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Add answers'),
      ),
      body: count < 0 ? askForTotalQuestion() : createAnswersSelection(),
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

  Widget createAnswersSelection() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
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
                child: Text('${index + 1}'),
              ),
              SizedBox(width: 24.0),
              CircleCheckBox(option: 'A'),
              CircleCheckBox(option: 'B'),
              CircleCheckBox(option: 'C'),
              CircleCheckBox(option: 'D'),
            ],
          ),
        );
      },
    );
  }

  List<Widget> optionRow(int count) {
    List<Widget> widgetList = [];

    for (var i = 0; i < count; i++) {
      Widget widget = Container(
        margin: EdgeInsets.only(bottom: 2.0),
        color: Colors.white70,
        child: Row(
          children: <Widget>[
            CircleAvatar(
              child: Text('${i + 1}'),
            ),
            SizedBox(width: 24.0),
            // CircleCheckBox(option: 'A'),
            // CircleCheckBox(option: 'B'),
            // CircleCheckBox(option: 'C'),
            // CircleCheckBox(option: 'D'),
          ],
        ),
      );

      widgetList.add(widget);
    }

    Widget margin = SizedBox(height: 24.0);
    Widget button = MaterialButton(
      onPressed: () {},
      color: Colors.lightBlue,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Text('Add answers'.toUpperCase()),
    );

    widgetList.add(margin);
    widgetList.add(button);

    return widgetList;
  }

  // Widget option(String option) {
  //   return Container(
  //     width: 40.0,
  //     height: 40.0,
  //     decoration: BoxDecoration(
  //       //color: Colors.blue,
  //       borderRadius: BorderRadius.circular(50.0),
  //       border: Border.all(
  //         color: Colors.blue,
  //         width: 2.0,
  //       ),
  //     ),
  //     margin: EdgeInsets.all(8.0),
  //     child: Center(
  //       child: Text(option),
  //     ),
  //   );
  // }

  Widget buttons() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 24.0),
          child: MaterialButton(
            onPressed: () {},
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
