import 'package:flutter/material.dart';
import '../models/student.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Programming'),
      ),
      body: buildBody(),
    );
  }

  List<Widget> rows = [];

  Widget buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          header(),
          row(1, 'Pankaj Koirala', 20.0),
          row(2, 'Pankaj Koirala', 20.0),
          row(3, 'Pankaj Koirala', 20.0),
          row(4, 'Pankaj Koirala', 20.0),
          row(5, 'Pankaj Koirala', 20.0),
          row(6, 'Pankaj Koirala', 20.0),
        ],
      ),
    );
  }

  Widget header() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              child: Text(
                'S.N',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              child: Text(
                'Name',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              child: Text(
                'Score',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget row(int index, String name, double score) {
    final bool odd = (index % 2) != 0;

    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: odd ? Colors.black38 : Colors.black54,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$index',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            decoration: BoxDecoration(
              color: odd ? Colors.black38 : Colors.black54,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: odd ? Colors.black38 : Colors.black54,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$score',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
