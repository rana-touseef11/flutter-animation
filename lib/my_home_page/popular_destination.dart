import 'package:flutter/material.dart';
import 'package:test_animation/globel_style/colors.dart';
import 'package:test_animation/globel_style/my_animation.dart';
import 'package:test_animation/globel_style/my_media_query.dart';
import 'package:test_animation/globel_style/my_navigator.dart';
import 'package:test_animation/globel_style/my_text.dart';
import 'package:test_animation/my_home_page/detail_page.dart';

class Populardestination extends StatefulWidget {
  Populardestination({Key? key}) : super(key: key);

  @override
  _PopulardestinationState createState() => _PopulardestinationState();
}

class _PopulardestinationState extends State<Populardestination> {
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List popularDestinations = [
    {"image": "newyork.jpg", "location": "New York", "from": "\$23"},
    {"image": "rome.jpg", "location": "Rome", "from": "\$29"},
    {"image": "london.jfif", "location": "London", "from": "\$25"}
  ];
  @override
  Widget build(BuildContext context) {
    MyMediaQuery query = MyMediaQuery(context);
    double? width = query.width;
    double? height = query.height;
    return Scaffold(
        appBar: PreferredSize(
            child: ClipPath(
                clipper: MyCustomClipper(),
                child: Container(
                    color: appPrimaryColor,
                    child: SafeArea(
                      child: Column(children: [
                        SizedBox(height: height! * 0.06),
                        MyText(text: "Departure From:", color: greyColor),
                        SizedBox(height: height * 0.05),
                        TextButton(
                            onPressed: () {}, child: MyText(text: "London", fontSize: 40.0, color: whiteColor))
                      ]),
                    ))),
            preferredSize: Size(width!, height / 3 - 15)),
        body: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: MyText(
              text: "POPULAR DestinationS",
              color: greyColor,
              letterSpacing: 1.0,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 20),
          destinationList(popularDestinations, context),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: MyText(
              text: "CHEAPEST",
              color: greyColor,
              letterSpacing: 1.0,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 20),
          destinationList(popularDestinations, context),
          SizedBox(height: 30)
        ])));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();
    path.lineTo(0, height * 0.8);
    path.lineTo(width / 2, height * 0.8 + 20);
    path.lineTo(width, height * 0.8);
    path.lineTo(width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}

Widget destinationList(List myList, BuildContext context) {
  return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(myList.length, (index) {
        return InkWell(
            onTap: () {
              myNavigator(context, (context) => DetailsPage(distination: myList[index]));
            },
            child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: appPrimaryColor.withOpacity(0.7),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1))
                ]),
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                width: 200,
                height: 200,
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/${myList[index]["image"]}"), fit: BoxFit.cover))),
                  Container(color: appPrimaryColor.withOpacity(0.5)),
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    MyText(text: "${myList[index]["location"]}", color: whiteColor, fontSize: 29.0),
                    MyText(text: "FROM ${myList[index]["from"]}", color: whiteColor, fontSize: 15.0, height: 1.5)
                  ])
                ])));
      })));
}
