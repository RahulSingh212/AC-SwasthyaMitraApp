// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names, unnecessary_import, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, avoid_unnecessary_containers, sort_child_properties_last, unused_import, duplicate_import, unused_local_variable, must_be_immutable

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WellNess extends StatefulWidget {
  const WellNess({Key? key}) : super(key: key);

  @override
  State<WellNess> createState() => _WellNessState();
}

class ChartData {
  String x = "";
  double? y;

  ChartData(this.x, this.y);
}

class ChartData2 {
  String x = "";
  double? y;
  Color z = Colors.white;

  ChartData2(this.x, this.y, this.z);
}

class _WellNessState extends State<WellNess> {
  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: Container(
        padding: EdgeInsets.fromLTRB(
            0.05555 * _width, 0.040760 * 2 * _height, 0.05555 * _width, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Wellness",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        fontStyle: FontStyle.normal,
                        color: Color(0xff2c2c2c),
                        // height: ,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 0.0135869 * _height,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "A state of physical, mental and social well-being in\nwhich disease and infirmity are absent",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    color: Color(0xff929292),
                    // height: ,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 0.0135869 * _height,
            ),
            SizedBox(
              height: 0.7826086956 * _height,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  //**Blood Pressure
                  Container(
                      // height: 0.1236413 * _height,

                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border.all(
                          width: 1,
                          color: Color(0xffffffff),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: 0.055555 * _width,
                                top: 0.0071739130434783 * _height),
                            width: 0.7988888 * _width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Blood Pressure",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xff2c2c2c),
                                        // height: ,
                                      ),
                                    ),
                                    Container(
                                      width: 0.3777777 * _width,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "123",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20,
                                                    fontStyle: FontStyle.normal,
                                                    color: Color(0xff42cdc3),
                                                    // height: ,
                                                  ),
                                                ),
                                                SizedBox(width: 2),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    Text(
                                                      "SYS",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color:
                                                            Color(0xff42cdc3),
                                                        // height: ,
                                                      ),
                                                    ),
                                                    Text(
                                                      "mmHg",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color:
                                                            Color(0xffb8b8ba),
                                                        // height: ,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "73",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20,
                                                    fontStyle: FontStyle.normal,
                                                    color: Color(0xff5662f6),
                                                    // height: ,
                                                  ),
                                                ),
                                                SizedBox(width: 2),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    Text(
                                                      "DIA",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color:
                                                            Color(0xff5662f6),
                                                        // height: ,
                                                      ),
                                                    ),
                                                    Text(
                                                      "mmHg",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color:
                                                            Color(0xffb8b8ba),
                                                        // height: ,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 65,
                                  width: 150,
                                  child: SfCartesianChart(
                                      // Initialize category axis
                                      primaryXAxis: CategoryAxis(
                                        isVisible: false,
                                        minorGridLines: const MinorGridLines(
                                            width: 1,
                                            color: Color(0xffb8b8ba),
                                            dashArray: <double>[2, 2]),
                                        majorGridLines: const MajorGridLines(
                                          width: 1,
                                          color: Color(0xffb8b8ba),
                                          dashArray: <double>[2, 2],
                                        ),
                                      ),
                                      primaryYAxis: CategoryAxis(
                                        isVisible: true,
                                        minorGridLines: const MinorGridLines(
                                            width: 1,
                                            color: Color(0xffb8b8ba),
                                            dashArray: <double>[2, 2]),
                                        majorGridLines: const MajorGridLines(
                                          width: 1,
                                          color: Color(0xffb8b8ba),
                                          dashArray: <double>[2, 2],
                                        ),
                                      ),
                                      series: <ChartSeries>[
                                        // Initialize line series
                                        LineSeries<ChartData, String>(
                                          dataSource: [
                                            // Bind data source
                                            ChartData('Jan', 35),
                                            ChartData('Feb', 28),
                                            ChartData('Mar', 34),
                                            ChartData('Apr', 32),
                                            ChartData('May', 40),
                                            // ChartData('Jun', 28),
                                            // ChartData('Jul', 34),
                                            // ChartData('Aug', 32),
                                            // ChartData('Sep', 40)
                                          ],
                                          xValueMapper: (ChartData data, _) =>
                                              data.x,
                                          yValueMapper: (ChartData data, _) =>
                                              data.y,
                                          markerSettings: const MarkerSettings(
                                              isVisible: true),
                                          color: Color(0xff5662f6),
                                        ),
                                        LineSeries<ChartData, String>(
                                          dataSource: [
                                            // Bind data source
                                            ChartData('Jan', 25),
                                            ChartData('Feb', 48),
                                            ChartData('Mar', 04),
                                            ChartData('Apr', 50),
                                            ChartData('May', 100),
                                            // ChartData('Jun', 28),
                                            // ChartData('Jul', 34),
                                            // ChartData('Aug', 32),
                                            // ChartData('Sep', 40)
                                          ],
                                          xValueMapper: (ChartData data, _) =>
                                              data.x,
                                          yValueMapper: (ChartData data, _) =>
                                              data.y,
                                          markerSettings: const MarkerSettings(
                                              isVisible: true),
                                          color: Color(0xff42cdc3),
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                  //**Blood Pressure

                  //**Steps & Distance Travelled
                  // Steps_Distance(width: _width, height: _height),
                  //**Steps & Distance Travelled

                  //**Blood Sugar Levels
                  Blood_Sugar(width: _width, height: _height),
                  //**Blood Sugar Levels

                  //**Oxygen Level
                  Oxygen(width: _width, height: _height),
                  //**Oxygen Level

                  //**Calorie Intake
                  Calorie(width: _width, height: _height),
                  //**Calorie Intake

                  //**BMI
                  //Image needs to be fixed
                  BMI(width: _width, height: _height),
                  //**BMI

                  //**Haemoglobin
                  Haemoglobin(width: _width, height: _height),
                  //**Haemoglobin

                  //**Body Temperature
                  Body_Temperature(width: _width, height: _height),
                  //**Body Temperature
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BMI extends StatelessWidget {
  const BMI({
    Key? key,
    required double width,
    required double height,
  })  : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 0.1236413 * _height,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          border: Border.all(
            width: 1,
            color: const Color(0xffffffff),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.only(
            left: 0.035555 * _width,
            right: 0.035555 * _width,
            top: 0.0071739130434783 * _height),
        width: 0.7988888 * _width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //BMI
                SizedBox(
                    width: 140,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "BMI",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff4c465a),
                                // height: ,
                              ),
                            ),
                            Image(image: AssetImage("assets/images/BMI.png"))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "19.8 ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 32,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff2c2c2c),
                                // height: ,
                              ),
                            ),
                            Text(
                              "kg/m²",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                color: Color(0xFF757575),
                                // height: ,
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                const SizedBox(
                  width: 10,
                ),
                //BLOOD
                SizedBox(
                    width: 140,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "BLOOD",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff4c465a),
                                // height: ,
                              ),
                            ),
                            Image(image: AssetImage("assets/images/Blood.png"))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "AB ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 32,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff2c2c2c),
                                // height: ,
                              ),
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //HEIGHT
                SizedBox(
                    width: 140,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "HEIGHT",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff4c465a),
                                // height: ,
                              ),
                            ),
                            Image(image: AssetImage("assets/images/Height.png"))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "180 ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 32,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff2c2c2c),
                                // height: ,
                              ),
                            ),
                            Text(
                              "cm",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                color: Color(0xFF757575),
                                // height: ,
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                const SizedBox(
                  width: 10,
                ),
                //WEIGHT
                SizedBox(
                    width: 140,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "WEIGHT",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff4c465a),
                                // height: ,
                              ),
                            ),
                            Image(image: AssetImage("assets/images/Weight.png"))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "64 ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 32,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff2c2c2c),
                                // height: ,
                              ),
                            ),
                            Text(
                              "kg",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                color: Color(0xFF757575),
                                // height: ,
                              ),
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ],
        ));
  }
}

