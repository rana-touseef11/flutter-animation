import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_animation/globel_style/colors.dart';

class MyMediaQuery {
  BuildContext context;
  double? width;
  double? height;
  Orientation? orientation;
  EdgeInsets? edgeInsets;
  double? scaleFactor;
  MyMediaQuery(this.context) {
    MediaQueryData query = MediaQuery.of(context);
    width = query.size.width;
    height = query.size.height;
    orientation = query.orientation;
    edgeInsets = query.viewPadding;
    scaleFactor = query.textScaleFactor;
  }
}

Transform myLoader(
    {double scale = 0.4,
    double top = 0.0,
    double bottom = 0.0,
    double width = 5.0,
    Color color = appPrimaryColor}) {
  return Transform.scale(
      scale: scale,
      child: Padding(
          padding: EdgeInsets.only(top: top, bottom: bottom),
          child: Center(
              child: CircularProgressIndicator(
                  strokeWidth: width, valueColor: AlwaysStoppedAnimation<Color>(color)))));
}
