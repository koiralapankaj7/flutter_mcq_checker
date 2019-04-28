import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/blocs/module_bloc.dart';
import 'package:flutter_mcq_checker/src/models/module.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddModule extends StatelessWidget {
  //
  //
  final BuildContext context;
  final GlobalKey<ScaffoldState> scaffold;
  final ModuleBloc bloc;
  AddModule({this.scaffold, this.context, this.bloc});

  //
  //
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        // Most back container for design
        stackBackground(),
        // Main Widget which is in middle
        mainWidget(),
        // Top widget which is used to show + within circle.
        circleWithPlus(),
      ],
    );
  }

  Widget textField(String lable, String placeHolder, Stream<String> stream,
      Function(String) onChanged) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextField(
          onChanged: onChanged,
          // User typed text stype
          style: TextStyle(
            fontSize: ScreenUtil().setSp(35.0),
            color: Colors.white70,
            //fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            // Label style
            labelText: lable,
            labelStyle: TextStyle(
              letterSpacing: 4.0,
              fontSize: ScreenUtil().setSp(30.0),
              color: Colors.white,
            ),

            // Hint Style
            hintText: placeHolder,
            hintStyle: TextStyle(
              color: Colors.white54,
            ),

            errorText: snapshot.error,

            // Text Style
            contentPadding: EdgeInsets.only(left: 16.0, top: 35.0, right: 16.0),

            // Normal border Style
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Colors.grey,
              ),
            ),

            // Focused Border Style
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget stackBackground() {
    return Container(
      height: ScreenUtil().setHeight((ScreenUtil.screenHeight * 0.6) + 90.0),
      decoration: BoxDecoration(
        color: Color(0xff232f34),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
    );
  }

  Widget mainWidget() {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        padding: EdgeInsets.all(20.0),
        height: ScreenUtil().setHeight(ScreenUtil.screenHeight * 0.6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          color: Color(0xff344955),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Top margin
            SizedBox(height: ScreenUtil().setHeight(100.0)),
            // Form heading
            Text(
              'Add module'.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                letterSpacing: 2.0,
                wordSpacing: 3.0,
              ),
              textAlign: TextAlign.center,
            ),
            // Top margin
            SizedBox(height: ScreenUtil().setHeight(50.0)),
            // Module text field
            textField('Module', 'Programming', bloc.module, bloc.changeModule),
            // Top margin
            SizedBox(height: ScreenUtil().setHeight(30.0)),
            // Year, sem and group text field collection
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: textField('Year', '1st', bloc.year, bloc.changeYear),
                  width: ScreenUtil().setWidth(225.0),
                ),
                // SizedBox(width: 16.0),
                Container(
                  child: textField('Sem', '1st', bloc.sem, bloc.changeSem),
                  width: ScreenUtil().setWidth(225.0),
                ),
                // SizedBox(width: 16.0),
                Container(
                  child:
                      textField('Group', 'L1C2', bloc.group, bloc.changeGroup),
                  width: ScreenUtil().setWidth(250.0),
                ),
              ],
            ),
            // Top margin
            SizedBox(height: ScreenUtil().setHeight(30.0)),
            // Marker text field
            textField(
                'Marker', 'Pankaj Koirala', bloc.marker, bloc.changeMarker),
            // Top margin
            SizedBox(height: ScreenUtil().setHeight(50.0)),
            // Button scan correct answer
            btnAttachAnswer(),
            // Button add module
            btnAdd(),
          ],
        ),
      ),
    );
  }

  // Circular design with plus icon
  Widget circleWithPlus() {
    return Container(
      height: ScreenUtil().setHeight(180.0),
      width: ScreenUtil().setWidth(180.0),
      decoration: BoxDecoration(
        color: Color(0xff232f34),
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Color(0xff344955),
          child: Icon(
            CupertinoIcons.add,
            size: 40.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Scan correct answer button
  Widget btnAttachAnswer() {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return buildDialog();
          },
        );
      },
      child: Container(
        height: ScreenUtil().setHeight(100.0),
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          'Scan Correct Answers'.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  // Scanning type displaying dialog i.e, camer or gallery
  Widget buildDialog() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: ScreenUtil().setHeight(400.0),
        child: Column(
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(120.0),
              width: double.maxFinite,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Text(
                'Scan answer using',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w100,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          minRadius: 30.0,
                          child: IconButton(
                            padding: EdgeInsets.only(bottom: 4.0),
                            icon: Icon(
                              CupertinoIcons.photo_camera,
                              size: 40.0,
                            ),
                            onPressed: () {
                              print('Camera');
                              pickImage();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Camera",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          minRadius: 30.0,
                          child: IconButton(
                            padding: EdgeInsets.only(bottom: 4.0),
                            icon: Icon(
                              CupertinoIcons.folder,
                              size: 35.0,
                            ),
                            onPressed: () {
                              print('Gallery');
                              pickImage();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Gallery",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Add module button
  Widget btnAdd() {
    return StreamBuilder(
      stream: bloc.addModuleValidation,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return InkWell(
          onTap: snapshot.hasData ? bloc.submit : null,
          child: Container(
            height: ScreenUtil().setHeight(100.0),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Text(
              'Add Module'.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }

  // Function to pick image
  Future pickImage() async {
    try {
      final File file =
          await ImagePicker.pickImage(source: ImageSource.gallery);
      Navigator.pop(context);

      if (file == null) {
        throw Exception("File is not available");
      }

      processImage(file);
    } catch (e) {
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  // Function for fetching text from image
  Future processImage(File file) async {
    print("Processing image....");
    FirebaseVisionImage image = FirebaseVisionImage.fromFile(file);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText text = await textRecognizer.processImage(image);

    Map<int, String> questionAnswer = Map();
    int questionNo;

    for (TextBlock block in text.blocks) {
      for (TextLine textLine in block.lines) {
        for (TextElement word in textLine.elements) {
          // Removing symbools from the text.
          String text = word.text.replaceAll(new RegExp(r'[^\w\s]+'), '');

          if (isNumber(text)) {
            questionNo = int.parse(text);
            print(questionNo);
          } else {
            // Set answer for question number
            questionAnswer[questionNo] = text;
          }
        }
      }
    }

    List<Map<int, String>> answerList = [questionAnswer];
    bloc.changeAnswer(answerList);
    print(questionAnswer.toString());
  }

  // Function which check either string is number or not
  bool isNumber(String text) {
    if (text == null) {
      return false;
    }
    return num.tryParse(text) != null;
  }
}
