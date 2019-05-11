import 'package:flutter/material.dart';

class RevealTextField extends StatefulWidget {
  @override
  _RevealTextFieldState createState() => _RevealTextFieldState();
}

class _RevealTextFieldState extends State<RevealTextField>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

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
                    editIconPressed();
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

  editIconPressed() {
    if (controller.status == AnimationStatus.completed) {
      controller.reverse();
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
