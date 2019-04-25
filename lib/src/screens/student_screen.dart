import 'package:flutter/material.dart';

class StudentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Student name'),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      child: Text('Student screen'),
    );
  }
}