class Body_Temperature extends StatelessWidget {
  const Body_Temperature({
    Key? key,
    required double width,
    required double height,
  })  : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 0.1236413 * _height,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          border: Border.all(
            width: 1,
            color: const Color(0xffffffff),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.only(
            left: 0.035555 * _width,
            right: 0.035555 * _width,
            top: 0.0071739130434783 * _height),
        width: 0.7988888 * _width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(right: 0.035555 * _width),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Body Temperature",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: Color(0xff2c2c2c),
                      // height: ,
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          "Last\nUpdated",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF757575),
                            // height: ,
                          ),
                        ),
                        Text(
                          "Today",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF2C2C2C),
                            // height: ,
                          ),
                        ),
                      ]),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 0.888888889 * _width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "98.6 °F",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF5662F6),
                          // height: ,
                        ),
                      ),
                      Text(
                        "Today",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF5662F6),
                          // height: ,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                    width: 240,
                    child: SfCartesianChart(
                        // Initialize category axis
                        primaryXAxis: CategoryAxis(
                          isVisible: true,
                          labelStyle: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            color: Color(0xffb8b8ba),
                            // height: ,
                          ),
                        ),
                        primaryYAxis: CategoryAxis(
                          isVisible: true,
                          minorGridLines: const MinorGridLines(
                              width: 1,
                              color: Color(0xffb8b8ba),
                              dashArray: <double>[2, 2]),
                          majorGridLines: const MajorGridLines(
                            width: 1,
                            color: Color(0xffb8b8ba),
                            dashArray: <double>[2, 2],
                          ),
                          labelStyle: const TextStyle(
                            fontSize: 0,
                          ),
                        ),
                        series: <ChartSeries>[
                          // Initialize line series
                          ColumnSeries<ChartData, String>(
                            dataSource: [
                              // Bind data source
                              ChartData("Wed", 35),
                              ChartData("Thu", 23),
                              ChartData("Fri", 34),
                              ChartData("Sat", 25),
                              ChartData("Sun", 40),
                              ChartData("Mon", 45),
                              ChartData("Tue", 30),
                            ],
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            borderRadius: BorderRadius.circular(3),
                            color: const Color(0xFF5662F6),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class Haemoglobin extends StatelessWidget {
  const Haemoglobin({
    Key? key,
    required double width,
    required double height,
  })  : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 0.1236413 * _height,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          border: Border.all(
            width: 1,
            color: const Color(0xffffffff),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.only(
            left: 0.035555 * _width,
            right: 0.035555 * _width,
            top: 0.0071739130434783 * _height),
        width: 0.7988888 * _width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(right: 0.035555 * _width),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Haemoglobin",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: Color(0xff2c2c2c),
                      // height: ,
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          "Last\nUpdated",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF757575),
                            // height: ,
                          ),
                        ),
                        Text(
                          "Today",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF2C2C2C),
                            // height: ,
                          ),
                        ),
                      ]),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              width: 0.888888889 * _width,
              child: SfCartesianChart(
                  // Initialize category axis
                  primaryXAxis: CategoryAxis(
                    isVisible: false,
                    minorGridLines: const MinorGridLines(
                        width: 1,
                        color: Color(0xffb8b8ba),
                        dashArray: <double>[2, 2]),
                    majorGridLines: const MajorGridLines(
                      width: 1,
                      color: Color(0xffb8b8ba),
                      dashArray: <double>[2, 2],
                    ),
                  ),
                  primaryYAxis: CategoryAxis(
                    isVisible: true,
                    minorGridLines: const MinorGridLines(
                        width: 1,
                        color: Color(0xffb8b8ba),
                        dashArray: <double>[2, 2]),
                    majorGridLines: const MajorGridLines(
                      width: 1,
                      color: Color(0xffb8b8ba),
                      dashArray: <double>[2, 2],
                    ),
                    maximumLabels: 2,
                    minimum: 20,
                  ),
                  series: <ChartSeries>[
                    // Initialize line series
                    LineSeries<ChartData, String>(
                      dataSource: [
                        // Bind data source
                        ChartData('Jan', 35),
                        ChartData('Feb', 28),
                        ChartData('Mar', 34),
                        ChartData('Apr', 32),
                        ChartData('May', 40),
                      ],
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      markerSettings: const MarkerSettings(isVisible: true),
                      color: const Color(0xff42cdc3),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}

class Calorie extends StatelessWidget {
  const Calorie({
    Key? key,
    required double width,
    required double height,
  })  : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 0.1236413 * _height,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          border: Border.all(
            width: 1,
            color: Color(0xffffffff),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.only(
            left: 0.035555 * _width,
            right: 0.035555 * _width,
            top: 0.0071739130434783 * _height),
        width: 0.7988888 * _width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Calorie Intake",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 20,
                fontStyle: FontStyle.normal,
                color: Color(0xff2c2c2c),
                // height: ,
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "2400",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xff5662f6),
                                  // height: ,
                                ),
                              ),
                              Text(
                                " Cal",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xff5662f6),
                                  // height: ,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          "Today",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            color: Color(0xff5662f6),
                            // height: ,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 220,
                    child: SfCartesianChart(
                        // Initialize category axis
                        primaryXAxis: CategoryAxis(
                          isVisible: true,
                          labelStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            color: Color(0xffb8b8ba),
                            // height: ,
                          ),
                        ),
                        primaryYAxis: CategoryAxis(
                          isVisible: true,
                          minorGridLines: const MinorGridLines(
                              width: 1,
                              color: Color(0xffb8b8ba),
                              dashArray: <double>[2, 2]),
                          majorGridLines: const MajorGridLines(
                            width: 1,
                            color: Color(0xffb8b8ba),
                            dashArray: <double>[2, 2],
                          ),
                          labelStyle: TextStyle(
                            fontSize: 0,
                          ),
                        ),
                        series: <ChartSeries>[
                          // Initialize line series
                          ColumnSeries<ChartData, String>(
                            dataSource: [
                              // Bind data source
                              ChartData("Wed", 35),
                              ChartData("Thu", 23),
                              ChartData("Fri", 34),
                              ChartData("Sat", 25),
                              ChartData("Sun", 40),
                              ChartData("Mon", 45),
                              ChartData("Tue", 30),
                            ],
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            borderRadius: BorderRadius.circular(3),
                            color: Color(0xff5662f6),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            const Text(
              "The recommended daily calorie intake is 2,000 calories a day for women and 2,500 for men",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                fontStyle: FontStyle.normal,
                color: Color(0xFF757575),
                // height: ,
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ));
  }
}

