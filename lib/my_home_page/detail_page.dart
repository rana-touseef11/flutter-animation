import 'package:flutter/material.dart';
import 'package:test_animation/globel_style/colors.dart';
import 'package:test_animation/globel_style/my_media_query.dart';
import 'package:test_animation/globel_style/my_text.dart';
import 'package:test_animation/my_home_page/my_home_screed.dart';

class DetailsPage extends StatefulWidget {
  final Destinations? distination;
  DetailsPage({Key? key, this.distination}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> with SingleTickerProviderStateMixin {
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  double height = 0.0;
  double width = 0.0;
  List airLineRates = [
    {
      "image": "pia.png",
      "flightName": "PIA",
      "from": "Lahore",
      "departureTime": "17:00",
      "arrival": "Islamabad",
      "arrivalTime": "20:00",
      "totalTime": "4h",
      "price": "340"
    },
    {
      "image": "serene.png",
      "flightName": "Serene Air",
      "from": "Lahore",
      "departureTime": "17:00",
      "arrival": "Islamabad",
      "arrivalTime": "20:00",
      "totalTime": "4h",
      "price": "270"
    },
    {
      "image": "shaheen.jpg",
      "flightName": "Shaheen Air",
      "from": "Lahore",
      "departureTime": "17:00",
      "arrival": "Islamabad",
      "arrivalTime": "20:00",
      "totalTime": "4h",
      "price": "200"
    },
    {
      "image": "pia.png",
      "flightName": "PIA",
      "from": "Lahore",
      "departureTime": "17:00",
      "arrival": "Islamabad",
      "arrivalTime": "20:00",
      "totalTime": "4h",
      "price": "300"
    },
    {
      "image": "pia.png",
      "flightName": "PIA",
      "departureTime": "17:00",
      "arrivalTime": "20:00",
      "from": "Lahore",
      "arrival": "Islamabad",
      "totalTime": "4h",
      "price": "670"
    },
  ];

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    MyMediaQuery query = MyMediaQuery(context);
    height = query.height!;
    width = query.width!;
    Orientation? orientation = query.orientation;
    return Scaffold(
      body: Column(
        children: [
          SlideTransition(
            position: Tween(begin: Offset(0, -1), end: Offset.zero).animate(_controller),
            child: Container(
                height: height * 0.3,
                child: Stack(children: [
                  Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/" + "${widget.distination!.image}"), fit: BoxFit.cover))),
                  Container(color: blackColor.withOpacity(0.5)),
                  Center(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    MyText(text: "${widget.distination!.location}", color: whiteColor, fontSize: 45.0),
                    MyText(text: "FROM ${widget.distination!.from}", color: whiteColor, height: 1.5)
                  ])),
                  SafeArea(
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.clear, color: whiteColor)))
                ])),
          ),
          Expanded(
            child: AnimatedList(
                initialItemCount: airLineRates.length,
                itemBuilder: (context, index, animation) {
                  return SlideTransition(
                    position: (Tween(begin: Offset(0, 6), end: Offset(0, 0))).animate(_controller),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: transparentColor,
                            transitionAnimationController:
                                AnimationController(vsync: this, duration: Duration(seconds: 1)),
                            builder: (context) => myBottomSheet(airLineRates[index]));
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          color: index % 2 != 0 ? blueGrey.withOpacity(0.1) : transparentColor,
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, border: Border.all(color: greyColor, width: 0.2)),
                              child: CircleAvatar(
                                  backgroundColor: transparentColor,
                                  backgroundImage: AssetImage("assets/" + airLineRates[index]["image"]),
                                  radius: 22),
                            ),
                            SizedBox(width: 15),
                            Flexible(
                                child: Container(
                                    height:
                                        orientation == Orientation.landscape ? height * 0.3 : height * 0.1 + 20,
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          MyText(text: "${airLineRates[index]["flightName"]}", fontSize: 15),
                                          Container(
                                              width: width - width * 0.3 - 10,
                                              child: Row(children: [
                                                MyText(text: "${airLineRates[index]["from"]}", color: greyColor),
                                                Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                                    child: Image(
                                                        image: AssetImage("assets/arrow.png"), width: width / 4)),
                                                MyText(text: "${airLineRates[index]["arrival"]}", color: greyColor)
                                              ])),
                                          SizedBox(height: height * 0.02),
                                          MyText(text: "\$${airLineRates[index]["price"]}", fontSize: 18.0),
                                        ])))
                          ])),
                    ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset.zero).animate(_controller),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.tune),
          backgroundColor: appPrimaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  get initialIndex => null;
  myBottomSheet(Map flightDetail) {
    const List selectClass = [
      {
        "selectClass": "Economy",
        "classDetails": "One bagg allowed. You will be served one meal. Galaxy Note 7 not allowed on the board."
      },
      {"selectClass": "Business", "classDetails": "One bagg allowed. Galaxy Note 7 not allowed on the board."},
    ];
    int selected = 0;
    return StatefulBuilder(builder: (BuildContext context, StateSetter mySetState) {
      return DefaultTabController(
          length: 4,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: height * 0.6,
                child: TabBarView(children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 7.0),
                      color: whiteColor,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
                            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, border: Border.all(width: 1, color: greyColor)),
                                  child: CircleAvatar(
                                      backgroundColor: transparentColor,
                                      backgroundImage: AssetImage("assets/" + flightDetail["image"]))),
                              SizedBox(width: 13),
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                    MyText(text: "${flightDetail["flightName"]}", fontSize: 15),
                                    Table(
                                        defaultColumnWidth: IntrinsicColumnWidth(),
                                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                        children: [
                                          TableRow(children: [
                                            MyText(text: "${flightDetail["from"]}", color: greyColor),
                                            Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Image.asset("assets/arrow.png")),
                                            MyText(text: "${flightDetail["arrival"]}", color: greyColor)
                                          ]),
                                          TableRow(children: [
                                            MyText(text: "${flightDetail["departureTime"]}", color: greyColor),
                                            Center(
                                                child: MyText(
                                                    text: "${flightDetail["totalTime"]}", color: greyColor)),
                                            MyText(text: "${flightDetail["arrivalTime"]}", color: greyColor)
                                          ])
                                        ]),
                                    SizedBox(height: height * 0.02),
                                    MyText(text: "\$${flightDetail["price"]}", fontSize: 18.0),
                                  ]))
                            ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                            child: MyText(text: "Select Class", color: greyColor)),
                        Column(
                            children: List.generate(selectClass.length, (index) {
                          return mySelectClass(() {
                            mySetState(() {
                              selected = index;
                            });
                          }, "${selectClass[index]["selectClass"]}", "${selectClass[index]["classDetails"]}",
                              index, selected);
                        })),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 13),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              color: appPrimaryColor,
                              child: Center(
                                child: MyText(
                                  text: "Book",
                                  color: whiteColor,
                                  fontSize: 18,
                                ),
                              )),
                        )
                      ])),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 7.0),
                      color: whiteColor,
                      child: Center(child: Text("data"))),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 7.0),
                      color: whiteColor,
                      child: Center(child: Text("data"))),
                  Container(
                      height: height,
                      margin: EdgeInsets.symmetric(horizontal: 7.0),
                      color: whiteColor,
                      child: Center(child: Text("data")))
                ])),
            TabBar(isScrollable: true, indicatorWeight: 0.1, unselectedLabelColor: greyColor, tabs: [
              Icon(Icons.fiber_manual_record, size: 11),
              Icon(Icons.fiber_manual_record, size: 11),
              Icon(Icons.fiber_manual_record, size: 11),
              Icon(Icons.fiber_manual_record, size: 11)
            ]),
            SizedBox(height: 20)
          ]));
    });
  }

  GestureDetector mySelectClass(
      VoidCallback onTap, String nameClass, String classDetails, int index, int selected) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: width,
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(color: selected == index ? appPrimaryColor : transparentColor, width: 2),
                  top: BorderSide(color: appPrimaryColor.withOpacity(0.1), width: 0.2),
                  bottom: BorderSide(color: appPrimaryColor.withOpacity(0.1), width: 0.2)),
              color: selected == index ? blueGrey.withOpacity(0.1) : transparentColor),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            MyText(text: nameClass, fontSize: 16.0),
            if (selected == index) SizedBox(height: 20),
            if (selected == index) MyText(text: classDetails),
          ])),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MyArrowClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();
    path.lineTo(0, height);
    path.lineTo(width, height / 2);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
