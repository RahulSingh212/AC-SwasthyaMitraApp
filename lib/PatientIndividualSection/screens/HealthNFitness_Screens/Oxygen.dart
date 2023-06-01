import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/oxygen_level_info.dart';
import '../../providers/paientHealthAndWellNess_details.dart';
import '../../providers/patientUser_details.dart';
import 'Date_Time.dart';

class Oxygen extends StatefulWidget {
  Oxygen({
    Key? key,
    required double width,
    required double height,
  })  : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;

  @override
  State<Oxygen> createState() => _OxygenState();
}

// class oxygen_lvl {
//   double? Oxy_lvl;
//   DateTime? Date_time;
//   String? Status;
//   Color? color;

//   oxygen_lvl(this.Oxy_lvl, this.Date_time,
//       {this.color = const Color(0xff5696f6)}) {
//     Status = "Normal";
//   }
// }

class _OxygenState extends State<Oxygen> {
  bool isLangEnglish = true;
  List<oxygen_lvl> Oxy_list = [];

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
        .fetchPreviousOxygenLevelList(
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );
  }

  DateTime temp_date_time = DateTime.now();
  DateTime Date_Time = DateTime.now();

  bool is_initial = true;
  bool is_newentry = true;

  TextEditingController _Oxygen_Controller = TextEditingController();
  TextEditingController _DayDate_Controller = TextEditingController();

  Oxygen_inital() {
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
          left: 0.035555 * widget._width,
          right: 0.035555 * widget._width,
          top: 0.01571739130434783 * widget._height,
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
                    isLangEnglish ? "Oxygen Level" : "ऑक्सीजन स्तर",
                    textAlign: TextAlign.center,
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
                      isLangEnglish ? "Last\nUpdated " : "पिचला\nअपडेट ",
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
                      Oxy_list.isEmpty
                          ? "NA"
                          : date_time.check_today(
                                  Oxy_list.last.Date_time, DateTime.now())
                              ? "Today"
                              : DateFormat('hh:mm a\nMMM dd').format(
                                  Oxy_list.last.Date_time,
                                ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: Oxy_list.isEmpty
                            ? 20 * (0.035 / 15) * widget._width
                            : date_time.check_today(
                                Oxy_list.last.Date_time,
                                DateTime.now(),
                              )
                                ? 20 * (0.035 / 15) * widget._width
                                : 15 * (0.035 / 15) * widget._width,
                        fontStyle: FontStyle.normal,
                        color: Color(0xFF2C2C2C),
                        // height: ,
                      ),
                    )
                  ]),
                ],
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
                      ? "Oxygen Level State: "
                      : "ऑक्सीजन स्तर राज्य: ",
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
                  Oxy_list.isEmpty ? "NA" : Oxy_list.last.Status.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 15 * (0.035 / 15) * widget._width,
                    fontStyle: FontStyle.normal,
                    color: Oxy_list.isEmpty
                        ? Colors.black
                        : Oxy_list.last.Status == "Normal"
                            ? Color(0xff29c44d)
                            : Color(0xffff0000),
                    // height: ,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 100 * 0.00135869565 * widget._height,
                  width: 177 * 0.00277777778 * widget._width,
                  child: Oxy_list.isEmpty
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
                              axisLine: AxisLine(
                                width: 0,
                              ),
                              maximum: 100,
                              maximumLabels: 3,
                              minimum: 80),
                          series: <ChartSeries>[
                            // Initialize line series
                            SplineAreaSeries<oxygen_lvl, String>(
                              dataSource: Oxy_list,
                              xValueMapper: (oxygen_lvl data, _) =>
                                  DateFormat('EE').format(
                                data.Date_time,
                              ),
                              yValueMapper: (oxygen_lvl data, _) =>
                                  data.Oxy_lvl,
                              color: Color(0xffb2b7fb),
                            ),
                          ],
                        ),
                ),
                SizedBox(
                  height: 85 * 0.00135869565 * widget._height,
                  width: 85 * 0.00277777778 * widget._width,
                  child: SfCircularChart(
                    annotations: <CircularChartAnnotation>[
                      CircularChartAnnotation(
                        widget: PhysicalModel(
                          shape: BoxShape.circle,
                          elevation: 10,
                          shadowColor: Colors.black,
                          color: Colors.white,
                          child: Container(),
                        ),
                      ),
                      CircularChartAnnotation(
                        widget: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Oxy_list.isEmpty
                                  ? "NA"
                                  : Oxy_list.last.Oxy_lvl.toString(),
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 30 * (0.035 / 15) * widget._width,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff5662f6),
                              ),
                            ),
                            Text(
                              '%SpO2',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 13 * (0.035 / 15) * widget._width,
                                fontStyle: FontStyle.normal,
                                color: Color(0xFF757575),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    series: <CircularSeries>[
                      DoughnutSeries<oxygen_lvl, String>(
                        dataSource: Oxy_list.isEmpty
                            ? [
                                // oxygen_lvl(100.0,DateTime.now(),color:  Color(
                                //     0xfff9fafb)),
                              ]
                            : [
                                Oxy_list.last,
                                oxygen_lvl(
                                  color: Color(0xfff9fafb),
                                  Date_time: Date_Time,
                                  Oxy_lvl: 100.0 - Oxy_list.last.Oxy_lvl,
                                ),
                              ],
                        xValueMapper: (oxygen_lvl data, _) =>
                            DateFormat('EE').format(
                          data.Date_time,
                        ),
                        yValueMapper: (oxygen_lvl data, _) => data.Oxy_lvl,
                        pointColorMapper: (oxygen_lvl data, _) => data.color,
                        // Radius of doughnut
                        radius: '130%',
                        innerRadius: '115%',
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10 * 0.00135869565 * widget._height,
            ),
          ],
        ));
  }

  Oxygen_ontap() {
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
          left: 0.015 * widget._width,
          right: 0.015 * widget._width,
          top: 0.0225 * widget._height,
        ),
        width: 0.915 * widget._width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(right: 0.035555 * widget._width),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isLangEnglish ? "Oxygen Level" : "ऑक्सीजन स्तर",
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
                    height: 5 * 0.00135 * widget._height,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        isLangEnglish
                            ? "Oxygen Level State: "
                            : "ऑक्सीजन स्तर राज्य: ",
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
                        Oxy_list.isEmpty
                            ? "NA"
                            : Oxy_list.last.Status.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 15 * (0.035 / 15) * widget._width,
                          fontStyle: FontStyle.normal,
                          color: Oxy_list.isEmpty
                              ? Colors.black
                              : Oxy_list.last.Status == "Normal"
                                  ? Color(0xff29c44d)
                                  : Color(0xffff0000),
                          // height: ,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10 * 0.00135 * widget._height,
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
                    width: 0.2577777 * widget._width,
                    padding: EdgeInsets.zero,
                    child: Oxy_list.isEmpty
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
                            ],
                          )
                        : ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount:
                                Oxy_list.length > 5 ? 5 : Oxy_list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Text(
                                    DateFormat('EE\nMMM dd').format(
                                      Oxy_list.elementAt(index).Date_time,
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
                                    width: 0.005 * widget._width,
                                  ),
                                  Container(
                                    height: 0.0325 * widget._height,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 0.3,
                                        color: Color(0xffb8b8ba),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 0.005 * widget._width,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        isLangEnglish
                                            ? "Oxygen Level"
                                            : "ऑक्सीजन स्तर",
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
                                        "${Oxy_list.isEmpty ? "NA" : Oxy_list.elementAt(index).Oxy_lvl}%SpO2",
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
                              height: 0.0202907608696 * widget._height,
                            ),
                          ),
                  ),

                  Container(
                    padding: EdgeInsets.only(
                      left: 5 * 0.00277777778 * widget._width,
                      top: 0,
                    ),
                    width: 0.70502419777777 * widget._width,
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
                                    "Oxygen ",
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
                                    Icons.gas_meter_outlined,
                                    color: Color(0xff42ccc3),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 0.6422222222 * widget._width,
                                height: 0.03594736842 * widget._height,
                                child: TextField(
                                  controller: _Oxygen_Controller,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    hintText: isLangEnglish
                                        ? "Oxygen Level"
                                        : "ऑक्सीजन स्तर",
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
                                    suffixText: "%SpO2",
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
                                    "Date & Time   ",
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
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    hintText: "Date & Time",
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
                                            ? "Oxygen Level"
                                            : "ऑक्सीजन स्तर",
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
                                      Row(
                                        children: [
                                          Text(
                                            "${Oxy_list.isEmpty ? "NA" : Oxy_list.last.Oxy_lvl}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 22 *
                                                  (0.035 / 15) *
                                                  widget._width,
                                              fontStyle: FontStyle.normal,
                                              color: Oxy_list.isEmpty
                                                  ? Colors.black
                                                  : Oxy_list.last.color,
                                              // height: ,
                                            ),
                                          ),
                                          Text(
                                            " %SpO2",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15 *
                                                  (0.035 / 15) *
                                                  widget._width,
                                              fontStyle: FontStyle.normal,
                                              color: Oxy_list.isEmpty
                                                  ? Colors.black
                                                  : Oxy_list.last.color,
                                              // height: ,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          isLangEnglish
                                              ? "Last\nUpdated"
                                              : "पिचला\nअपडेट",
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
                                          Oxy_list.isEmpty
                                              ? "NA"
                                              : date_time.check_today(
                                                      Oxy_list.last.Date_time,
                                                      DateTime.now())
                                                  ? "Today"
                                                  : DateFormat(
                                                      'hh:mm a\nMMM dd',
                                                    ).format(
                                                      Oxy_list.last.Date_time,
                                                    ),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            fontSize: Oxy_list.isEmpty
                                                ? 20 *
                                                    (0.035 / 15) *
                                                    widget._width
                                                : date_time.check_today(
                                                        Oxy_list.last.Date_time,
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
                                child: Oxy_list.isEmpty
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
                                            axisLine: AxisLine(
                                              width: 0,
                                            ),
                                            maximum: 100,
                                            maximumLabels: 3,
                                            minimum: 80),
                                        series: <ChartSeries>[
                                          // Initialize line series
                                          SplineAreaSeries<oxygen_lvl, String>(
                                            dataSource: Oxy_list,
                                            xValueMapper:
                                                (oxygen_lvl data, _) =>
                                                    DateFormat('EE').format(
                                              data.Date_time,
                                            ),
                                            yValueMapper:
                                                (oxygen_lvl data, _) =>
                                                    data.Oxy_lvl,
                                            color: Color(0xffb2b7fb),
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
              height: 10 * 0.00135869565 * widget._height,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (!is_newentry && Date_Time != null) {
                        double Oxy_lvl = 0.0;
                        try {
                          Oxy_lvl = double.tryParse(_Oxygen_Controller.text)!;
                        } catch (e) {
                          return;
                        }

                        // if (Oxy_lvl != null) {
                        //   Oxy_list.add(oxygen_lvl(Oxy_lvl, Date_Time));
                        // }

                        Provider.of<PatientHealthAndWellNessDetails>(context,
                                listen: false)
                            .addPatientOxygenLevel(
                          context,
                          oxygen_lvl(
                            Oxy_lvl: Oxy_lvl,
                            Date_time: Date_Time,
                          ),
                          Provider.of<PatientUserDetails>(context,
                                  listen: false)
                              .getIndividualObjectDetails(),
                        );

                        _Oxygen_Controller.clear();
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
                                ? "Save"
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
    Oxy_list =
        Provider.of<PatientHealthAndWellNessDetails>(context, listen: false)
            .getOxygenLevelList();

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
        child: is_initial ? Oxygen_inital() : Oxygen_ontap(),
        //   child: Body_temp_initial(),
      ),
    );
  }
}
