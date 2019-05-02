import 'package:flutter/material.dart';

class AddAnswer extends StatefulWidget {
  @override
  _AddAnswerState createState() => _AddAnswerState();
}

class _AddAnswerState extends State<AddAnswer> {
  int count = 10 + 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Add answers'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          // Button
          if (index == count - 1) {
            return Container(
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
            );
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
                option('A'),
                option('B'),
                option('C'),
                option('D'),
              ],
            ),
          );
        },
      ),
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
                onPressed: () {},
                icon: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
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
            option('A'),
            option('B'),
            option('C'),
            option('D'),
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

  Widget option(String option) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        //color: Colors.blue,
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
          color: Colors.blue,
          width: 2.0,
        ),
      ),
      margin: EdgeInsets.all(8.0),
      child: Center(
        child: Text(option),
      ),
    );
  }
}