class Oxygen extends StatelessWidget {
  const Oxygen({
    Key? key,
    required double width,
    required double height,
  })  : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 0.1236413 * _height,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          border: Border.all(
            width: 1,
            color: Color(0xffffffff),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.only(
          left: 0.035555 * _width,
          right: 0.035555 * _width,
          top: 0.007 * _height,
        ),
        width: 0.7988888 * _width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(right: 0.035555 * _width),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Oxygen Level",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff2c2c2c),
                          // height: ,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "Oxygen Level State: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              color: Color(0xFF757575),
                              // height: ,
                            ),
                          ),
                          Text(
                            "Normal",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              color: Color(0xff29c44d),
                              // height: ,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 100,
                        width: 177,
                        child: SfCartesianChart(
                            // Initialize category axis
                            primaryXAxis: CategoryAxis(
                              isVisible: false,
                              minorGridLines: const MinorGridLines(
                                  width: 1,
                                  color: Color(0xffb8b8ba),
                                  dashArray: <double>[2, 2]),
                              majorGridLines: const MajorGridLines(
                                width: 1,
                                color: Color(0xffb8b8ba),
                                dashArray: <double>[2, 2],
                              ),
                              maximumLabels: 3,
                            ),
                            primaryYAxis: CategoryAxis(
                                isVisible: true,
                                minorGridLines: const MinorGridLines(
                                    width: 1,
                                    color: Color(0xffb8b8ba),
                                    dashArray: <double>[2, 2]),
                                majorGridLines: const MajorGridLines(
                                  width: 1,
                                  color: Color(0xffb8b8ba),
                                  dashArray: <double>[2, 2],
                                ),
                                maximum: 100,
                                maximumLabels: 3,
                                minimum: 80),
                            series: <ChartSeries>[
                              // Initialize line series
                              SplineAreaSeries<ChartData, String>(
                                dataSource: [
                                  // Bind data source
                                  ChartData('Jan', 88),
                                  ChartData('Feb', 92),
                                  ChartData('Mar', 98),
                                  ChartData('Apr', 85),
                                  ChartData('May', 90),
                                ],
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                color: Color(0xffb2b7fb),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: SfCircularChart(
                          annotations: <CircularChartAnnotation>[
                            CircularChartAnnotation(
                                widget: Container(
                                    child: PhysicalModel(
                                        child: Container(),
                                        shape: BoxShape.circle,
                                        elevation: 10,
                                        shadowColor: Colors.black,
                                        color: Colors.white))),
                            CircularChartAnnotation(
                              widget: Container(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '98',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 30,
                                      fontStyle: FontStyle.normal,
                                      color: Color(0xff5662f6),
                                    ),
                                  ),
                                  Text(
                                    '%SpO2',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 8,
                                      fontStyle: FontStyle.normal,
                                      color: Color(0xFF757575),
                                    ),
                                  ),
                                ],
                              )),
                            ),
                          ],
                          series: <CircularSeries>[
                            DoughnutSeries<ChartData2, String>(
                                dataSource: [
                                  ChartData2('David', 98, Color(0xff5662f6)),
                                  ChartData2('Others', 2, Colors.transparent),
                                ],
                                xValueMapper: (ChartData2 data, _) => data.x,
                                yValueMapper: (ChartData2 data, _) => data.y,
                                pointColorMapper: (ChartData2 data, _) =>
                                    data.z,
                                // Radius of doughnut
                                radius: '130%',
                                innerRadius: '115%')
                          ])),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}

