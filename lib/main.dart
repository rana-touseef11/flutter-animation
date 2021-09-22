import 'package:flutter/material.dart';
import 'package:test_animation/globel_style/colors.dart';
import 'package:test_animation/my_home_page/my_home_screed.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
//  final Color myColor = Color(0xff1F232F);
  // final MaterialColor myColor = const MaterialColor(0xff1F232F, const <int, Color>{50: Color(0xff1F232F)});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Animation-Demo',
        theme: ThemeData(
          // scaffoldBackgroundColor: Colors.black,
          // appBarTheme: AppBarTheme(backgroundColor: Colors.blue),
          primarySwatch: Colors.blueGrey,
          buttonColor: Colors.yellow,
          primaryColor: appPrimaryColor,
        ),
        home: MyHomePage());
  }
}
