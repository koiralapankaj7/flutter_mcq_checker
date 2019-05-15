import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/blocs/module_provider.dart';

class CircleCheckBox extends StatefulWidget {
  final int index;
  final String answer;
  final List<String> answers;
  CircleCheckBox({this.index, this.answer, this.answers});

  @override
  _CircleCheckBoxState createState() => _CircleCheckBoxState();
}

class _CircleCheckBoxState extends State<CircleCheckBox>
    with TickerProviderStateMixin {
  //
  //
  ModuleBloc bloc;
  bool isSelected = false;
  AnimationController controller;
  Animation flipAnimation;
  //List<String> answers = AddAnswer.answersList;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    flipAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.5, curve: Curves.linear),
      ),
    );

    if (widget.answers[widget.index] != null &&
        widget.answers[widget.index].contains(widget.answer)) {
      isSelected = true;
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    bloc = ModuleProvider.of(context);

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return InkWell(
          onTap: onOptionTap,
          child: Container(
            height: 50.0,
            width: 50.0,
            child: Transform(
              transform: Matrix4.identity()..rotateY(pi * flipAnimation.value),
              alignment: Alignment.center,
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: flipAnimation.value >= 0.5
                      ? Colors.green
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(
                    color: flipAnimation.value >= 0.5
                        ? Colors.transparent
                        : Colors.blue,
                    width: 2.0,
                  ),
                ),
                margin: EdgeInsets.all(8.0),
                child: Center(
                  child: Transform(
                    transform: Matrix4.identity()
                      ..rotateY(-pi * flipAnimation.value),
                    alignment: Alignment.center,
                    child: Text(
                      widget.answer,
                      style: TextStyle(
                        color: flipAnimation.value >= 0.5
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void onOptionTap() {
    if (controller.status == AnimationStatus.completed) {
      isSelected = false;
      controller.reverse();
    } else {
      isSelected = true;
      controller.forward();
    }

    if (isSelected) {
      widget.answers[widget.index] = widget.answers[widget.index] == null
          ? widget.answer
          : widget.answers[widget.index] + widget.answer;
      bloc.changeAnswer(widget.answers);
      //AddAnswer.answersList = answers;
    } else {
      // If selected option is not null and greater than 1. Greater than one means
      // User has selected multiple answer. If user unselect selected answer then remove that
      // unselected option from the answer. If there is only one selected answer and user
      // unselect later then remove that question from the map.
      if (widget.answers[widget.index] != null &&
          widget.answers[widget.index].length > 1) {
        widget.answers[widget.index] = widget.answers[widget.index]
            .replaceFirst(RegExp(widget.answer), '');
      } else {
        widget.answers[widget.index] = null;
      }
      bloc.changeAnswer(widget.answers);
      //AddAnswer.answersList = answers;
    }

    print('${widget.answers.toString()}');
  }
}
