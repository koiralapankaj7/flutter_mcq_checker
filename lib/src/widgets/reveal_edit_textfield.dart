import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/blocs/module_provider.dart';
import 'package:flutter_mcq_checker/src/screens/edit_answer_screen.dart';

class RevealTextField extends StatefulWidget {
  final int index;
  RevealTextField({this.index});

  @override
  _RevealTextFieldState createState() => _RevealTextFieldState();
}

class _RevealTextFieldState extends State<RevealTextField>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  TextEditingController textController = TextEditingController();
  ModuleBloc bloc;
  List<String> answers = EditAnswerScreen.questionAnswers;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    animation = Tween(begin: 40.0, end: 200.0).animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc = ModuleProvider.of(context);

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
                  controller: textController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  autofocus: false,
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

      if (textController.text.trim() != '') {
        answers[widget.index] = textController.text.toUpperCase();
        bloc.changeAnswer(answers);
      }
      print(answers.toList());
      textController.clear();
    } else {
      controller.forward();
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}

// for github
// another day for github
