import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/models/module.dart';
import '../models/student.dart';

class ResultScreen extends StatelessWidget {
  final Module module;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  ResultScreen({this.module});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(module.module),
        actions: <Widget>[
          Icon(Icons.more_vert),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: EdgeInsets.all(8.0),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return header();
          }
          return buildBody(index);
        },
      ),
    );
  }

  Widget header() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 8.0),
          Text(
            'MCQ Result',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey[300],
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            '${module.group} / SEM - ${module.sem} / ${module.year}',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w100,
              color: Colors.grey[300],
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'Marked by : ${module.marker}',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w100,
              color: Colors.grey[300],
            ),
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }

  _openStudentScreen() {
    Navigator.of(_scaffoldKey.currentContext).pushNamed('studentScreen');
  }

  Widget buildBody(int index) {
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
