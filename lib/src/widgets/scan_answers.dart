import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/blocs/module_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ScanAnswers extends StatelessWidget {
  //
  //
  final GlobalKey<ScaffoldState> scaffold;
  final ModuleBloc bloc;
  ScanAnswers({this.scaffold, this.bloc});

  @override
  Widget build(BuildContext context) {
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
                              pickImage(ImageSource.camera);
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
                              pickImage(ImageSource.gallery);
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

  // Function to pick image
  Future pickImage(ImageSource source) async {
    try {
      final File file = await ImagePicker.pickImage(source: source);
      Navigator.pop(scaffold.currentContext);

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

    // List<Map<int, String>> answerList = [questionAnswer];
    bloc.changeAnswer(questionAnswer);
    Navigator.of(scaffold.currentContext)
        .pushNamed('editAnswers', arguments: questionAnswer);
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
