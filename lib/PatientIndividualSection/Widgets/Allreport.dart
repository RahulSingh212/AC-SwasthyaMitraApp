// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_if_null_operators

import 'package:flutter/material.dart';

import '../Helper/constants.dart';

class Report extends StatelessWidget {
  double? width;
  String date;
  String report;
  String reportLink;
  String reporttype;
  Report(
      {Key? key,
      this.width,
      required this.report,
      required this.reportLink,
      required this.reporttype,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: width == null ? MediaQuery.of(context).size.width : width,
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 15,
        top: 15,
      ),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage("img/Doctor.jpg"),
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 3,
                          ),
                          padding: EdgeInsets.only(
                            left: 3,
                            right: 3,
                            top: 3,
                            bottom: 3,
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xffFDB600),
                              borderRadius: BorderRadius.circular(6)),
                          child: Center(
                              child: Text(
                            "Report",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Icon(
                      Icons.calendar_today_sharp,
                      size: 28,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    width: 1,
                    color: Color(0xffcdcdcd),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.text_snippet,
                      color: Colors.red,
                    ),
                    Text(
                      report,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    width: 1,
                    color: Color(0xffcdcdcd),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      reporttype,
                      style: TextStyle(
                          color: Color(0xff2c2c2c),
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    Icon(Icons.share),
                  ],
                ),
              ),
              SizedBox(
                height: 7,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
