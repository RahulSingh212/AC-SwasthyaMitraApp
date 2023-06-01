import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/constants.dart';

class AllDoctor extends StatelessWidget {
  String name;
  String branch;
  String time;
  String date;
  String ImageUrl;
  bool isTest;
  double? width;

  AllDoctor(
      {Key? key,
      required this.name,
      required this.branch,
      required this.date,
      required this.time,
      required this.ImageUrl,
      this.isTest = false,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) - _padding.top;
    return Container(
      height: 100,
      width: width == null ? MediaQuery.of(context).size.width : width,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(ImageUrl),
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width == null
                        ? MediaQuery.of(context).size.width / 2.4
                        : width! / 2.4,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 3, bottom: 3),
                          decoration: BoxDecoration(
                              color: AppColors.AppmainColor,
                              borderRadius: BorderRadius.circular(6)),
                          child: Center(
                              child: Container(
                                  child: Text(
                            date,
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ))),
                        ),
                        isTest == true
                            ? Container(
                                margin: EdgeInsets.only(left: 3),
                                padding: EdgeInsets.only(
                                    left: 3, right: 3, top: 3, bottom: 3),
                                decoration: BoxDecoration(
                                    color: Color(0xffFDB600),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Center(
                                    child: Text(
                                  "Test",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                )),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Container(
                      child: Image.asset("assets/images/Calendar.png",width: 28,height: 28,),),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 1,
              ),
              Text(
                branch,
                style: TextStyle(
                    color: Color(0xff727272), fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Text(
                    time,
                    style: TextStyle(
                        color: AppColors.AppmainColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  SizedBox(
                    width: width == null ? 35 : 7,
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 3, right: 3, top: 1, bottom: 1),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xffCDCDCD), width: 1.26),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Reschedule",
                      style: TextStyle(color: Color(0xffB0B0B0)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
