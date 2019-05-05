import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/blocs/module_bloc.dart';
import 'package:flutter_mcq_checker/src/models/module.dart';

class EditAnswerScreen extends StatefulWidget {
  final ModuleBloc bloc;
  final Module module;
  EditAnswerScreen({this.bloc, this.module});

  @override
  _EditAnswerScreenState createState() => _EditAnswerScreenState();
}

// Animation need to be fixed

class _EditAnswerScreenState extends State<EditAnswerScreen>
    with TickerProviderStateMixin {
  List<AnimationController> controllerList = [];
  List<Animation> animationList = [];

  initAnimation(int length) {
    for (var i = 0; i < length; i++) {
      AnimationController controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      );

      controllerList.add(controller);
    }

    for (var i = 0; i < length; i++) {
      Animation animation = Tween(begin: 40.0, end: 200.0).animate(
        CurvedAnimation(
          curve: Curves.easeInOut,
          parent: controllerList[i],
        ),
      );

      animationList.add(animation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edit answer'),
      ),
      body: StreamBuilder(
        stream: widget.bloc.answers,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('You did not add answers for this module'),
            );
          }
          return buildBody(snapshot.data);
        },
      ),
    );
  }

  Widget buildBody(List<String> questionAnswers) {
    initAnimation(questionAnswers.length);

    return ListView.builder(
      itemCount: questionAnswers.length,
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
              '${questionAnswers[index]}',
              style: TextStyle(color: Colors.white),
            ),
            trailing: revealTextEditor(index),
          ),
        );
      },
    );
  }

  Widget revealTextEditor(int index) {
    Animation animation = animationList[index];

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
                  onPressed: () {
                    editIconPressed(index);
                  },
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

  editIconPressed(int index) {
    AnimationController controller = controllerList[index];

    if (controller.status == AnimationStatus.completed) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (var controller in controllerList) {
      controller.dispose();
    }
  }
}
