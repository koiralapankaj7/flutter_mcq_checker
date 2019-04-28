import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/models/module.dart';
import 'package:flutter_mcq_checker/src/widgets/student_list_tile.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          CupertinoIcons.photo_camera,
          color: Colors.white,
          size: 35.0,
        ),
        tooltip: 'Scan answer',
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: EdgeInsets.all(8.0),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return header();
          }
          return StudentListTile(index: index, scaffold: _scaffoldKey);
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
            'Group - ${module.group} / SEM ${module.sem} / ${module.year}',
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
}
