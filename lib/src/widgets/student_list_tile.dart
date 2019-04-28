import 'package:flutter/material.dart';

class StudentListTile extends StatelessWidget {
  final int index;
  final GlobalKey<ScaffoldState> scaffold;

  StudentListTile({this.index, this.scaffold});

  _openStudentScreen() {
    Navigator.of(scaffold.currentContext).pushNamed('studentScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.0),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        onTap: _openStudentScreen,
        contentPadding: EdgeInsets.all(8.0),
        leading: CircleAvatar(
          child: Text(index.toString()),
          backgroundColor: Color(0xE6344955),
        ),
        title: Text(
          'Student Name',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        trailing: Container(
          width: 80.0,
          height: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    left: 10.0, top: 4.0, right: 6.0, bottom: 4.0),
                child: Text(
                  '19',
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                  ),
                  border: Border.all(color: Colors.blue, width: 1.0),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 4.0, top: 8.0, right: 10.0, bottom: 8.0),
                child: Text(
                  '20',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                    // topLeft: Radius.circular(5.0),
                    // bottomLeft: Radius.circular(5.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
