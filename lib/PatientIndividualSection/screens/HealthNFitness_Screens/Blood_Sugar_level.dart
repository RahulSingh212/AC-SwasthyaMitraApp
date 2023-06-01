// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/blood_sugar_level.dart';
import '../../providers/paientHealthAndWellNess_details.dart';
import '../../providers/patientUser_details.dart';
import 'Date_Time.dart';

class Blood_Sugar extends StatefulWidget {
  Blood_Sugar({
    Key? key,
    required double width,
    required double height,
  })  : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;

  @override
  State<Blood_Sugar> createState() => _Blood_SugarState();
}

enum Bloodpressure_choice { Fasting, Random, Post_Prandial }

// class blood_sugar_lvl {
//   int? Fasting;
//   int? Random;
//   int? Post_Prandial;
//   DateTime? Date_time;
//   String? Status;
//   Color? color;

//   blood_sugar_lvl(
//       this.Fasting, this.Random, this.Post_Prandial, this.Date_time) {
//     if (Fasting! < 100 && Post_Prandial! < 140 && Random! < 200) {
//       Status = "Normal";
//       color = Color(0xff5662f6);
//     } else {
//       if ((Fasting! >= 100 && Fasting! < 126) &&
//           (Post_Prandial! < 200 && Post_Prandial! >= 140) &&
//           Random! < 200) {
//         Status = "Pre Diabetes";
//       } else {
//         Status = "Diabetes";
//       }
//       color = Color(0xff42ccc3);
//     }
//   }
// }

