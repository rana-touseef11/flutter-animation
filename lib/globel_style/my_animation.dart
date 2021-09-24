import 'package:flutter/material.dart';

Widget myTweenContainer() {
  return TweenAnimationBuilder(
    duration: Duration(seconds: 1),
    tween: Tween<double>(begin: 0, end: 1),
    builder: (BuildContext context, double value, Widget? child) {
      return Container(
        padding: EdgeInsets.only(top: value * 15.0),
      );
    },
  );
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();
    path.lineTo(0.0, height - 25);
    path.lineTo(width / 2, height);
    path.lineTo(width, height - 25);
    path.lineTo(width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class MyTweenAnimation extends StatelessWidget {
  final Widget? child;
  final double? top;
  final double? bottom;
  MyTweenAnimation({Key? key, this.child, this.top = 0.0, this.bottom = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        duration: Duration(seconds: 1),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (BuildContext context, double value, Widget? myChild) {
          return Opacity(
              opacity: value,
              child: Padding(
                padding: EdgeInsets.only(top: value * 15.0),
                child: myChild,
              ));
        },
        child: child);
  }
}
