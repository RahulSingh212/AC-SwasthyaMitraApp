// ignore_for_file: unnecessary_import, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Appointment/find_doctor.dart';
import '../Helper/constants.dart';
import './BookTest.dart';

class HomePage extends StatefulWidget {
  String name;
  HomePage({Key? key, required this.name}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String input = "";
  bool isTodayAnything = true;
  var _padding;
  double _width = 0;
  double _height = 0;

  int scrollindex = 1;
  List scroll = [];

  @override
  Widget build(BuildContext context) {
    _padding = MediaQuery.of(context).padding;
    _width = (MediaQuery.of(context).size.width);
    _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
    set_scroll_list();
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 0.033333 * _width),
        margin: EdgeInsets.fromLTRB(0.02777777 * _width, 0.012787 * _height,
            0.02777777 * _width, 0.012787 * _height),
        color: AppColors.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  iconSize: 0.083333 * _width,
                  icon: Icon(Icons.notifications_none),
                ),
                CircleAvatar(
                    foregroundImage: AssetImage("assets/images/Doctor.jpg")),
              ],
            ),

            SizedBox(
              height: 0.012787 * _height,
            ),
            Container(
              child: Row(
                children: [
                  Text(
                    "Hello, ",
                    style: TextStyle(
                      color: Color(0xff2C2C2C),
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "${widget.name} !",
                    style: TextStyle(
                      color: Color(0xff2C2C2C),
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 0.012787 * 2 * _height,
            ),

            //  Input TextField
            Container(
              child: Material(
                borderRadius: BorderRadius.circular(0.055555 * _width),
                elevation: 7,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      input = value;
                    });
                  },
                  showCursor: false,
                  decoration: InputDecoration(
                    hintText: "Search \"Swasthya Mitra\" Near You",
                    hintStyle: TextStyle(
                      color: Color(0xffC4CFEE),
                    ),
                    fillColor: const Color(0xffFFFFFF),
                    suffixIcon: Container(
                        margin: EdgeInsets.only(right: 0.01388 * _width),
                        decoration: BoxDecoration(
                            color: AppColors.AppmainColor,
                            borderRadius:
                                BorderRadius.circular(3 * 0.01388 * _width)),
                        child: Icon(
                          Icons.search,
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.01388 * _width * 4),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 0.012787 * 2 * _height,
            ),

            GestureDetector(
              onVerticalDragDown: (_) {
                setState(() {
                  scrollindex = (scrollindex + 1) % 3;
                });
              },
              child: Container(
                height: 0.17263 * _height,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0.01278 * _height,
                      left: 0,
                      child: scroll[(scrollindex + 2) % 3],
                    ),
                    Positioned(
                      top: 0.01278 * _height * 0.5,
                      left: 0,
                      child: scroll[(scrollindex + 1) % 3],
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: scroll[scrollindex],
                    ),
                    Positioned(
                        right: 0.06111 * _width,
                        top: 0.06393 * _height,
                        child: Container(
                          height: 0.03836 * _height,
                          child: Column(
                              children: List.generate(3, (index) {
                            return Container(
                              margin:
                                  EdgeInsets.only(bottom: 0.0076726 * _height),
                              height: 0.0041150 * _height,
                              width: 0.011111 * _width,
                              decoration: BoxDecoration(
                                color: index != scrollindex
                                    ? Colors.white
                                    : Colors.black,
                                borderRadius:
                                    BorderRadius.circular(0.05555 * _width),
                              ),
                            );
                          })),
                        )),
                  ],
                ),
              ),
            ),

            //  help
            SizedBox(
              height: 0.012787 * 2 * _height,
            ),
            Container(
              child: Text(
                "How can we help you?",
                style: TextStyle(
                    color: Color(0xff2C2C2C),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 0.012787 * 2 * _height,
            ),

            // three buttons
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Find_doctor(),
                        ),
                      );
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/Doctor_Icon.png",
                            width: 0.04166 * 2 * _width,
                            height: 0.04166 * 2 * _width,
                          ),
                          SizedBox(
                            height: 0.01023 * _height,
                          ),
                          Center(
                              child: Text(
                            "Find Doctors",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.AppmainColor,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookTest(),
                        ),
                      );
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Image.asset("assets/images/TestTube.png",
                              width: 0.04166 * 2 * _width,
                              height: 0.04166 * 2 * _width),
                          SizedBox(
                            height: 0.01023 * _height,
                          ),
                          Center(
                              child: Text(
                            "Book Tests",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.AppmainColor,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        0.02777777 * _width,
                        0.012787 * _height,
                        0.02777777 * _width,
                        0.012787 * _height),
                    child: Column(
                      children: [
                        Image.asset("assets/images/Heart-Outlined.png",
                            width: 0.04166 * 2 * _width,
                            height: 0.04166 * 2 * _width),
                        SizedBox(
                          height: 0.01023 * _height,
                        ),
                        Center(
                            child: Text(
                          "Wellness",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.AppmainColor,
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 0.012787 * 2 * _height,
            ),

            Row(
              mainAxisAlignment: isTodayAnything == true
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "For today",
                    style: TextStyle(
                        color: Color(0xff2C2C2C),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                isTodayAnything == true
                    ? Container(
                        padding: EdgeInsets.only(right: 0.0277777 * _width),
                        child: Text(
                          "View All",
                          style: TextStyle(
                              color: Color(0xff9B9B9B),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(),
              ],
            ),
            SizedBox(
              height: 0.012787 * 2 * _height,
            ),

            // isTodayAnything==true?
            isTodayAnything == true
                ? Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.watch_later_outlined,
                              size: 50,
                              color: AppColors.AppmainColor,
                            ),
                          ),
                          SizedBox(
                            width: 0.05555555 * _width,
                          ),
                          Column(
                            children: [
                              Text(
                                "Appointment",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 0.00767 * _height,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Dr. Ram Singh",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 0.016666 * _width,
                                  ),
                                  Text(
                                    "04:00 pm",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.navigate_next,
                              color: AppColors.AppmainColor,
                              size: 0.04166 * 2 * _width,
                            ),
                          ),
                          SizedBox(
                            width: 0.055555 * _width,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 0.025575 * _height,
                      ),
                      Row(
                        children: [
                          Container(
                              child: Image.asset("assets/images/Capsule.png")),
                          SizedBox(
                            width: 0.055555 * _width,
                          ),
                          Column(
                            children: [
                              Text(
                                "Ibuprofen",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 0.007672 * _height,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "After Eating",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 0.016666 * _width,
                                  ),
                                  Text(
                                    "03:00 pm",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.navigate_next,
                              color: AppColors.AppmainColor,
                              size: 0.04166 * 2 * _width,
                            ),
                          ),
                          SizedBox(
                            width: 0.055555 * _width,
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void set_scroll_list() {
    scroll = [
      Container(
        height: 0.153452 * _height,
        width: 0.89 * _width,
        decoration: BoxDecoration(
            color: Color(0xffC3EFED),
            borderRadius: BorderRadius.circular(0.04466 * _width)),
      ),
      Container(
        height: 0.153452 * _height,
        width: 0.89 * _width,
        decoration: BoxDecoration(
            color: AppColors.AppmainColor,
            borderRadius: BorderRadius.circular(0.04466 * _width)),
        child: Stack(
          children: [
            Positioned(
                left: 0.030555 * _width,
                top: 0,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/HomeImage.png"),
                )),
            Positioned(
              top: 0.038363 * _height,
              right: 0.08333 * _width,
              child: Column(
                children: [
                  Container(
                      width: 0.27222 * _width,
                      child: Text(
                        "Book Tests Online!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )),
                  SizedBox(
                    height: 0.015345 * _height,
                  ),
                  GestureDetector(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(
                            0.022222 * _width,
                            0.010230 * _height,
                            0.022222 * _width,
                            0.010230 * _height),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(0.022222 * _width)),
                        width: 0.27222 * _width,
                        child: Center(
                          child: Text(
                            "Know more",
                            style: TextStyle(
                                color: Color(0xff2c2c2c),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 0.153452 * _height,
        width: 0.89 * _width,
        decoration: BoxDecoration(
            color: Color(0xff8FE1DB),
            borderRadius: BorderRadius.circular(0.04466 * _width)),
      ),
    ];
  }
}
