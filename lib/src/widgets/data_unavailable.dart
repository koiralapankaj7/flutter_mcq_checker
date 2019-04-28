import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DataUnavailable extends StatelessWidget {
  final String image = 'assets/images/no_data.svg';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(450.0),
            width: ScreenUtil().setWidth(450.0),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(200.0),
            ),
            alignment: Alignment.center,
            child: Center(
              child: SvgPicture.asset(
                image,
                height: ScreenUtil().setHeight(300.0),
                width: ScreenUtil().setWidth(300.0),
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(20.0)),
          Text(
            'No data to display',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(40.0),
              fontWeight: FontWeight.w100,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
