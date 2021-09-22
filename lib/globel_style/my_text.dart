import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final double? height;
  MyText(
      {Key? key, required this.text, this.color, this.fontSize, this.letterSpacing, this.fontWeight, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("$text",
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          fontWeight: fontWeight,
          height: height,
        ));
  }
}
