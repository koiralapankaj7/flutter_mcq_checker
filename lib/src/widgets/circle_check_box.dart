import 'dart:math';

import 'package:flutter/material.dart';

class CircleCheckBox extends StatefulWidget {
  final String option;
  CircleCheckBox({this.option});

  @override
  _CircleCheckBoxState createState() => _CircleCheckBoxState();
}

class _CircleCheckBoxState extends State<CircleCheckBox>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation flipAnimation;

  initAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    flipAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.5, curve: Curves.linear),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAnimation();
  }

  @override
  Widget build(BuildContext context) {
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
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                margin: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(widget.option),
                  // child: Transform.rotate(
                  //   angle: flipAnimation.value >= 0.5
                  //       ? 3 * pi * flipAnimation.value
                  //       : 0.0,
                  //   child: Text(widget.option),
                  // ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void onOptionTap() {
    print('Clicked');
    if (controller.status == AnimationStatus.completed) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }
}