class Blood_Sugar extends StatelessWidget {
  const Blood_Sugar({
    Key? key,
    required double width,
    required double height,
  })  : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 0.1236413 * _height,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          border: Border.all(
            width: 1,
            color: Color(0xffffffff),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.only(
            left: 0.035555 * _width,
            right: 0.035555 * _width,
            top: 0.0071739130434783 * _height),
        width: 0.7988888 * _width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(right: 0.035555 * _width),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Blood Sugar Levels",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff2c2c2c),
                          // height: ,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "Blood Sugar State: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              color: Color(0xFF757575),
                              // height: ,
                            ),
                          ),
                          Text(
                            "Normal",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              color: Color(0xff29c44d),
                              // height: ,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Last\nUpdated",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF757575),
                          // height: ,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Today",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF2C2C2C),
                          // height: ,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            //**Fasting
            Container(
              width: 0.888888889 * _width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Fasting\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff2c2c2c),
                          // height: ,
                        ),
                      ),
                      Text(
                        "Last Updated",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 8,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF757575),
                          // height: ,
                        ),
                      ),
                      Text(
                        "11:14 AM",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff2c2c2c),
                          // height: ,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 90,
                    width: 180,
                    child: SfCartesianChart(
                        // Initialize category axis
                        primaryXAxis: CategoryAxis(
                          isVisible: true,
                          labelStyle: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            color: Color(0xffb8b8ba),
                            // height: ,
                          ),
                        ),
                        primaryYAxis: CategoryAxis(
                          isVisible: true,
                          minorGridLines: const MinorGridLines(
                              width: 1,
                              color: Color(0xffb8b8ba),
                              dashArray: <double>[2, 2]),
                          majorGridLines: const MajorGridLines(
                            width: 1,
                            color: Color(0xffb8b8ba),
                            dashArray: <double>[2, 2],
                          ),
                          labelStyle: TextStyle(
                            fontSize: 0,
                          ),
                        ),
                        series: <ChartSeries>[
                          // Initialize line series
                          ColumnSeries<ChartData, String>(
                            dataSource: [
                              // Bind data source
                              ChartData("Wed", 35),
                              ChartData("Thu", 23),
                              ChartData("Fri", 34),
                              ChartData("Sat", 25),
                              ChartData("Sun", 40),
                              ChartData("Mon", 45),
                              ChartData("Tue", 30),
                            ],
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            borderRadius: BorderRadius.circular(3),
                            color: Color(0xff42cdc3),
                          ),
                        ]),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "106",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF5662F6),
                          // height: ,
                        ),
                      ),
                      Text(
                        "mg/dl",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF5662F6),
                          // height: ,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffececec),
                  width: 1,
                ),
              ),
            ),
            //**Fasting

            const SizedBox(
              height: 10,
            ),

            //**Random
            Container(
              width: 0.888888889 * _width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Random\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff2c2c2c),
                          // height: ,
                        ),
                      ),
                      Text(
                        "Last Updated",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 8,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF757575),
                          // height: ,
                        ),
                      ),
                      Text(
                        "11:20 AM",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff2c2c2c),
                          // height: ,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 90,
                    width: 180,
                    child: SfCartesianChart(
                        // Initialize category axis
                        primaryXAxis: CategoryAxis(
                          isVisible: true,
                          labelStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            color: Color(0xffb8b8ba),
                            // height: ,
                          ),
                        ),
                        primaryYAxis: CategoryAxis(
                          isVisible: true,
                          minorGridLines: const MinorGridLines(
                              width: 1,
                              color: Color(0xffb8b8ba),
                              dashArray: <double>[2, 2]),
                          majorGridLines: const MajorGridLines(
                            width: 1,
                            color: Color(0xffb8b8ba),
                            dashArray: <double>[2, 2],
                          ),
                          labelStyle: TextStyle(
                            fontSize: 0,
                          ),
                        ),
                        series: <ChartSeries>[
                          // Initialize line series
                          ColumnSeries<ChartData, String>(
                            dataSource: [
                              // Bind data source
                              ChartData("Wed", 35),
                              ChartData("Thu", 23),
                              ChartData("Fri", 34),
                              ChartData("Sat", 25),
                              ChartData("Sun", 40),
                              ChartData("Mon", 45),
                              ChartData("Tue", 30),
                            ],
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            borderRadius: BorderRadius.circular(3),
                            color: Color(0xff42cdc3),
                          ),
                        ]),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "126",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF5662F6),
                          // height: ,
                        ),
                      ),
                      Text(
                        "mg/dl",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF5662F6),
                          // height: ,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffececec),
                  width: 1,
                ),
              ),
            ),
            //**Random

            const SizedBox(
              height: 10,
            ),

            //**Post Prandial
            Container(
              width: 0.888888889 * _width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Post Prandial\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff2c2c2c),
                          // height: ,
                        ),
                      ),
                      Text(
                        "Last Updated",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 8,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF757575),
                          // height: ,
                        ),
                      ),
                      Text(
                        "01:05 PM",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff2c2c2c),
                          // height: ,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 90,
                    width: 180,
                    child: SfCartesianChart(
                        // Initialize category axis
                        primaryXAxis: CategoryAxis(
                          isVisible: true,
                          labelStyle: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            color: Color(0xffb8b8ba),
                            // height: ,
                          ),
                        ),
                        primaryYAxis: CategoryAxis(
                          isVisible: true,
                          minorGridLines: const MinorGridLines(
                              width: 1,
                              color: Color(0xffb8b8ba),
                              dashArray: <double>[2, 2]),
                          majorGridLines: const MajorGridLines(
                            width: 1,
                            color: Color(0xffb8b8ba),
                            dashArray: <double>[2, 2],
                          ),
                          labelStyle: const TextStyle(
                            fontSize: 0,
                          ),
                        ),
                        series: <ChartSeries>[
                          // Initialize line series
                          ColumnSeries<ChartData, String>(
                            dataSource: [
                              // Bind data source
                              ChartData("Wed", 35),
                              ChartData("Thu", 23),
                              ChartData("Fri", 34),
                              ChartData("Sat", 25),
                              ChartData("Sun", 40),
                              ChartData("Mon", 45),
                              ChartData("Tue", 30),
                            ],
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            borderRadius: BorderRadius.circular(3),
                            color: Color(0xff42cdc3),
                            // Chartdata class need to be modified ( adding color element to make each bar
                            // of diiferent color
                            // pointColorMapper: (ChartData data, _) => data.color
                          ),
                        ]),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "120",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF5662F6),
                          // height: ,
                        ),
                      ),
                      Text(
                        "mg/dl",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF5662F6),
                          // height: ,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffececec),
                  width: 1,
                ),
              ),
            ),
            //**Post Prandial
          ],
        ));
  }
}
