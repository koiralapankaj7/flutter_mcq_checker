import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mcq_checker/src/blocs/module_bloc.dart';
import 'package:flutter_mcq_checker/src/widgets/scan_answers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddModuleBottomSheet extends StatelessWidget {
  //
  //
  final GlobalKey<ScaffoldState> scaffold;
  final ModuleBloc bloc;
  AddModuleBottomSheet({this.scaffold, this.bloc});

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
        bottomSheetLogo(),
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
            scanAnswer(),
            SizedBox(height: ScreenUtil().setHeight(50.0)),
            // Button add module
            btnAddModule(),
          ],
        ),
      ),
    );
  }

  Widget scanAnswer() {
    return StreamBuilder(
      stream: bloc.answers,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 32.0, top: 16.0, right: 16.0, bottom: 16.0),
                child: Text(
                  snapshot.hasData
                      ? 'Scanned successfully'
                      : 'Scan correct answers. You can scan answers later as well.',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            CircleAvatar(
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: scaffold.currentContext,
                    builder: (BuildContext context) {
                      return ScanAnswers(
                        scaffold: scaffold,
                        bloc: bloc,
                      );
                    },
                  );
                },
                icon: Icon(snapshot.hasData ? Icons.done : Icons.scanner),
              ),
            ),
          ],
        );
      },
    );
  }

  // Add module button
  Widget btnAddModule() {
    return StreamBuilder(
      stream: bloc.addModuleValidation,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 40.0),
          child: MaterialButton(
            onPressed: snapshot.hasData ? bloc.submit : null,
            height: ScreenUtil().setHeight(100.0),
            color: Colors.blue,
            disabledColor: Colors.grey[500],
            disabledTextColor: Colors.black38,
            elevation: 30.0,
            disabledElevation: 30.0,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Text(
              'Add Module'.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        );
      },
    );
  }

  // Circular design with plus icon
  Widget bottomSheetLogo() {
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
            CupertinoIcons.bookmark,
            size: 40.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
