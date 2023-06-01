import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/haemoglobin_info.dart';
import '../../providers/paientHealthAndWellNess_details.dart';
import '../../providers/patientUser_details.dart';
import 'Date_Time.dart';

class Haemoglobin extends StatefulWidget {
  Haemoglobin({
    Key? key,
    required double width,
    required double height,
  })  : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;

  @override
  State<Haemoglobin> createState() => _HaemoglobinState();
}

// class haemoglobin {
//   double? Hemoglobin_lvl;
//   DateTime? Date_time;
//   Color? color;

//   haemoglobin(this.Hemoglobin_lvl, this.Date_time) {
//     color = Color(0xff42cdc3);
//   }
// }

class _HaemoglobinState extends State<Haemoglobin> {
  bool isLangEnglish = true;
  List<haemoglobin> Haemo_list = [];

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
        .fetchPreviousHaemoglobinLevelList(
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );
  }

  bool is_initial = true;
  bool is_newentry = true;

  DateTime temp_date_time = DateTime.now();
  DateTime Date_Time = DateTime.now();

  TextEditingController _Haemoglobin_Controller = TextEditingController();
  TextEditingController _DayDate_Controller = TextEditingController();

  Haemoglobin_initial() {
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
          left: 0.015 * widget._width,
          right: 0.015 * widget._width,
          top: 0.015 * widget._height,
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
                  Text(
                    isLangEnglish ? "Haemoglobin" : "हीमोग्लोबिन",
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
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                      isLangEnglish ? "Last\nUpdate" : "आखरी अपडेट",
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
                      Haemo_list.isEmpty
                          ? "NA"
                          : date_time.check_today(
                              Haemo_list.last.Date_time,
                              DateTime.now(),
                            )
                              ? isLangEnglish
                                  ? "Today"
                                  : "आज"
                              : DateFormat('hh:mm a\nMMM dd').format(
                                  Haemo_list.last.Date_time,
                                ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: Haemo_list.isEmpty
                            ? 20 * (0.035 / 15) * widget._width
                            : date_time.check_today(
                                Haemo_list.last.Date_time,
                                DateTime.now(),
                              )
                                ? 20 * (0.035 / 15) * widget._width
                                : 15 * (0.035 / 15) * widget._width,
                        fontStyle: FontStyle.normal,
                        color: Color(0xFF2C2C2C),
                        // height: ,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            SizedBox(height: 10 * 0.00135869565 * widget._height),
            SizedBox(
              height: 100 * 0.00135869565 * widget._height,
              width: 0.888888889 * widget._width,
              child: Haemo_list.isEmpty
                  ? SfCartesianChart()
                  : SfCartesianChart(
                      // Initialize category axis
                      primaryXAxis: CategoryAxis(
                        isVisible: false,
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
                        axisLine: AxisLine(
                          width: 0,
                        ),
                        maximumLabels: 2,
                        // minimum: 20,
                      ),
                      series: <ChartSeries>[
                        // Initialize line series
                        LineSeries<haemoglobin, String>(
                          dataSource: Haemo_list,
                          xValueMapper: (haemoglobin data, _) =>
                              DateFormat('EE').format(
                            data.Date_time,
                          ),
                          yValueMapper: (haemoglobin data, _) =>
                              data.Hemoglobin_lvl,
                          markerSettings: MarkerSettings(
                            isVisible: true,
                          ),
                          color: Color(0xff42cdc3),
                        ),
                      ],
                    ),
            ),
            SizedBox(
              height: 10 * 0.00135869565 * widget._height,
            ),
          ],
        ));
  }

  Haemoglobin_ontap() {
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
            left: 0.035555 * widget._width,
            right: 0.035555 * widget._width,
            top: 0.02240071739130434783 * widget._height),
        width: 0.7988888 * widget._width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(right: 0.035555 * widget._width),
              child: Text(
                isLangEnglish ? "Haemoglobin" : "हीमोग्लोबिन",
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
            ),
            SizedBox(
              height: 10 * 0.00135869565 * widget._height,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Color(0xffececec)),
                borderRadius: BorderRadius.circular(12),
              ),
              height: 0.25251739 * widget._height,
              width: 1 * widget._width,
              padding: EdgeInsets.fromLTRB(
                12 * 0.00277777778 * widget._width,
                1 * 0.00277777778 * widget._height,
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
                    height: 0.3251739 * widget._height,
                    width: 0.37577777 * widget._width,
                    padding: EdgeInsets.zero,
                    child: Haemo_list.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Text(
                                  isLangEnglish
                                      ? "No Record\nAvailable"
                                      : "रिकॉर्ड\nउपलब्ध नहीं",
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
                              ])
                        : ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount:
                                Haemo_list.length > 5 ? 5 : Haemo_list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Text(
                                    DateFormat('EE\nMMM dd').format(
                                      Haemo_list.elementAt(index).Date_time,
                                    ),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          10 * (0.035 / 15) * widget._width,
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
                                        isLangEnglish
                                            ? "Haemoglobin"
                                            : "हीमोग्लोबिन",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              10 * (0.035 / 15) * widget._width,
                                          fontStyle: FontStyle.normal,
                                          color: Color(0xff42ccc3),
                                          // height: ,
                                        ),
                                      ),
                                      Text(
                                        "${Haemo_list.isEmpty ? "NA" : Haemo_list.elementAt(index).Hemoglobin_lvl} g/dl",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              10 * (0.035 / 15) * widget._width,
                                          fontStyle: FontStyle.normal,
                                          color: Color(0xff2c2c2c),
                                          // height: ,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => SizedBox(
                              height: 0.02 * widget._height,
                            ),
                          ),
                  ),

                  Container(
                      padding: EdgeInsets.only(
                        left: 5 * 0.0025 * widget._width,
                        top: 0,
                      ),
                      width: 0.7 * widget._width,
                      child: !is_newentry
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  isLangEnglish ? "New Entry" : "नविन प्रवेश",
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
                                Row(
                                  children: [
                                    Text(
                                      isLangEnglish
                                          ? "Haemoglobin "
                                          : "हीमोग्लोबिन ",
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
                                      CupertinoIcons.drop,
                                      color: Color(0xff42ccc3),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 0.6422222222 * widget._width,
                                  height: 0.0394736842 * widget._height,
                                  child: TextField(
                                    controller: _Haemoglobin_Controller,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                      hintText: isLangEnglish
                                          ? "Haemoglobin Intake"
                                          : "हीमोग्लोबिन सेवन",
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xffebebeb),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      hintStyle: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            15 * (0.035 / 15) * widget._width,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xff6c757d),
                                      ),
                                      suffixText: "g/dl",
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
                                          ? "Date & Time"
                                          : "दिनांक & समय",
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
                                      Icons.calendar_today,
                                      color: Color(0xff42ccc3),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 0.6422222222 * widget._width,
                                  height: 0.0394736842 * widget._height,
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
                                            DateFormat('hh:mm a, MMM dd')
                                                .format(
                                          Date_Time,
                                        );
                                        // print(_DayDate_Controller.text);
                                      });
                                    },
                                    onChanged: (String input) {
                                      // print(input);
                                    },
                                  ),
                                )
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          isLangEnglish
                                              ? "Haemoglobin"
                                              : "हीमोग्लोबिन",
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
                                        Row(
                                          children: [
                                            Text(
                                              Haemo_list.isEmpty
                                                  ? "NA"
                                                  : Haemo_list
                                                      .last.Hemoglobin_lvl
                                                      .toString(),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 25 *
                                                    (0.035 / 15) *
                                                    widget._width,
                                                fontStyle: FontStyle.normal,
                                                color: Haemo_list.isEmpty
                                                    ? Colors.black
                                                    : Haemo_list.last.color,
                                                // height: ,
                                              ),
                                            ),
                                            Text(
                                              " g/dl",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15 *
                                                    (0.035 / 15) *
                                                    widget._width,
                                                fontStyle: FontStyle.normal,
                                                color: Haemo_list.isEmpty
                                                    ? Colors.black
                                                    : Haemo_list.last.color,
                                                // height: ,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            isLangEnglish
                                                ? "Last\nUpdate"
                                                : "आखरी\nअपडेट",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15 *
                                                  (0.035 / 15) *
                                                  widget._width,
                                              fontStyle: FontStyle.normal,
                                              color: Color(0xFF757575),
                                              // height: ,
                                            ),
                                          ),
                                          Text(
                                            Haemo_list.isEmpty
                                                ? "NA"
                                                : date_time.check_today(
                                                        Haemo_list
                                                            .last.Date_time,
                                                        DateTime.now())
                                                    ? isLangEnglish
                                                        ? "Today"
                                                        : "आज"
                                                    : DateFormat(
                                                            'hh:mm a\nMMM dd')
                                                        .format(
                                                        Haemo_list
                                                            .last.Date_time,
                                                      ),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              fontSize: Haemo_list.isEmpty
                                                  ? 20 *
                                                      (0.035 / 15) *
                                                      widget._width
                                                  : date_time.check_today(
                                                          Haemo_list
                                                              .last.Date_time,
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
                                        ]),
                                  ],
                                ),
                                SizedBox(
                                  height: 90 * 0.00135869565 * widget._height,
                                  width: 280 * 0.00277777778 * widget._width,
                                  child: Haemo_list.isEmpty
                                      ? SfCartesianChart()
                                      : SfCartesianChart(
                                          // Initialize category axis
                                          primaryXAxis: CategoryAxis(
                                            isVisible: false,
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
                                            axisLine: AxisLine(
                                              width: 0,
                                            ),
                                            maximumLabels: 2,
                                            minimum: 20,
                                          ),
                                          series: <ChartSeries>[
                                              // Initialize line series
                                              LineSeries<haemoglobin, String>(
                                                dataSource: Haemo_list,
                                                xValueMapper:
                                                    (haemoglobin data, _) =>
                                                        DateFormat('EE').format(
                                                  data.Date_time,
                                                ),
                                                yValueMapper:
                                                    (haemoglobin data, _) =>
                                                        data.Hemoglobin_lvl,
                                                markerSettings: MarkerSettings(
                                                  isVisible: true,
                                                ),
                                                color: Color(0xff42cdc3),
                                              ),
                                            ]),
                                ),
                              ],
                            )),
                ],
              ),
            ),
            SizedBox(
              height: 10 * 0.00135 * widget._height,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (!is_newentry && Date_Time != null) {
                        double Haemoglobin = 0.0;
                        try {
                          Haemoglobin =
                              double.tryParse(_Haemoglobin_Controller.text)!;
                        } catch (e) {
                          return;
                        }

                        // if (Haemoglobin != null) {
                        //   if (Haemo_list.length >= 5) {
                        //     Haemo_list.removeAt(0);
                        //   }

                        //   Haemo_list.add(haemoglobin(Haemoglobin, Date_Time!));
                        // }
                        Provider.of<PatientHealthAndWellNessDetails>(context,
                                listen: false)
                            .addPatientHaemoglobinLevel(
                          context,
                          haemoglobin(
                            Hemoglobin_lvl: Haemoglobin,
                            Date_time: Date_Time,
                          ),
                          Provider.of<PatientUserDetails>(context,
                                  listen: false)
                              .getIndividualObjectDetails(),
                        );

                        _Haemoglobin_Controller.clear();
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
                      minimumSize: Size(0.777777778 * widget._width,
                          0.0407608696 * widget._height),
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
                                ? "New Entry"
                                : "नविन प्रवेश"
                            : isLangEnglish
                                ? "SAVE"
                                : "जमा करे",
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
        ));
  }

  @override
  Widget build(BuildContext context) {
    Haemo_list =
        Provider.of<PatientHealthAndWellNessDetails>(context, listen: false)
            .getHaemoglobinLevelList();

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
        child: is_initial ? Haemoglobin_initial() : Haemoglobin_ontap(),
        //   child: Body_temp_initial(),
      ),
    );
  }
}
