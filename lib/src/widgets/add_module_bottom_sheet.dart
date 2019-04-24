import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class AddModule extends StatelessWidget {
  final BuildContext context;
  final GlobalKey<ScaffoldState> scaffold;
  AddModule({this.scaffold, this.context});

  //
  //
  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        // Most back container for design
        stackBackground(deviceSize),
        // Main Widget which is in middle
        mainWidget(deviceSize),
        // Top widget which is used to show + within circle.
        circleWithPlus(),
      ],
    );
  }

  Widget textField(String lable, String placeHolder) {
    return TextField(
      // User typed text stype
      style: TextStyle(
        fontSize: 24.0,
        color: Colors.white70,
        //fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        // Label style
        labelText: lable,
        labelStyle: TextStyle(
          letterSpacing: 6.0,
          fontSize: 18.0,
          color: Colors.white,
        ),

        // Hint Style
        hintText: placeHolder,
        hintStyle: TextStyle(
          color: Colors.white54,
        ),

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
  }

  Widget stackBackground(Size deviceSize) {
    return Container(
      height: (deviceSize.height * 0.6) + 50.0,
      decoration: BoxDecoration(
        color: Color(0xff232f34),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
    );
  }

  Widget mainWidget(Size deviceSize) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        padding: EdgeInsets.all(20.0),
        height: deviceSize.height * 0.6,
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
            SizedBox(height: 25.0),
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
            SizedBox(height: 30.0),
            textField('Module', 'Programming'),
            SizedBox(height: 16.0),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: textField('Year', '1st'),
                  width: 100.0,
                ),
                // SizedBox(width: 16.0),
                Container(
                  child: textField('Sem', '1st'),
                  width: 100.0,
                ),
                // SizedBox(width: 16.0),
                Container(
                  child: textField('Group', 'L1C2'),
                  width: 150.0,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            textField('Marker', 'Pankaj Koirala'),
            SizedBox(height: 30.0),
            btnAttachAnswer(),
            btnAdd(),
          ],
        ),
      ),
    );
  }

  Widget circleWithPlus() {
    return Container(
      height: 80.0,
      width: 80.0,
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
        height: 60.0,
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

  Widget buildDialog() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 200.0,
        child: Column(
          children: <Widget>[
            Container(
              height: 60.0,
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

  Widget btnAdd() {
    return InkWell(
      onTap: () {
        print('Add Module');
        processImage();
      },
      child: Container(
        height: 60.0,
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
  }

  File pickedImage;

  Future pickImage() async {
    try {
      final File file =
          await ImagePicker.pickImage(source: ImageSource.gallery);
      Navigator.pop(context);

      if (file == null) {
        throw Exception("File is not available");
      }

      pickedImage = file;

      processImage();
    } catch (e) {
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future processImage() async {
    print("Processing image....");
    FirebaseVisionImage image = FirebaseVisionImage.fromFile(pickedImage);
    print('File name is ${pickedImage}');
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    print('Text recognizer is $textRecognizer');
    VisionText text = await textRecognizer.processImage(image);
    print('Text text is ${text.blocks}');

    for (TextBlock block in text.blocks) {
      print('Block is $block');
      for (TextLine textLine in block.lines) {
        print('Textline is $textLine');
        for (TextElement word in textLine.elements) {
          print('Text is ${word.text}');
          print('Working or not?');
        }
      }
    }
  }
}
