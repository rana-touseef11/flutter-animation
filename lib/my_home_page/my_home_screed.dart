import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test_animation/globel_style/colors.dart';
import 'package:test_animation/globel_style/my_animation.dart';
import 'package:test_animation/globel_style/my_media_query.dart';
import 'package:test_animation/globel_style/my_navigator.dart';
import 'package:test_animation/globel_style/my_text.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:test_animation/my_home_page/popular_destination.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> myDestinationsList = [];
  bool loader = false;
  bool location = true;
  bool downTween = false;
  double containerHeight = 0.0;
  bool dateShow = true;
  @override
  Widget build(BuildContext context) {
    MyMediaQuery query = MyMediaQuery(context);
    double? height = query.height;
    return Scaffold(
        body: Column(children: [
      AnimatedContainer(
          duration: Duration(milliseconds: 650),
          height: dateShow ? height! * 0.9 : containerHeight,
          child: ClipPath(
              clipper: MyCustomClipper(),
              child: Container(
                  color: appPrimaryColor,
                  child: Column(children: [
                    SizedBox(height: height! * 0.07),
                    if (dateShow)
                      Column(
                        children: [
                          MyText(
                            text: "You are looking flights from",
                            color: greyColor,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: MyDatePicker(),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    MyText(
                      text: "Departure From:",
                      color: greyColor,
                    ),
                    if (downTween) myTweenContainer(),
                    MyTweenAnimation(
                      child: loader
                          ? MyTweenAnimation(child: myLoader(color: greyColor))
                          : location
                              ? TextButton(
                                  onPressed: () {
                                    setState(() {
                                      downTween = true;
                                    });
                                    myFutureDelay(1, () {
                                      setState(() {
                                        downTween = false;
                                        loader = true;
                                      });
                                      myFutureDelay(2, () {
                                        setState(() {
                                          downTween = true;
                                        });
                                        myFutureDelay(1, () {
                                          setState(() {
                                            loader = false;
                                            location = false;
                                            downTween = false;
                                          });
                                        });
                                      });
                                    });
                                  },
                                  child: MyText(
                                    text: "Nearest Location",
                                    fontSize: 39.0,
                                    color: greyColor.shade700,
                                  ),
                                )
                              : Container(),
                    ),
                    if (!location)
                      MyTweenAnimation(
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  containerHeight = height / 3 - 15;
                                  dateShow = false;
                                });
                                // List<Destinations> destination = [
                                //   Destinations(image: "newyork.jpg", location: "New York", from: r"$23"),
                                //   Destinations(image: "rome.jpg", location: "Rome", from: r"$29"),
                                //   Destinations(image: "london.jpg", location: "London", from: r"$25"),
                                // ];
                                // log("$destination");
                                // destination.forEach((Destinations destinations) {
                                // myDestinationsList.add(destinations);
                                // });
                                // myFutureDelay(1, () {});
                                myNavigator(context, (context) => Populardestination());
                              },
                              child: MyText(
                                text: "London",
                                color: whiteColor,
                                fontSize: 40.0,
                              )))
                  ])))),
      // AnimatedList(
      //     shrinkWrap: true,
      //     initialItemCount: 3,
      //     itemBuilder: (context, index, animation) {
      //       return SlideTransition(
      //         position: animation.drive(_offset),
      //         child: myDestinationsList[index],
      //       );
      //     })
    ]));
  }

  Tween<Offset> _offset = Tween(begin: Offset(1, 0), end: Offset(0, 0));
}

class MyDatePicker extends StatefulWidget {
  @override
  MyDatePickerState createState() => MyDatePickerState();
}

class MyDatePickerState extends State<MyDatePicker> {
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {}

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      selectionTextStyle: TextStyle(color: blackColor),
      monthCellStyle: DateRangePickerMonthCellStyle(textStyle: TextStyle(color: whiteColor)),
      headerStyle:
          DateRangePickerHeaderStyle(textAlign: TextAlign.center, textStyle: TextStyle(color: whiteColor)),
      selectionShape: DateRangePickerSelectionShape.rectangle,
      onSelectionChanged: _onSelectionChanged,
      selectionMode: DateRangePickerSelectionMode.range,
    );
  }
}

Future myFutureDelay(int seconds, VoidCallback onTap) {
  return Future.delayed(Duration(seconds: seconds), onTap);
}

class Destinations {
  final String? image;
  final String? location;
  final String? from;

  Destinations({this.image, this.location, this.from});
}

Widget destinationListGenrate(BuildContext context, Destinations destinations) {
  return InkWell(
      // onTap: () {
      //   myNavigator(context, (context) => DetailsPage(distination: myList[index]));
      // },
      child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: appPrimaryColor.withOpacity(0.7), spreadRadius: 1, blurRadius: 2, offset: Offset(0, 1))
          ]),
          margin: EdgeInsets.symmetric(horizontal: 15.0),
          width: 200,
          height: 200,
          child: Stack(alignment: Alignment.center, children: [
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/${destinations.image}"), fit: BoxFit.cover))),
            Container(color: appPrimaryColor.withOpacity(0.5)),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              MyText(text: "${destinations.location}", color: whiteColor, fontSize: 29.0),
              MyText(text: "FROM ${destinations.from}", color: whiteColor, fontSize: 15.0, height: 1.5)
            ])
          ])));
}
