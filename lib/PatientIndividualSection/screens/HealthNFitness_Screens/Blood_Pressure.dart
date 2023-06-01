// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/blood_pressure.dart';
import '../../providers/paientHealthAndWellNess_details.dart';
import '../../providers/patientUser_details.dart';
import 'Date_Time.dart';

class Blood_Pressure extends StatefulWidget {
  Blood_Pressure({
    Key? key,
    required double width,
    required double height,
  })  : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;

  @override
  State<Blood_Pressure> createState() => _Blood_PressureState();
}

class _Blood_PressureState extends State<Blood_Pressure> {
  bool isLangEnglish = true;
  List<Blood_pressure> BP_list = [];
  // BP_list = Provider.of<PatientHealthAndWellNessDetails>(context, listen: false)
  //           .getBloodPressureList();

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;

    // Provider.of<PatientHealthAndWellNessDetails>(context, listen: false)
    //     .fetchPreviousBloodPressureList(
    //   Provider.of<PatientUserDetails>(context, listen: false)
    //       .getIndividualObjectDetails(),
    // );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    Provider.of<PatientHealthAndWellNessDetails>(context, listen: false)
        .fetchPreviousBloodPressureList(
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );
  }

  // BP_list = Provider.of<PatientHealthAndWellNessDetails>(context, listen: false)
  //           .getBloodPressureList();

  bool is_initial = true;
  bool is_newentry = true;

  DateTime temp_date_time = DateTime.now();
  DateTime Date_Time = DateTime.now();

  TextEditingController _Systolic_Controller = TextEditingController();
  TextEditingController _Diastolic_Controller = TextEditingController();
  TextEditingController _DayDate_Controller = TextEditingController();

  Blood_Pressure_on_tap() {
    return Container(
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
              left: 0.02 * widget._width,
              right: 0.02 * widget._width,
              top: 0.015 * widget._height,
            ),
            width: 0.915 * widget._width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  isLangEnglish ? "Blood Pressure" : "रक्त चाप",
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
                  height: 0.0135869565 * widget._height,
                ),
                SizedBox(
                  width: 0.3777777 * widget._width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            BP_list.isEmpty
                                ? "NA"
                                : BP_list.last.Systolic.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 20 * (0.035 / 15) * widget._width,
                              fontStyle: FontStyle.normal,
                              color: Color(0xff42cdc3),
                              // height: ,
                            ),
                          ),
                          SizedBox(width: 2 * 0.00277777778 * widget._width),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "SYS",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12 * (0.035 / 15) * widget._width,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xff42cdc3),
                                  // height: ,
                                ),
                              ),
                              Text(
                                "mmHg",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12 * (0.035 / 15) * widget._width,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xffb8b8ba),
                                  // height: ,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            BP_list.isEmpty
                                ? "NA"
                                : BP_list.last.Diastolic.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 20 * (0.035 / 15) * widget._width,
                              fontStyle: FontStyle.normal,
                              color: Color(0xff5662f6),
                              // height: ,
                            ),
                          ),
                          SizedBox(width: 2 * 0.00277777778 * widget._width),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "DIA",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12 * (0.035 / 15) * widget._width,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xff5662f6),
                                  // height: ,
                                ),
                              ),
                              Text(
                                "mmHg",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12 * (0.035 / 15) * widget._width,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xffb8b8ba),
                                  // height: ,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.0135869565 * widget._height,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xffececec)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 0.351739 * widget._height,
                  width: 0.9777777 * widget._width,
                  padding: EdgeInsets.fromLTRB(
                    12 * 0.00277777778 * widget._width,
                    5 * 0.00277777778 * widget._height,
                    12 * 0.00277777778 * widget._width,
                    1 * 0.00277777778 * widget._height,
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: false,
                    children: [
                      // Details For BP

                      Container(
                        height: 0.251739 * widget._height,
                        width: 0.5777777 * widget._width,
                        padding: EdgeInsets.zero,
                        child: BP_list.isEmpty
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
                                        fontSize:
                                            20 * (0.035 / 15) * widget._width,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xff2c2c2c),
                                        // height: ,
                                      ),
                                    )
                                  ])
                            : ListView.separated(
                                padding: EdgeInsets.zero,
                                itemCount:
                                    BP_list.length > 5 ? 5 : BP_list.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: [
                                      Text(
                                        DateFormat('EE\nMMM dd').format(
                                            BP_list.elementAt(index).Date_time),
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
                                      SizedBox(
                                        width: 0.0277777778 * widget._width,
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
                                        width: 0.0277777778 * widget._width,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "SYS",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12 *
                                                  (0.035 / 15) *
                                                  widget._width,
                                              fontStyle: FontStyle.normal,
                                              color: Color(0xff42ccc3),
                                              // height: ,
                                            ),
                                          ),
                                          Text(
                                            "${BP_list.isEmpty ? "NA" : BP_list.elementAt(index).Systolic} ${"mmHg"}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12 *
                                                  (0.035 / 15) *
                                                  widget._width,
                                              fontStyle: FontStyle.normal,
                                              color: Color(0xff2c2c2c),
                                              // height: ,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 0.0277777778 * widget._width,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "DIA",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12 *
                                                  (0.035 / 15) *
                                                  widget._width,
                                              fontStyle: FontStyle.normal,
                                              color: Color(0xff5662f6),
                                              // height: ,
                                            ),
                                          ),
                                          Text(
                                            "${BP_list.elementAt(index).Diastolic} ${"mmHg"}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12 *
                                                  (0.035 / 15) *
                                                  widget._width,
                                              fontStyle: FontStyle.normal,
                                              color: Color(0xff2c2c2c),
                                              // height: ,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 0.0277777778 * widget._width,
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(
                                  height: 0.03907608696 * widget._height,
                                ),
                              ),
                      ),

                      Container(
                        padding: EdgeInsets.only(
                            left: 5 * 0.00277777778 * widget._width, top: 0),
                        child: !is_newentry
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    isLangEnglish ? "New Entry" : "नविन प्रवेश",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          20 * (0.035 / 15) * widget._width,
                                      fontStyle: FontStyle.normal,
                                      color: Color(0xff2c2c2c),
                                      // height: ,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "SYS   ",
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
                                      Icon(
                                        CupertinoIcons.heart,
                                        color: Color(0xff42ccc3),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 0.6422222222 * widget._width,
                                    height: 0.03594736842 * widget._height,
                                    child: TextField(
                                      controller: _Systolic_Controller,
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                        hintText: isLangEnglish
                                            ? "Systolic blood pressure"
                                            : "सिस्टोलिक रक्तचाप",
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xffebebeb),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        hintStyle: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              15 * (0.035 / 15) * widget._width,
                                          fontStyle: FontStyle.normal,
                                          color: Color(0xff6c757d),
                                        ),
                                        suffixText: "mmhg",
                                        suffixStyle: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              15 * (0.035 / 15) * widget._width,
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
                                  Row(
                                    children: [
                                      Text(
                                        "DIA   ",
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
                                      Icon(
                                        CupertinoIcons.heart,
                                        color: Color(0xff5662f6),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 0.6422222222 * widget._width,
                                    height: 0.03594736842 * widget._height,
                                    child: TextField(
                                      controller: _Diastolic_Controller,
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                        hintText: isLangEnglish
                                            ? "Diastolic blood pressure"
                                            : "डायस्टोलिक रक्तचाप",
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xffebebeb),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        hintStyle: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              15 * (0.035 / 15) * widget._width,
                                          fontStyle: FontStyle.normal,
                                          color: Color(0xff6c757d),
                                        ),
                                        suffixText: "mmhg",
                                        suffixStyle: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              15 * (0.035 / 15) * widget._width,
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
                                  Row(
                                    children: [
                                      Text(
                                        isLangEnglish
                                            ? "Date & Time   "
                                            : "दिनांक & समय   ",
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
                                      Icon(
                                        CupertinoIcons.time,
                                        color: Color(0xff42ccc3),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 0.6422222222 * widget._width,
                                    height: 0.03594736842 * widget._height,
                                    child: TextField(
                                      controller: _DayDate_Controller,
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                        hintText: isLangEnglish
                                            ? "Date & Time"
                                            : "दिनांक & समय",
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xffebebeb),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        hintStyle: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              15 * (0.035 / 15) * widget._width,
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
                                        setState(
                                          () {
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
                                                DateFormat('hh:mm a, MMM dd')
                                                    .format(Date_Time);
                                            // print(_DayDate_Controller.text);
                                          },
                                        );
                                      },
                                      onChanged: (String input) {
                                        // print(input);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10 * 0.00135869565 * widget._height,
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            width:
                                                0.7777777 * 0.4 * widget._width,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "SYS",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15 *
                                                        (0.035 / 15) *
                                                        widget._width,
                                                    fontStyle: FontStyle.normal,
                                                    color: Color(0xff2c2c2c),
                                                    // height: ,
                                                  ),
                                                ),
                                                Icon(
                                                  CupertinoIcons.heart,
                                                  color: Color(0xff42ccc3),
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            BP_list.isEmpty
                                                ? "NA"
                                                : BP_list.last.Systolic
                                                    .toString(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 22 *
                                                  (0.035 / 15) *
                                                  widget._width,
                                              fontStyle: FontStyle.normal,
                                              color: Color(0xff2c2c2c),
                                              // height: ,
                                            ),
                                          ),
                                          Text(
                                            "mmHg",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15 *
                                                  (0.035 / 15) *
                                                  widget._width,
                                              fontStyle: FontStyle.normal,
                                              color: Color(0xffb8b8ba),
                                              // height: ,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 0.0277777778 * widget._width,
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width:
                                                0.7777777 * 0.4 * widget._width,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "DIA",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15 *
                                                        (0.035 / 15) *
                                                        widget._width,
                                                    fontStyle: FontStyle.normal,
                                                    color: Color(0xff2c2c2c),
                                                    // height: ,
                                                  ),
                                                ),
                                                Icon(
                                                  CupertinoIcons.heart,
                                                  color: Color(0xff5662f6),
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            BP_list.isEmpty
                                                ? "NA"
                                                : BP_list.last.Diastolic
                                                    .toString(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 22 *
                                                  (0.035 / 15) *
                                                  widget._width,
                                              fontStyle: FontStyle.normal,
                                              color: Color(0xff2c2c2c),
                                              // height: ,
                                            ),
                                          ),
                                          Text(
                                            "mmHg",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
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
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 0.23231548913 * widget._height,
                                    width: 0.65 * widget._width,
                                    padding: EdgeInsets.zero,
                                    child: BP_list.isEmpty
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
                                              LineSeries<Blood_pressure,
                                                  String>(
                                                dataSource: BP_list,
                                                xValueMapper:
                                                    (Blood_pressure data, _) =>
                                                        DateFormat('EE').format(
                                                            data.Date_time),
                                                yValueMapper:
                                                    (Blood_pressure data, _) =>
                                                        data.Systolic,
                                                markerSettings: MarkerSettings(
                                                  isVisible: true,
                                                ),
                                                color: Color(0xff5662f6),
                                              ),
                                              LineSeries<Blood_pressure,
                                                  String>(
                                                dataSource: BP_list,
                                                xValueMapper:
                                                    (Blood_pressure data, _) =>
                                                        DateFormat('EE').format(
                                                            data.Date_time),
                                                yValueMapper:
                                                    (Blood_pressure data, _) =>
                                                        data.Diastolic,
                                                markerSettings: MarkerSettings(
                                                  isVisible: true,
                                                ),
                                                color: Color(0xff42cdc3),
                                              ),
                                            ],
                                          ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.0135869565 * widget._height,
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (!is_newentry) {
                          int? SYS;
                          int? DIA;

                          try {
                            SYS = int.tryParse(_Systolic_Controller.text);
                            DIA = int.tryParse(_Diastolic_Controller.text);
                          } catch (e) {
                            return;
                          }

                          if (SYS != null && DIA != null) {
                            // if (BP_list.length >= 5) {
                            //   BP_list.removeAt(0);
                            // }
                            // BP_list.add(
                            //   // Blood_pressure({SYS, DIA, Date_Time}));
                            //   Blood_pressure(
                            //     Systolic: SYS,
                            //     Diastolic: DIA,
                            //     Date_time: Date_Time,
                            //   ),
                            // );

                            Provider.of<PatientHealthAndWellNessDetails>(
                              context,
                              listen: false,
                            ).addPatientBloodPressure(
                              context,
                              Blood_pressure(
                                Systolic: SYS,
                                Diastolic: DIA,
                                Date_time: Date_Time,
                              ),
                              Provider.of<PatientUserDetails>(context,
                                      listen: false)
                                  .getIndividualObjectDetails(),
                            );
                          }

                          Date_Time = DateTime.now();

                          _Systolic_Controller.clear();
                          _Diastolic_Controller.clear();
                          _DayDate_Controller.clear();
                        }

                        is_newentry = !is_newentry;
                      });

                      // Provider.of<PatientHealthAndWellNessDetails>(context, listen: false).addPatientBloodPressure(context, Blood_pressure(
                      //           Systolic: SYS,
                      //           Diastolic: DIA,
                      //           Date_time: Date_Time,
                      //         ),);
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xff42ccc3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        minimumSize: Size(0.777777778 * widget._width,
                            0.0407608696 * widget._height),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.center),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          is_newentry
                              ? Icons.edit
                              : CupertinoIcons.checkmark_alt,
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
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.0135869565 * widget._height,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Blood_Pressure_inital() {
    // Blood_pressure? BP_latest = BP_list.last;
    return Container(
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
              left: 0.025 * widget._width,
              right: 0.025 * widget._width,
              top: 0.01571739130434783 * widget._height,
            ),
            width: 0.9215 * widget._width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      isLangEnglish ? "Blood Pressure" : "रक्त चाप",
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
                      height: 10 * 0.00135869565 * widget._height,
                    ),
                    SizedBox(
                      width: 0.3777777 * widget._width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                BP_list.isEmpty
                                    ? "NA"
                                    : BP_list.last.Systolic.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20 * (0.035 / 15) * widget._width,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xff42cdc3),
                                  // height: ,
                                ),
                              ),
                              SizedBox(width: 0.00555555556 * widget._width),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "SYS",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          12 * (0.035 / 15) * widget._width,
                                      fontStyle: FontStyle.normal,
                                      color: Color(0xff42cdc3),
                                      // height: ,
                                    ),
                                  ),
                                  Text(
                                    "mmHg",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          12 * (0.035 / 15) * widget._width,
                                      fontStyle: FontStyle.normal,
                                      color: Color(0xffb8b8ba),
                                      // height: ,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                BP_list.isEmpty
                                    ? "NA"
                                    : BP_list.last.Diastolic.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20 * (0.035 / 15) * widget._width,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xff5662f6),
                                  // height: ,
                                ),
                              ),
                              SizedBox(width: 0.00555555556 * widget._width),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "DIA",
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
                                    "mmHg",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          12 * (0.035 / 15) * widget._width,
                                      fontStyle: FontStyle.normal,
                                      color: Color(0xffb8b8ba),
                                      // height: ,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10 * 0.00135869565 * widget._height,
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.0983152174 * widget._height,
                  width: 0.34816666667 * widget._width,
                  child: BP_list.isEmpty
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
                            LineSeries<Blood_pressure, String>(
                              dataSource: BP_list,
                              xValueMapper: (Blood_pressure data, _) =>
                                  DateFormat('EE').format(data.Date_time),
                              yValueMapper: (Blood_pressure data, _) =>
                                  data.Systolic,
                              markerSettings: MarkerSettings(isVisible: true),
                              color: Color(0xff5662f6),
                            ),
                            LineSeries<Blood_pressure, String>(
                              dataSource: BP_list,
                              xValueMapper: (Blood_pressure data, _) =>
                                  DateFormat('EE').format(data.Date_time),
                              yValueMapper: (Blood_pressure data, _) =>
                                  data.Diastolic,
                              markerSettings: MarkerSettings(isVisible: true),
                              color: Color(0xff42cdc3),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    this.BP_list =
        Provider.of<PatientHealthAndWellNessDetails>(context, listen: false)
            .getBloodPressureList();

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
        child: is_initial ? Blood_Pressure_inital() : Blood_Pressure_on_tap(),
      ),
    );
  }
}
