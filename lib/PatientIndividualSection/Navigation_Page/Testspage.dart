// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../Helper/constants.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) - _padding.top;
    return Container(
      color: AppColors.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Positioned(
                child: Container(
                  height: _height * 0.25,
                  color: const Color(0xff42CCC3),
                ),
              ),
              Positioned(
                top: 0.03836 * _height,
                width: _width,
                child: Container(
                  padding: EdgeInsets.only(
                      left: 0.05555 * _width, right: 0.05555 * _width),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 0.08055 * _width / 2,
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColors.AppmainColor,
                        ),
                      ),
                      const Icon(
                        Icons.library_add_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  left: 0.0694444*_width,
                  bottom: 0.021739*_height,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.011111*_width, color: Colors.white),
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: const CircleAvatar(
                          foregroundImage: AssetImage("assets/images/Doctor.jpg"),
                          radius: 40,
                        ),
                      ),
                      SizedBox(
                        width: 0.027777*_width,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultTextStyle(
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              child: Text(
                                "Dr. Ram Singh",
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 5, top: 5, bottom: 5, right: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                    child: DefaultTextStyle(
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.AppmainColor),
                                        child: Text(
                                          "Diabetologist",
                                        ))),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              DefaultTextStyle(
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    "4.2/5 Rating",
                                  )),
                            ],
                          )
                        ],
                      ),
                    ],
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 24, top: 15, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff2C2C2C),
                        fontWeight: FontWeight.bold),
                    child: Text(
                      "Date of Consultation",
                    )),
                SizedBox(
                  height: 5,
                ),
                DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff727272),
                        fontWeight: FontWeight.w500),
                    child: Text(
                      "28th July 2021",
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 15, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff2C2C2C),
                        fontWeight: FontWeight.bold),
                    child: Text(
                      "Time: ",
                    )),
                SizedBox(
                  height: 5,
                ),
                DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff727272),
                        fontWeight: FontWeight.w500),
                    child: Text(
                      "05:00 PM",
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 15, right: 20),
            child: DefaultTextStyle(
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff727272),
                    fontWeight: FontWeight.w500),
                child: Text(
                  "Bill Details:",
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff727272),
                        fontWeight: FontWeight.w400),
                    child: Text(
                      "Consultaion Fee",
                    )),
                DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff727272),
                        fontWeight: FontWeight.w400),
                    child: Text(
                      "₹ 600.00",
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              color: Color(0xffD4D4D4),
              thickness: 2,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 5, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff2c2c2c),
                        fontWeight: FontWeight.w500),
                    child: Text(
                      "Amount Paid",
                    )),
                DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff2c2c2c),
                        fontWeight: FontWeight.w500),
                    child: Text(
                      "₹ 600.00",
                    )),
              ],
            ),
          ),
          Expanded(child: Container()),
          Container(
            padding: EdgeInsets.all(11),
            margin: EdgeInsets.only(
                left: 16.67 / 100 * (MediaQuery.of(context).size.width),
                bottom: 35,
                right: 16.67 / 100 * (MediaQuery.of(context).size.width)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: AppColors.AppmainColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.file_present_outlined,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 1,
                ),
                DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w500),
                    child: Text(
                      "View Prescription",
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