class _Blood_SugarState extends State<Blood_Sugar> {
  bool isLangEnglish = true;
  List<blood_sugar_lvl> BS_list = [];

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<PatientHealthAndWellNessDetails>(context, listen: false)
        .fetchPreviousBloodSugarLevelList(
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );
  }

  Bloodpressure_choice? _choice = Bloodpressure_choice.Fasting;

  DateTime temp_date_time = DateTime.now();
  DateTime Date_Time = DateTime.now();

  bool is_initial = true;
  bool is_newentry = true;
  TextEditingController _Fasting_Controller = TextEditingController();
  TextEditingController _Random_Controller = TextEditingController();
  TextEditingController _Post_Prandial_Controller = TextEditingController();
  TextEditingController _DayDate_Controller = TextEditingController();

  Blood_sugar_inital() {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          border: Border.all(
            width: 1,
            color: Color(0xffffffff),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.only(
          left: 0.015 * widget._width,
          right: 0.015 * widget._width,
          top: 0.015 * widget._height,
        ),
        width: 0.8 * widget._width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(right: 0.035555 * widget._width),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isLangEnglish
                            ? "Blood Sugar Levels"
                            : "रक्त शर्करा का स्तर",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 20 * (0.035 / 15) * widget._width,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff2c2c2c),
                          // height: ,
                        ),
                      ),
                      SizedBox(
                        height: 0.00679347826 * widget._height,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            isLangEnglish
                                ? "Blood Sugar State: "
                                : "रक्त शर्करा राज्य: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * (0.035 / 15) * widget._width,
                              fontStyle: FontStyle.normal,
                              color: Color(0xFF757575),
                              // height: ,
                            ),
                          ),
                          Text(
                            BS_list.isEmpty
                                ? "NA"
                                : BS_list.last.Status.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * (0.035 / 15) * widget._width,
                              fontStyle: FontStyle.normal,
                              color: BS_list.isEmpty
                                  ? Colors.black
                                  : (BS_list.last.Status == "Normal"
                                      ? Color(0xff29c44d)
                                      : Color(0xffff0000)),
                              // height: ,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        isLangEnglish ? "Last\nUpdated" : "आखरी\nअपडेट",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 12 * (0.035 / 15) * widget._width,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF757575),
                          // height: ,
                        ),
                      ),
                      SizedBox(
                        height: 0.00679347826 * widget._height,
                      ),
                      Text(
                        BS_list.isEmpty
                            ? "NA"
                            : date_time.check_today(
                                BS_list.last.Date_time,
                                DateTime.now(),
                              )
                                ? isLangEnglish
                                    ? "Today"
                                    : "आज"
                                : DateFormat('hh:mm a\nMMM dd')
                                    .format(BS_list.last.Date_time),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: BS_list.isEmpty
                              ? 20 * (0.035 / 15) * widget._width
                              : date_time.check_today(
                                  BS_list.last.Date_time,
                                  DateTime.now(),
                                )
                                  ? 20 * (0.035 / 15) * widget._width
                                  : 15 * (0.035 / 15) * widget._width,
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
            SizedBox(
              height: 15 * 0.00135869565 * widget._height,
            ),

            //**Fasting
            Text(
              isLangEnglish ? "Fasting\n" : "उपवास\n",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 18 * (0.035 / 15) * widget._width,
                fontStyle: FontStyle.normal,
                color: Color(0xff2c2c2c),
                // height: ,
              ),
            ),
            SizedBox(
              width: 0.888888889 * widget._width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        isLangEnglish ? "Last\nUpdated" : "आखरी\nअपडेट",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 12 * (0.035 / 15) * widget._width,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF757575),
                          // height: ,
                        ),
                      ),
                      Text(
                        BS_list.isEmpty
                            ? "NA"
                            : date_time.check_today(
                                    BS_list.last.Date_time, DateTime.now())
                                ? "Today"
                                : DateFormat('hh:mm a\nMMM dd')
                                    .format(BS_list.last.Date_time),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 12 * (0.035 / 15) * widget._width,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff2c2c2c),
                          // height: ,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.122282609 * widget._height,
                    width: 190 * 0.00277777778 * widget._width,
                    child: BS_list.isEmpty
                        ? SfCartesianChart()
                        : SfCartesianChart(
                            // Initialize category axis
                            primaryXAxis: CategoryAxis(
                              isVisible: true,
                              majorTickLines: MajorTickLines(
                                color: Colors.transparent,
                              ),
                              minorTickLines: MinorTickLines(
                                color: Colors.transparent,
                              ),
                              majorGridLines: MajorGridLines(
                                color: Colors.transparent,
                              ),
                              minorGridLines: MinorGridLines(
                                color: Colors.transparent,
                              ),
                              labelStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 12 * (0.035 / 15) * widget._width,
                                fontStyle: FontStyle.normal,
                                color: Color(0xffb8b8ba),
                                // height: ,
                              ),
                            ),
                            primaryYAxis: CategoryAxis(
                              isVisible: true,
                              majorTickLines: MajorTickLines(
                                color: Colors.transparent,
                              ),
                              minorTickLines: MinorTickLines(
                                color: Colors.transparent,
                              ),
                              majorGridLines: MajorGridLines(
                                color: Color(0xffb8b8ba),
                                // width: 1,
                                dashArray: <double>[5, 5],
                              ),
                              minorGridLines: MinorGridLines(
                                color: Colors.transparent,
                              ),
                              minorTicksPerInterval: 2,
                              labelStyle: TextStyle(
                                fontSize: 0,
                              ),
                              visibleMinimum: 95,
                              axisLine: AxisLine(
                                width: 0,
                              ),
                            ),
                            series: <ChartSeries>[
                              // Initialize line series
                              ColumnSeries<blood_sugar_lvl, String>(
                                dataSource: BS_list,
                                xValueMapper: (blood_sugar_lvl data, _) =>
                                    DateFormat('EE').format(data.Date_time),
                                yValueMapper: (blood_sugar_lvl data, _) =>
                                    data.Fasting,
                                pointColorMapper: (blood_sugar_lvl data, _) =>
                                    data.color,
                                borderRadius: BorderRadius.circular(3),
                                // color: Color(0xff42cdc3),
                              ),
                            ],
                          ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        BS_list.isEmpty
                            ? "NA"
                            : BS_list.last.Fasting.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 15 * (0.035 / 15) * widget._width,
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
                          fontSize: 13 * (0.035 / 15) * widget._width,
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

            SizedBox(
              height: 0.0015 * widget._height,
            ),

            //**Random
            Text(
              isLangEnglish ? "Random\n" : "यादृच्छिक\n",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 18 * (0.035 / 15) * widget._width,
                fontStyle: FontStyle.normal,
                color: Color(0xff2c2c2c),
                // height: ,
              ),
            ),
            SizedBox(
              width: 0.888888889 * widget._width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        isLangEnglish ? "Last\nUpdated" : "आखरी\nअपडेट",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 12 * (0.035 / 15) * widget._width,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF757575),
                          // height: ,
                        ),
                      ),
                      Text(
                        BS_list.isEmpty
                            ? "NA"
                            : date_time.check_today(
                                    BS_list.last.Date_time, DateTime.now())
                                ? isLangEnglish
                                    ? "Today"
                                    : "आज"
                                : DateFormat('hh:mm a\nMMM dd')
                                    .format(BS_list.last.Date_time),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 12 * (0.035 / 15) * widget._width,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff2c2c2c),
                          // height: ,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.122282609 * widget._height,
                    width: 190 * 0.00277777778 * widget._width,
                    child: BS_list.isEmpty
                        ? SfCartesianChart()
                        : SfCartesianChart(
                            // Initialize category axis
                            primaryXAxis: CategoryAxis(
                              isVisible: true,
                              majorTickLines: MajorTickLines(
                                color: Colors.transparent,
                              ),
                              minorTickLines: MinorTickLines(
                                color: Colors.transparent,
                              ),
                              majorGridLines: MajorGridLines(
                                color: Colors.transparent,
                              ),
                              minorGridLines: MinorGridLines(
                                color: Colors.transparent,
                              ),
                              labelStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 12 * (0.035 / 15) * widget._width,
                                fontStyle: FontStyle.normal,
                                color: Color(0xffb8b8ba),
                                // height: ,
                              ),
                            ),
                            primaryYAxis: CategoryAxis(
                              isVisible: true,
                              majorTickLines: MajorTickLines(
                                color: Colors.transparent,
                              ),
                              minorTickLines: MinorTickLines(
                                color: Colors.transparent,
                              ),
                              majorGridLines: MajorGridLines(
                                color: Color(0xffb8b8ba),
                                // width: 1,
                                dashArray: <double>[5, 5],
                              ),
                              minorGridLines: MinorGridLines(
                                color: Colors.transparent,
                              ),
                              minorTicksPerInterval: 2,
                              labelStyle: TextStyle(
                                fontSize: 0,
                              ),
                              visibleMinimum: 95,
                              axisLine: AxisLine(
                                width: 0,
                              ),
                            ),
                            series: <ChartSeries>[
                                // Initialize line series
                                ColumnSeries<blood_sugar_lvl, String>(
                                  dataSource: BS_list,
                                  xValueMapper: (blood_sugar_lvl data, _) =>
                                      DateFormat('EE').format(data.Date_time),
                                  yValueMapper: (blood_sugar_lvl data, _) =>
                                      data.Random,
                                  pointColorMapper: (blood_sugar_lvl data, _) =>
                                      data.color,
                                  borderRadius: BorderRadius.circular(3),
                                  // color: Color(0xff42cdc3),
                                ),
                              ]),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        BS_list.isEmpty ? "NA" : BS_list.last.Random.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 15 * (0.035 / 15) * widget._width,
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
                          fontSize: 13 * (0.035 / 15) * widget._width,
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

            SizedBox(
              height: 0.0015 * widget._height,
            ),

            //**Post Prandial
            Text(
              isLangEnglish ? "Post Prandial" : "प्रांडियल पोस्ट",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 18 * (0.035 / 15) * widget._width,
                fontStyle: FontStyle.normal,
                color: Color(0xff2c2c2c),
                // height: ,
              ),
            ),
            SizedBox(
              width: 0.888888889 * widget._width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        isLangEnglish ? "Last\nUpdated" : "आखरी\nअपडेट",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 12 * (0.035 / 15) * widget._width,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF757575),
                          // height: ,
                        ),
                      ),
                      Text(
                        BS_list.isEmpty
                            ? "NA"
                            : date_time.check_today(
                                    BS_list.last.Date_time, DateTime.now())
                                ? "Today"
                                : DateFormat('hh:mm a\nMMM dd')
                                    .format(BS_list.last.Date_time),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 12 * (0.035 / 15) * widget._width,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff2c2c2c),
                          // height: ,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.122282609 * widget._height,
                    width: 190 * 0.00277777778 * widget._width,
                    child: BS_list.isEmpty
                        ? SfCartesianChart()
                        : SfCartesianChart(
                            // Initialize category axis
                            primaryXAxis: CategoryAxis(
                              isVisible: true,
                              majorTickLines: MajorTickLines(
                                color: Colors.transparent,
                              ),
                              minorTickLines: MinorTickLines(
                                color: Colors.transparent,
                              ),
                              majorGridLines: MajorGridLines(
                                color: Colors.transparent,
                              ),
                              minorGridLines: MinorGridLines(
                                color: Colors.transparent,
                              ),
                              labelStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 12 * (0.035 / 15) * widget._width,
                                fontStyle: FontStyle.normal,
                                color: Color(0xffb8b8ba),
                                // height: ,
                              ),
                            ),
                            primaryYAxis: CategoryAxis(
                              isVisible: true,
                              majorTickLines: MajorTickLines(
                                color: Colors.transparent,
                              ),
                              minorTickLines: MinorTickLines(
                                color: Colors.transparent,
                              ),
                              majorGridLines: MajorGridLines(
                                color: Color(0xffb8b8ba),
                                // width: 1,
                                dashArray: <double>[5, 5],
                              ),
                              minorGridLines: MinorGridLines(
                                color: Colors.transparent,
                              ),
                              minorTicksPerInterval: 2,
                              labelStyle: TextStyle(
                                fontSize: 0,
                              ),
                              visibleMinimum: 95,
                              axisLine: AxisLine(
                                width: 0,
                              ),
                            ),
                            series: <ChartSeries>[
                              // Initialize line series
                              ColumnSeries<blood_sugar_lvl, String>(
                                dataSource: BS_list,
                                xValueMapper: (blood_sugar_lvl data, _) =>
                                    DateFormat('EE').format(data.Date_time),
                                yValueMapper: (blood_sugar_lvl data, _) =>
                                    data.Post_Prandial,
                                pointColorMapper: (blood_sugar_lvl data, _) =>
                                    data.color,
                                borderRadius: BorderRadius.circular(3),
                                // color: Color(0xff42cdc3),
                              ),
                            ],
                          ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        BS_list.isEmpty
                            ? "NA"
                            : BS_list.last.Post_Prandial.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 15 * (0.035 / 15) * widget._width,
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
                          fontSize: 13 * (0.035 / 15) * widget._width,
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

            // SizedBox(
            //   height: 10 * 0.00135869565 * widget._height,
            // ),
          ],
        ));
  }

  Blood_sugar_ontap() {
    return Container(
      // height: 0.1236413 * widget._height,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        border: Border.all(
          width: 1,
          color: Color(0xffffffff),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.only(
        left: 0.01 * widget._width,
        right: 0.01 * widget._width,
        top: 0.0125 * widget._height,
      ),
      width: 0.7988888 * widget._width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(right: 0.035555 * widget._width),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isLangEnglish
                          ? "Blood Sugar Levels"
                          : "रक्त शर्करा का स्तर",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 20 * (0.035 / 15) * widget._width,
                        fontStyle: FontStyle.normal,
                        color: Color(0xff2c2c2c),
                        // height: ,
                      ),
                    ),
                    SizedBox(
                      height: 5 * 0.00135869565 * widget._height,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          isLangEnglish
                              ? "Blood Sugar State: "
                              : "रक्त शर्करा राज्य:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 15 * (0.035 / 15) * widget._width,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF757575),
                            // height: ,
                          ),
                        ),
                        Text(
                          BS_list.isEmpty
                              ? "NA"
                              : BS_list.last.Status.toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 15 * (0.035 / 15) * widget._width,
                            fontStyle: FontStyle.normal,
                            color: BS_list.isEmpty
                                ? Colors.black
                                : (BS_list.last.Status == "Normal"
                                    ? Color(0xff29c44d)
                                    : Color(0xffff0000)),
                            // height: ,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      isLangEnglish ? "Last\nUpdated" : "आखरी\nअपडेट",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 12 * (0.035 / 15) * widget._width,
                        fontStyle: FontStyle.normal,
                        color: Color(0xFF757575),
                        // height: ,
                      ),
                    ),
                    SizedBox(
                      height: 0.00679347826 * widget._height,
                    ),
                    Text(
                      BS_list.isEmpty
                          ? "NA"
                          : date_time.check_today(
                                  BS_list.last.Date_time, DateTime.now())
                              ? isLangEnglish
                                  ? "Today"
                                  : "आज"
                              : DateFormat('hh:mm a\nMMM dd')
                                  .format(BS_list.last.Date_time),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: BS_list.isEmpty
                            ? 20 * (0.035 / 15) * widget._width
                            : date_time.check_today(
                                    BS_list.last.Date_time, DateTime.now())
                                ? 20 * (0.035 / 15) * widget._width
                                : 15 * (0.035 / 15) * widget._width,
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
          SizedBox(
            height: 0.0015 * widget._height,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Color(0xffececec)),
              borderRadius: BorderRadius.circular(12),
            ),
            height: 0.62251739 * widget._height,
            width: 1 * widget._width,
            padding: EdgeInsets.fromLTRB(
              5 * 0.00277777778 * widget._width,
              1 * 0.00277777778 * widget._height,
              5 * 0.00277777778 * widget._width,
              1 * 0.00277777778 * widget._height,
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              shrinkWrap: false,
              children: [
                // Details For BP
                Container(
                  height: 0.4251739 * widget._height,
                  width: 0.7777777 * widget._width,
                  padding: EdgeInsets.only(
                    top: 5 * 0.00135869565 * widget._height,
                  ),
                  child: BS_list.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isLangEnglish
                                  ? "No Record\nAvailable"
                                  : "कोई रिकॉर्ड नहीं\nउपलब्ध",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 20 * (0.035 / 15) * widget._width,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff2c2c2c),
                                // height: ,
                              ),
                            )
                          ],
                        )
                      : ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: BS_list.length > 6 ? 6 : BS_list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Text(
                                  DateFormat('EE\nMMM dd').format(
                                      BS_list.elementAt(index).Date_time),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12 * (0.035 / 15) * widget._width,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xff2c2c2c),
                                    // height: ,
                                  ),
                                ),
                                SizedBox(
                                  width: 0.01 * widget._width,
                                ),
                                Container(
                                  height: 0.0326086957 * widget._height,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.3,
                                      color: Color(0xffb8b8ba),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 0.01 * widget._width,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      isLangEnglish ? "Fasting" : "उपवास",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            12 * (0.035 / 15) * widget._width,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xff42ccc3),
                                        // height: ,
                                      ),
                                    ),
                                    Text(
                                      "${BS_list.elementAt(index).Fasting} mg/dl",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            12 * (0.035 / 15) * widget._width,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xff2c2c2c),
                                        // height: ,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 0.01 * widget._width,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      isLangEnglish ? "Random" : "अनियमित",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            12 * (0.035 / 15) * widget._width,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xff5662f6),
                                        // height: ,
                                      ),
                                    ),
                                    Text(
                                      "${BS_list.elementAt(index).Random} mg/dl",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            12 * (0.035 / 15) * widget._width,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xff2c2c2c),
                                        // height: ,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 0.01 * widget._width,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      isLangEnglish
                                          ? "Post\nPrandial"
                                          : "पोस्ट\nप्रांडियल",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            12 * (0.035 / 15) * widget._width,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xff5662f6),
                                        // height: ,
                                      ),
                                    ),
                                    Text(
                                      "${BS_list.elementAt(index).Post_Prandial} mg/dl",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            12 * (0.035 / 15) * widget._width,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xff2c2c2c),
                                        // height: ,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 0.01 * widget._width,
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                            height: 0.025 * widget._height,
                          ),
                        ),
                ),

                Container(
                  padding: EdgeInsets.only(
                    left: 0.0015 * widget._width,
                    top: 0,
                  ),
                  width: 0.75 * widget._width,
                  child: !is_newentry
                      ? Column(
                          // mainAxisAlignment: MainAxisAlignment.,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isLangEnglish ? "NEW ENTRY" : "नविन प्रवेश",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 20 * (0.035 / 15) * widget._width,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff2c2c2c),
                                // height: ,
                              ),
                            ),
                            SizedBox(
                              height: 0.0015 * widget._height,
                            ),
                            SizedBox(
                              width: 0.8988888 * widget._width,
                              height: 50 * 0.00135869565 * widget._height,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 0.7888888 * widget._width * 0.3,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        horizontalTitleGap: 0,
                                        minLeadingWidth: 0,
                                        dense: true,
                                        title: Text(
                                          isLangEnglish ? "Fasting" : "उपवास",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12 *
                                                (0.035 / 15) *
                                                widget._width,
                                            fontStyle: FontStyle.normal,
                                            color: Color(0xFF2C2C2C),
                                            // height: ,
                                          ),
                                        ),
                                        leading: Radio<Bloodpressure_choice>(
                                          value: Bloodpressure_choice.Fasting,
                                          groupValue: _choice,
                                          onChanged:
                                              (Bloodpressure_choice? value) {
                                            setState(() {
                                              _choice = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 0.7988888 * widget._width * 0.3,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        horizontalTitleGap: 0,
                                        minLeadingWidth: 0,
                                        dense: true,
                                        title: Text(
                                          isLangEnglish ? "Random" : "अनियमित",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12 *
                                                (0.035 / 15) *
                                                widget._width,
                                            fontStyle: FontStyle.normal,
                                            color: Color(0xFF2C2C2C),
                                            // height: ,
                                          ),
                                        ),
                                        leading: Radio<Bloodpressure_choice>(
                                          value: Bloodpressure_choice.Random,
                                          groupValue: _choice,
                                          onChanged:
                                              (Bloodpressure_choice? value) {
                                            setState(() {
                                              _choice = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 0.6988888 * widget._width * 0.33,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        horizontalTitleGap: 0,
                                        minLeadingWidth: 0,
                                        dense: true,
                                        title: Text(
                                          isLangEnglish
                                              ? "Post Prandial"
                                              : "पोस्ट परांडियल",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12 *
                                                (0.035 / 15) *
                                                widget._width,
                                            fontStyle: FontStyle.normal,
                                            color: Color(0xFF2C2C2C),
                                            // height: ,
                                          ),
                                        ),
                                        leading: Radio<Bloodpressure_choice>(
                                          value: Bloodpressure_choice
                                              .Post_Prandial,
                                          groupValue: _choice,
                                          onChanged:
                                              (Bloodpressure_choice? value) {
                                            setState(() {
                                              _choice = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.0015 * widget._height,
                            ),

                            Row(
                              children: [
                                Text(
                                  "${_choice == Bloodpressure_choice.Fasting ? "${isLangEnglish ? "Fasting" : "उपवास"}" : (_choice == Bloodpressure_choice.Random ? "${isLangEnglish ? "Random" : "अनियमित"}" : "${isLangEnglish ? "Post\nPrandial" : "पोस्ट\nप्रांडियल"}")} ${isLangEnglish ? "Blood Pressure" : "रक्त चाप"}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15 * (0.035 / 15) * widget._width,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xff2c2c2c),
                                    // height: ,
                                  ),
                                ),
                                Icon(
                                  CupertinoIcons.thermometer,
                                  color: Color(0xff42cdc3),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5 * 0.00135869565 * widget._height,
                            ),
                            SizedBox(
                              width: 0.6422222222 * widget._width,
                              height: 0.03594736842 * widget._height,
                              child: TextField(
                                controller: (_choice ==
                                        Bloodpressure_choice.Fasting
                                    ? _Fasting_Controller
                                    : (_choice == Bloodpressure_choice.Random
                                        ? _Random_Controller
                                        : _Post_Prandial_Controller)),
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: InputDecoration(
                                  hintText:
                                      "${_choice == Bloodpressure_choice.Fasting ? "${isLangEnglish ? "Fasting" : "उपवास"}" : (_choice == Bloodpressure_choice.Random ? "${isLangEnglish ? "Random" : "अनियमित"}" : "${isLangEnglish ? "Post\nPrandial" : "पोस्ट\nप्रांडियल"}")} ${isLangEnglish ? "Blood Pressure" : "रक्त चाप"}",
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffebebeb),
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15 * (0.035 / 15) * widget._width,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xff6c757d),
                                  ),
                                  suffixText: "mg/dl",
                                  suffixStyle: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15 * (0.035 / 15) * widget._width,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xff6c757d),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (String input) {},
                              ),
                            ),

                            SizedBox(
                              height: 10 * 0.00135869565 * widget._height,
                            ),

                            Row(
                              children: [
                                Text(
                                  isLangEnglish
                                      ? "Date & Time"
                                      : "दिनांक & समय",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15 * (0.035 / 15) * widget._width,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xff2c2c2c),
                                    // height: ,
                                  ),
                                ),
                                Icon(
                                  CupertinoIcons.time,
                                  color: Color(0xff42ccc3),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5 * 0.00135869565 * widget._height,
                            ),
                            SizedBox(
                              width: 0.65 * widget._width,
                              height: 0.035 * widget._height,
                              child: TextField(
                                controller: _DayDate_Controller,
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: InputDecoration(
                                  hintText: isLangEnglish
                                      ? "Date & Time"
                                      : "दिनांक & समय",
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xffebebeb),
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15 * (0.035 / 15) * widget._width,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xff6c757d),
                                  ),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  date_time temp = date_time();
                                  DateTime? selectedDate =
                                      await temp.selectDate(context);
                                  TimeOfDay? selectedTime =
                                      await temp.selectTime(context);
                                  setState(() {
                                    if (selectedDate == null ||
                                        selectedTime == null) {
                                      return;
                                    }
                                    Date_Time = DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedTime.hour,
                                      selectedTime.minute,
                                    );

                                    _DayDate_Controller.text =
                                        DateFormat('hh:mm a, MMM dd').format(
                                      Date_Time,
                                    );
                                    // print(_DayDate_Controller.text);
                                  });
                                },
                                onChanged: (String input) {
                                  // print(input);
                                },
                              ),
                            ),

                            SizedBox(
                              height: 0.0015 * widget._height,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      isLangEnglish
                                          ? "Body\nTemp"
                                          : "शरीर\nतापमान",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            15 * (0.035 / 15) * widget._width,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xff2c2c2c),
                                        // height: ,
                                      ),
                                    ),
                                    Text(
                                      BS_list.isEmpty
                                          ? "NA"
                                          : (_choice ==
                                                  Bloodpressure_choice.Fasting
                                              ? BS_list.last.Fasting.toString()
                                              : (_choice ==
                                                      Bloodpressure_choice
                                                          .Random
                                                  ? BS_list.last.Random
                                                      .toString()
                                                  : BS_list.last.Post_Prandial
                                                      .toString())),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            15 * (0.035 / 15) * widget._width,
                                        fontStyle: FontStyle.normal,
                                        color: BS_list.isEmpty
                                            ? Colors.black
                                            : BS_list.last.color,
                                        // height: ,
                                      ),
                                    ),
                                    Text(
                                      " mg/dl",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            15 * (0.035 / 15) * widget._width,
                                        fontStyle: FontStyle.normal,
                                        color: BS_list.isEmpty
                                            ? Colors.black
                                            : BS_list.last.color,
                                        // height: ,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      isLangEnglish
                                          ? "Last\nUpdated"
                                          : "पिछला\nअपडेट",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            15 * (0.035 / 15) * widget._width,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF757575),
                                        // height: ,
                                      ),
                                    ),
                                    Text(
                                      BS_list.isEmpty
                                          ? "NA"
                                          : date_time.check_today(
                                                  BS_list.last.Date_time,
                                                  DateTime.now())
                                              ? isLangEnglish
                                                  ? "Today"
                                                  : "आज"
                                              : DateFormat('hh:mm a\nMMM dd')
                                                  .format(
                                                  BS_list.last.Date_time,
                                                ),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        fontSize: BS_list.isEmpty
                                            ? 20 * (0.035 / 15) * widget._width
                                            : date_time.check_today(
                                                    BS_list.last.Date_time,
                                                    DateTime.now())
                                                ? 20 *
                                                    (0.035 / 15) *
                                                    widget._width
                                                : 15 *
                                                    (0.035 / 15) *
                                                    widget._width,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF2C2C2C),
                                        // height: ,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 0.0015 * widget._height,
                            ),

                            //**Fasting
                            SizedBox(
                              width: 0.888888889 * widget._width,
                              child: SizedBox(
                                height: 150 * 0.00135869565 * widget._height,
                                width: 200 * 0.00277777778 * widget._width,
                                child: BS_list.isEmpty
                                    ? SfCartesianChart()
                                    : SfCartesianChart(
                                        // Initialize category axis
                                        primaryXAxis: CategoryAxis(
                                          isVisible: true,
                                          majorTickLines: MajorTickLines(
                                            color: Colors.transparent,
                                          ),
                                          minorTickLines: MinorTickLines(
                                            color: Colors.transparent,
                                          ),
                                          majorGridLines: MajorGridLines(
                                            color: Colors.transparent,
                                          ),
                                          minorGridLines: MinorGridLines(
                                            color: Colors.transparent,
                                          ),
                                          labelStyle: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12 *
                                                (0.035 / 15) *
                                                widget._width,
                                            fontStyle: FontStyle.normal,
                                            color: Color(0xffb8b8ba),
                                            // height: ,
                                          ),
                                        ),
                                        primaryYAxis: CategoryAxis(
                                          isVisible: true,
                                          majorTickLines: MajorTickLines(
                                            color: Colors.transparent,
                                          ),
                                          minorTickLines: MinorTickLines(
                                            color: Colors.transparent,
                                          ),
                                          majorGridLines: MajorGridLines(
                                            color: Color(0xffb8b8ba),
                                            // width: 1,
                                            dashArray: <double>[5, 5],
                                          ),
                                          minorGridLines: MinorGridLines(
                                            color: Colors.transparent,
                                          ),
                                          minorTicksPerInterval: 2,
                                          labelStyle: TextStyle(
                                            fontSize: 0,
                                          ),
                                          visibleMinimum: 95,
                                          axisLine: AxisLine(
                                            width: 0,
                                          ),
                                        ),
                                        series: <ChartSeries>[
                                          // Initialize line series
                                          ColumnSeries<blood_sugar_lvl, String>(
                                            dataSource: BS_list,
                                            xValueMapper:
                                                (blood_sugar_lvl data, _) =>
                                                    DateFormat('EE')
                                                        .format(data.Date_time),
                                            yValueMapper: (blood_sugar_lvl data,
                                                    _) =>
                                                (_choice ==
                                                        Bloodpressure_choice
                                                            .Fasting
                                                    ? data.Fasting
                                                    : (_choice ==
                                                            Bloodpressure_choice
                                                                .Random
                                                        ? data.Random
                                                        : data.Post_Prandial)),
                                            pointColorMapper:
                                                (blood_sugar_lvl data, _) =>
                                                    data.color,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            // color: Color(0xff42cdc3),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                            //**Fasting
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5 * 0.00135869565 * widget._height,
                            ),

                            //**Fasting
                            Text(
                              isLangEnglish ? "Fasting" : "उपवास",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 18 * (0.035 / 15) * widget._width,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff2c2c2c),
                                // height: ,
                              ),
                            ),
                            SizedBox(
                              width: 0.888888889 * widget._width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        isLangEnglish
                                            ? "Last\nUpdated"
                                            : "आखरी\nअपडेट",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              12 * (0.035 / 15) * widget._width,
                                          fontStyle: FontStyle.normal,
                                          color: Color(0xFF757575),
                                          // height: ,
                                        ),
                                      ),
                                      Text(
                                        BS_list.isEmpty
                                            ? "NA"
                                            : date_time.check_today(
                                                    BS_list.last.Date_time,
                                                    DateTime.now())
                                                ? isLangEnglish
                                                    ? "Today"
                                                    : "आज"
                                                : DateFormat('hh:mm a\nMMM dd')
                                                    .format(
                                                    BS_list.last.Date_time,
                                                  ),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              12 * (0.035 / 15) * widget._width,
                                          fontStyle: FontStyle.normal,
                                          color: Color(0xff2c2c2c),
                                          // height: ,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.122282609 * widget._height,
                                    width: 170 * 0.00277777778 * widget._width,
                                    child: BS_list.isEmpty
                                        ? SfCartesianChart()
                                        : SfCartesianChart(
                                            // Initialize category axis
                                            primaryXAxis: CategoryAxis(
                                              isVisible: true,
                                              majorTickLines: MajorTickLines(
                                                color: Colors.transparent,
                                              ),
                                              minorTickLines: MinorTickLines(
                                                color: Colors.transparent,
                                              ),
                                              majorGridLines: MajorGridLines(
                                                color: Colors.transparent,
                                              ),
                                              minorGridLines: MinorGridLines(
                                                color: Colors.transparent,
                                              ),
                                              labelStyle: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12 *
                                                    (0.035 / 15) *
                                                    widget._width,
                                                fontStyle: FontStyle.normal,
                                                color: Color(0xffb8b8ba),
                                                // height: ,
                                              ),
                                            ),
                                            primaryYAxis: CategoryAxis(
                                              isVisible: true,
                                              majorTickLines: MajorTickLines(
                                                color: Colors.transparent,
                                              ),
                                              minorTickLines: MinorTickLines(
                                                color: Colors.transparent,
                                              ),
                                              majorGridLines: MajorGridLines(
                                                color: Color(0xffb8b8ba),
                                                // width: 1,
                                                dashArray: <double>[5, 5],
                                              ),
                                              minorGridLines: MinorGridLines(
                                                color: Colors.transparent,
                                              ),
                                              minorTicksPerInterval: 2,
                                              labelStyle: TextStyle(
                                                fontSize: 0,
                                              ),
                                              visibleMinimum: 95,
                                              axisLine: AxisLine(
                                                width: 0,
                                              ),
                                            ),
                                            series: <ChartSeries>[
                                              // Initialize line series
                                              ColumnSeries<blood_sugar_lvl,
                                                  String>(
                                                dataSource: BS_list,
                                                xValueMapper:
                                                    (blood_sugar_lvl data, _) =>
                                                        DateFormat('EE').format(
                                                  data.Date_time,
                                                ),
                                                yValueMapper:
                                                    (blood_sugar_lvl data, _) =>
                                                        data.Fasting,
                                                pointColorMapper:
                                                    (blood_sugar_lvl data, _) =>
                                                        data.color,
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                // color: Color(0xff42cdc3),
                                              ),
                                            ],
                                          ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        BS_list.isEmpty
                                            ? "NA"
                                            : BS_list.last.Fasting.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              15 * (0.035 / 15) * widget._width,
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
                                          fontSize:
                                              13 * (0.035 / 15) * widget._width,
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

                            SizedBox(
                              height: 0.0015 * widget._height,
                            ),

                            //**Random
                            Text(
                              isLangEnglish ? "Random" : "यादृच्छिक",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 18 * (0.035 / 15) * widget._width,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff2c2c2c),
                                // height: ,
                              ),
                            ),
                            SizedBox(
                              width: 0.9 * widget._width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        isLangEnglish
                                            ? "Last\nUpdated"
                                            : "आखरी\nअपडेट",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              12 * (0.035 / 15) * widget._width,
                                          fontStyle: FontStyle.normal,
                                          color: Color(0xFF757575),
                                          // height: ,
                                        ),
                                      ),
                                      Text(
                                        BS_list.isEmpty
                                            ? "NA"
                                            : date_time.check_today(
                                                    BS_list.last.Date_time,
                                                    DateTime.now())
                                                ? isLangEnglish
                                                    ? "Today"
                                                    : "आज"
                                                : DateFormat('hh:mm a\nMMM dd')
                                                    .format(
                                                    BS_list.last.Date_time,
                                                  ),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              12 * (0.035 / 15) * widget._width,
                                          fontStyle: FontStyle.normal,
                                          color: Color(0xff2c2c2c),
                                          // height: ,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.122282609 * widget._height,
                                    width: 170 * 0.00277777778 * widget._width,
                                    child: BS_list.isEmpty
                                        ? SfCartesianChart()
                                        : SfCartesianChart(
                                            // Initialize category axis
                                            primaryXAxis: CategoryAxis(
                                              isVisible: true,
                                              majorTickLines: MajorTickLines(
                                                color: Colors.transparent,
                                              ),
                                              minorTickLines: MinorTickLines(
                                                color: Colors.transparent,
                                              ),
                                              majorGridLines: MajorGridLines(
                                                color: Colors.transparent,
                                              ),
                                              minorGridLines: MinorGridLines(
                                                color: Colors.transparent,
                                              ),
                                              labelStyle: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12 *
                                                    (0.035 / 15) *
                                                    widget._width,
                                                fontStyle: FontStyle.normal,
                                                color: Color(0xffb8b8ba),
                                                // height: ,
                                              ),
                                            ),
                                            primaryYAxis: CategoryAxis(
                                              isVisible: true,
                                              majorTickLines: MajorTickLines(
                                                color: Colors.transparent,
                                              ),
                                              minorTickLines: MinorTickLines(
                                                color: Colors.transparent,
                                              ),
                                              majorGridLines: MajorGridLines(
                                                color: Color(0xffb8b8ba),
                                                // width: 1,
                                                dashArray: <double>[5, 5],
                                              ),
                                              minorGridLines: MinorGridLines(
                                                color: Colors.transparent,
                                              ),
                                              minorTicksPerInterval: 2,
                                              labelStyle: TextStyle(
                                                fontSize: 0,
                                              ),
                                              visibleMinimum: 95,
                                              axisLine: AxisLine(
                                                width: 0,
                                              ),
                                            ),
                                            series: <ChartSeries>[
                                              // Initialize line series
                                              ColumnSeries<blood_sugar_lvl,
                                                  String>(
                                                dataSource: BS_list,
                                                xValueMapper:
                                                    (blood_sugar_lvl data, _) =>
                                                        DateFormat('EE').format(
                                                  data.Date_time,
                                                ),
                                                yValueMapper:
                                                    (blood_sugar_lvl data, _) =>
                                                        data.Random,
                                                pointColorMapper:
                                                    (blood_sugar_lvl data, _) =>
                                                        data.color,
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                // color: Color(0xff42cdc3),
                                              ),
                                            ],
                                          ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        BS_list.isEmpty
                                            ? "NA"
                                            : BS_list.last.Random.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              15 * (0.035 / 15) * widget._width,
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
                                          fontSize:
                                              13 * (0.035 / 15) * widget._width,
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

                            SizedBox(
                              height: 0.0015 * widget._height,
                            ),

                            //**Post Prandial
                            Text(
                              isLangEnglish
                                  ? "Post Prandial"
                                  : "प्रांडियल पोस्ट",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 18 * (0.035 / 15) * widget._width,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff2c2c2c),
                                // height: ,
                              ),
                            ),
                            SizedBox(
                              width: 0.888888889 * widget._width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        isLangEnglish
                                            ? "Last\nUpdated"
                                            : "आखरी\nअपडेट",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              12 * (0.035 / 15) * widget._width,
                                          fontStyle: FontStyle.normal,
                                          color: Color(0xFF757575),
                                          // height: ,
                                        ),
                                      ),
                                      Text(
                                        BS_list.isEmpty
                                            ? "NA"
                                            : date_time.check_today(
                                                    BS_list.last.Date_time,
                                                    DateTime.now())
                                                ? isLangEnglish
                                                    ? "Today"
                                                    : "आज"
                                                : DateFormat('hh:mm a\nMMM dd')
                                                    .format(
                                                        BS_list.last.Date_time),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              12 * (0.035 / 15) * widget._width,
                                          fontStyle: FontStyle.normal,
                                          color: Color(0xff2c2c2c),
                                          // height: ,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.122282609 * widget._height,
                                    width: 170 * 0.00277777778 * widget._width,
                                    child: BS_list.isEmpty
                                        ? SfCartesianChart()
                                        : SfCartesianChart(
                                            // Initialize category axis
                                            primaryXAxis: CategoryAxis(
                                              isVisible: true,
                                              majorTickLines: MajorTickLines(
                                                color: Colors.transparent,
                                              ),
                                              minorTickLines: MinorTickLines(
                                                color: Colors.transparent,
                                              ),
                                              majorGridLines: MajorGridLines(
                                                color: Colors.transparent,
                                              ),
                                              minorGridLines: MinorGridLines(
                                                color: Colors.transparent,
                                              ),
                                              labelStyle: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12 *
                                                    (0.035 / 15) *
                                                    widget._width,
                                                fontStyle: FontStyle.normal,
                                                color: Color(0xffb8b8ba),
                                                // height: ,
                                              ),
                                            ),
                                            primaryYAxis: CategoryAxis(
                                              isVisible: true,
                                              majorTickLines: MajorTickLines(
                                                color: Colors.transparent,
                                              ),
                                              minorTickLines: MinorTickLines(
                                                color: Colors.transparent,
                                              ),
                                              majorGridLines: MajorGridLines(
                                                color: Color(0xffb8b8ba),
                                                // width: 1,
                                                dashArray: <double>[5, 5],
                                              ),
                                              minorGridLines: MinorGridLines(
                                                color: Colors.transparent,
                                              ),
                                              minorTicksPerInterval: 2,
                                              labelStyle: TextStyle(
                                                fontSize: 0,
                                              ),
                                              visibleMinimum: 95,
                                              axisLine: AxisLine(
                                                width: 0,
                                              ),
                                            ),
                                            series: <ChartSeries>[
                                              // Initialize line series
                                              ColumnSeries<blood_sugar_lvl,
                                                  String>(
                                                dataSource: BS_list,
                                                xValueMapper:
                                                    (blood_sugar_lvl data, _) =>
                                                        DateFormat('EE').format(
                                                  data.Date_time,
                                                ),
                                                yValueMapper:
                                                    (blood_sugar_lvl data, _) =>
                                                        data.Post_Prandial,
                                                pointColorMapper:
                                                    (blood_sugar_lvl data, _) =>
                                                        data.color,
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                // color: Color(0xff42cdc3),
                                              ),
                                            ],
                                          ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        BS_list.isEmpty
                                            ? "NA"
                                            : BS_list.last.Post_Prandial
                                                .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              15 * (0.035 / 15) * widget._width,
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
                                          fontSize:
                                              13 * (0.035 / 15) * widget._width,
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
                            //**Post Prandial

                            SizedBox(
                              height: 0.0015 * widget._height,
                            ),
                            //**Post Prandial
                          ],
                        ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10 * 0.00135869565 * widget._height,
          ),
          Container(
            alignment: Alignment.topCenter,
            child: TextButton(
                onPressed: () {
                  setState(() {
                    if (!is_newentry && Date_Time != null) {
                      int? Fasting;
                      int? Random;
                      int? Post_Prandial;
                      try {
                        Fasting = int.tryParse(_Fasting_Controller.text);
                        Random = int.tryParse(_Random_Controller.text);
                        Post_Prandial =
                            int.tryParse(_Post_Prandial_Controller.text);
                      } catch (e) {
                        return;
                      }

                      if (Fasting != null &&
                          Random != null &&
                          Post_Prandial != null) {
                        // if (BS_list.length >= 6) {
                        //   BS_list.removeAt(0);
                        // }

                        // BS_list.add(
                        //   blood_sugar_lvl(
                        //     Fasting,
                        //     Random,
                        //     Post_Prandial,
                        //     Date_Time,
                        //   ),
                        // );

                        Provider.of<PatientHealthAndWellNessDetails>(context,
                                listen: false)
                            .addPatientBloodSugarLevel(
                          context,
                          blood_sugar_lvl(
                            Fasting,
                            Random,
                            Post_Prandial,
                            Date_Time,
                          ),
                          Provider.of<PatientUserDetails>(context,
                                  listen: false)
                              .getIndividualObjectDetails(),
                        );
                      }

                      _Fasting_Controller.clear();
                      _Random_Controller.clear();
                      _Post_Prandial_Controller.clear();
                      _DayDate_Controller.clear();
                    }

                    is_newentry = !is_newentry;
                  });
                },
                style: TextButton.styleFrom(
                    backgroundColor: Color(0xff42ccc3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    minimumSize: Size(
                      0.777777778 * widget._width,
                      0.0407608696 * widget._height,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      is_newentry ? Icons.edit : CupertinoIcons.checkmark_alt,
                      color: Color(0xffffffff),
                    ),
                    Text(
                      is_newentry
                          ? isLangEnglish
                              ? "NEW ENTRY"
                              : "नविन प्रवेश"
                          : isLangEnglish
                              ? "SAVE"
                              : "सहेजें",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 15 * (0.035 / 15) * widget._width,
                        fontStyle: FontStyle.normal,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 10 * 0.00135869565 * widget._height,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BS_list =
        Provider.of<PatientHealthAndWellNessDetails>(context, listen: false)
            .getBloodSugarLevelList();

    return Container(
      margin: EdgeInsets.only(bottom: 0.0135869565 * widget._height),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (is_newentry) {
              is_initial = !is_initial;
            }
          });
        },
        child: is_initial ? Blood_sugar_inital() : Blood_sugar_ontap(),
        //   child: Body_temp_initial(),
      ),
    );
  }
}
