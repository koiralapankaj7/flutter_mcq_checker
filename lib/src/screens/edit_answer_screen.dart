import 'package:flutter/material.dart';

class EditAnswerScreen extends StatefulWidget {
  @override
  _EditAnswerScreenState createState() => _EditAnswerScreenState();
}

// TODO Animation

class _EditAnswerScreenState extends State<EditAnswerScreen>
    with TickerProviderStateMixin {
  final answers = ['A', 'D', 'B', 'C', 'AB', 'C', 'D', 'B', 'A', 'CB'];

  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  initAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    animation = Tween(begin: 40.0, end: 200.0).animate(
      CurvedAnimation(
        curve: Curves.easeIn,
        parent: controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edit answer'),
      ),
      body: ListView.builder(
        itemCount: answers.length,
        padding: EdgeInsets.all(8.0),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.grey,
            margin: EdgeInsets.only(bottom: 2.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(
                '${answers[index]}',
                style: TextStyle(color: Colors.white),
              ),
              trailing: revealTextEditor(index),
            ),
          );
        },
      ),
    );
  }

  Widget revealTextEditor(int index) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        return Container(
          height: 40.0,
          width: animation.value,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: IconButton(
                  onPressed: editIconPressed,
                  icon: Icon(
                    animation.value > 50.0 ? Icons.done : Icons.edit,
                    size: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  editIconPressed() {
    if (controller.status == AnimationStatus.completed) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }
}
