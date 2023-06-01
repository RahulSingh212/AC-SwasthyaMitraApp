import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/steps_distance_info.dart';
import '../../providers/paientHealthAndWellNess_details.dart';
import '../../providers/patientUser_details.dart';
import 'Date_Time.dart';

class Steps_Distance extends StatefulWidget {
  Steps_Distance({
    Key? key,
    required double width,
    required double height,
  })  : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;

  @override
  State<Steps_Distance> createState() => _Steps_DistanceState();
}

// class steps_distance {
//   int? Steps;
//   double? Distance;
//   DateTime? Date_time;

//   steps_distance(this.Steps, this.Distance, this.Date_time);
// }

class _Steps_DistanceState extends State<Steps_Distance> {
  bool isLangEnglish = true;
  List<steps_distance> SD_list = [];

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
        .fetchPreviousStepsDistanceList(
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );
  }

  DateTime temp_date_time = DateTime.now();
  DateTime Date_Time = DateTime.now();

  bool is_newentry = true;
  bool is_initial = true;

  TextEditingController _Steps_Controller = TextEditingController();
  TextEditingController _Distance_Controller = TextEditingController();
  TextEditingController _DayDate_Controller = TextEditingController();

  Steps_Distance_inital() {
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
          Text(
            isLangEnglish ? "Steps & Distance Travelled" : "कदम और दूरी यात्रा",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    SD_list.isEmpty
                        ? "NA"
                        : (SD_list.last.Steps.toString().length >= 3
                            ? "${SD_list.last.Steps.toString().substring(0, 1)}.${SD_list.last.Steps.toString().substring(1, 2)} K"
                            : SD_list.last.Steps.toString()),
                    // SD_list.last.Steps.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 20 * (0.035 / 15) * widget._width,
                      fontStyle: FontStyle.normal,
                      color: Color(0xff42cdc3),
                      // height: ,
                    ),
                  ),
                  Text(
                    SD_list.isEmpty
                        ? "NA"
                        : date_time.check_today(
                            SD_list.last.Date_time,
                            DateTime.now(),
                          )
                            ? isLangEnglish
                                ? "Today"
                                : "आज"
                            : DateFormat('hh:mm a\nMMM dd').format(
                                SD_list.last.Date_time,
                              ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: SD_list.isEmpty
                          ? 15 * (0.035 / 15) * widget._width
                          : date_time.check_today(
                              SD_list.last.Date_time,
                              DateTime.now(),
                            )
                              ? 15 * (0.035 / 15) * widget._width
                              : 10 * (0.035 / 15) * widget._width,
                      fontStyle: FontStyle.normal,
                      color: Color(0xFF2C2C2C),
                      // height: ,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100 * 0.00135869565 * widget._height,
                width: 220 * 0.00277777778 * widget._width,
                child: SD_list.isEmpty
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
                          ColumnSeries<steps_distance, String>(
                            dataSource: SD_list,
                            xValueMapper: (steps_distance data, _) =>
                                DateFormat('EE').format(
                              data.Date_time,
                            ),
                            yValueMapper: (steps_distance data, _) =>
                                data.Steps,
                            borderRadius: BorderRadius.circular(3),
                            color: Color(0xff42cdc3),
                          ),
                        ],
                      ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    SD_list.isEmpty
                        ? "NA"
                        : (SD_list.last.Distance.toString().length >= 5
                            ? "${SD_list.last.Distance.toString().substring(0, 1)}.${SD_list.last.Distance.toString().substring(1, 2)} K Km"
                            : "${SD_list.last.Distance} Km"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 20 * (0.035 / 15) * widget._width,
                      fontStyle: FontStyle.normal,
                      color: Color(0xff5662f6),
                      // height: ,
                    ),
                  ),
                  Text(
                    SD_list.isEmpty
                        ? "NA"
                        : date_time.check_today(
                            SD_list.last.Date_time,
                            DateTime.now(),
                          )
                            ? isLangEnglish
                                ? "Today"
                                : "आज"
                            : DateFormat('hh:mm a\nMMM dd').format(
                                SD_list.last.Date_time,
                              ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: SD_list.isEmpty
                          ? 15 * (0.035 / 15) * widget._width
                          : date_time.check_today(
                              SD_list.last.Date_time,
                              DateTime.now(),
                            )
                              ? 15 * (0.035 / 15) * widget._width
                              : 10 * (0.035 / 15) * widget._width,
                      fontStyle: FontStyle.normal,
                      color: Color(0xFF2C2C2C),
                      // height: ,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100 * 0.00135869565 * widget._height,
                width: 220 * 0.00277777778 * widget._width,
                child: SD_list.isEmpty
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
                          ColumnSeries<steps_distance, String>(
                            dataSource: SD_list,
                            xValueMapper: (steps_distance data, _) =>
                                DateFormat('EE').format(
                              data.Date_time,
                            ),
                            yValueMapper: (steps_distance data, _) =>
                                data.Distance,
                            borderRadius: BorderRadius.circular(3),
                            color: Color(0xff5662f6),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Steps_Distance_ontap() {
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
                    isLangEnglish
                        ? "Steps & Distance Travelled"
                        : "कदम और दूरी यात्रा",
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
                    height: 0.0155869565 * widget._height,
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
                      1 * 0.00277777778 * widget._height,
                      12 * 0.00277777778 * widget._width,
                      1 * 0.00277777778 * widget._height,
                    ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: false,
                      children: [
                        // Details For Steps_Distance

                        Container(
                          height: 0.251739 * widget._height,
                          width: 0.5077777 * widget._width,
                          padding: EdgeInsets.only(
                              top: 5 * 0.00135869565 * widget._height),
                          child: SD_list.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      Text(
                                        isLangEnglish
                                            ? "No Record\nAvailable"
                                            : "रिकॉर्ड \nउपलब्ध नहीं",
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
                                      SD_list.length > 5 ? 5 : SD_list.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Row(
                                      children: [
                                        Text(
                                          DateFormat('EE\nMMM dd').format(
                                            SD_list.elementAt(index).Date_time,
                                          ),
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
                                              isLangEnglish ? "Steps" : "कदम",
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
                                              SD_list.isEmpty
                                                  ? "NA"
                                                  : SD_list.elementAt(index)
                                                      .Steps
                                                      .toString(),
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
                                          width: 0.0275 * widget._width,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              isLangEnglish
                                                  ? "Distance"
                                                  : "दूरी",
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
                                              "${SD_list.isEmpty ? "NA" : SD_list.elementAt(index).Distance} Km",
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
                                          width: 0.0275 * widget._width,
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
                            left: 5 * 0.00277777778 * widget._width,
                            top: 0,
                          ),
                          child: !is_newentry
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      isLangEnglish
                                          ? "New Entry"
                                          : "नविन प्रवेश",
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
                                          isLangEnglish ? "Steps" : "कदम",
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
                                          Icons.directions_walk,
                                          color: Color(0xff42ccc3),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 0.6422222222 * widget._width,
                                      height: 0.0394736842 * widget._height,
                                      child: TextField(
                                        controller: _Steps_Controller,
                                        textAlignVertical:
                                            TextAlignVertical.bottom,
                                        decoration: InputDecoration(
                                          hintText:
                                              isLangEnglish ? "Steps" : "कदम",
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
                                            fontSize: 15 *
                                                (0.035 / 15) *
                                                widget._width,
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
                                          isLangEnglish ? "Distance" : "दूरी",
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
                                          Icons.directions_walk,
                                          color: Color(0xff5662f6),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 0.6422222222 * widget._width,
                                      height: 0.0394736842 * widget._height,
                                      child: TextField(
                                        controller: _Distance_Controller,
                                        textAlignVertical:
                                            TextAlignVertical.bottom,
                                        decoration: InputDecoration(
                                          hintText: isLangEnglish
                                              ? "Distance"
                                              : "दूरी",
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
                                            fontSize: 15 *
                                                (0.035 / 15) *
                                                widget._width,
                                            fontStyle: FontStyle.normal,
                                            color: Color(0xff6c757d),
                                          ),
                                          suffixText: "Km",
                                          suffixStyle: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15 *
                                                (0.035 / 15) *
                                                widget._width,
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
                                            fontSize: 15 *
                                                (0.035 / 15) *
                                                widget._width,
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
                                            fontSize: 15 *
                                                (0.035 / 15) *
                                                widget._width,
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
                                    ),
                                    SizedBox(
                                      height: 0.00135869565 * widget._height,
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
                                              width: 0.75 * 0.4 * widget._width,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    isLangEnglish
                                                        ? "Steps"
                                                        : "कदम",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15 *
                                                          (0.035 / 15) *
                                                          widget._width,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Color(0xff2c2c2c),
                                                      // height: ,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.directions_walk,
                                                    color: Color(0xff42ccc3),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Text(
                                              SD_list.isEmpty
                                                  ? "NA"
                                                  : SD_list.last.Steps
                                                      .toString(),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 25 *
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
                                          width: 0.0275 * widget._width,
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              width: 0.7777777 *
                                                  0.4 *
                                                  widget._width,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    isLangEnglish
                                                        ? "Distance"
                                                        : "दूरी",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15 *
                                                          (0.035 / 15) *
                                                          widget._width,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Color(0xff2c2c2c),
                                                      // height: ,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.directions_walk,
                                                    color: Color(0xff5662f6),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${SD_list.isEmpty ? "NA" : SD_list.last.Distance}",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 25 *
                                                        (0.035 / 15) *
                                                        widget._width,
                                                    fontStyle: FontStyle.normal,
                                                    color: Color(0xff2c2c2c),
                                                    // height: ,
                                                  ),
                                                ),
                                                Text(
                                                  " Km",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15 *
                                                        (0.035 / 15) *
                                                        widget._width,
                                                    fontStyle: FontStyle.normal,
                                                    color: SD_list.isEmpty
                                                        ? Colors.black
                                                        : Color(0xff5662f6),
                                                    // height: ,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          10 * 0.00135869565 * widget._height,
                                    ),
                                    SizedBox(
                                      height: 0.12231548913 * widget._height,
                                      width: 0.65 * widget._width,
                                      child: SD_list.isEmpty
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
                                                  ColumnSeries<steps_distance,
                                                      String>(
                                                    dataSource: SD_list,
                                                    xValueMapper:
                                                        (steps_distance data,
                                                                _) =>
                                                            DateFormat('EE')
                                                                .format(
                                                      data.Date_time,
                                                    ),
                                                    yValueMapper:
                                                        (steps_distance data,
                                                                _) =>
                                                            data.Steps,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    color: Color(0xff42cdc3),
                                                  ),
                                                ]),
                                    ),
                                    SizedBox(
                                      height: 0.12231548913 * widget._height,
                                      width: 0.65 * widget._width,
                                      child: SD_list.isEmpty
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
                                                ColumnSeries<steps_distance,
                                                    String>(
                                                  dataSource: SD_list,
                                                  xValueMapper: (steps_distance
                                                              data,
                                                          _) =>
                                                      DateFormat('EE').format(
                                                    data.Date_time,
                                                  ),
                                                  yValueMapper:
                                                      (steps_distance data,
                                                              _) =>
                                                          data.Distance,
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  color: Color(0xff5662f6),
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
                    height: 0.0135 * widget._height,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (!is_newentry) {
                              int Steps = 0;
                              double Distance = 0.0;

                              try {
                                Steps = int.tryParse(_Steps_Controller.text)!;
                                Distance =
                                    double.tryParse(_Distance_Controller.text)!;
                              } catch (e) {
                                return;
                              }

                              // if (Steps != null && Distance != null) {
                              //   // if (SD_list.length >= 5) {
                              //   //   SD_list.removeAt(0);
                              //   // }
                              //   // SD_list.add(steps_distance(
                              //   //   Steps,
                              //   //   Distance,
                              //   //   Date_Time,
                              //   // ));
                              // }
                              Provider.of<PatientHealthAndWellNessDetails>(
                                context,
                                listen: false,
                              ).addPatientDistanceTravelled(
                                context,
                                // steps_distance(
                                //   Steps,
                                //   Distance,
                                //   Date_Time,
                                // ),
                                steps_distance(
                                  Steps: Steps,
                                  Distance: Distance,
                                  Date_time: Date_Time,
                                ),
                                Provider.of<PatientUserDetails>(context,
                                        listen: false)
                                    .getIndividualObjectDetails(),
                              );

                              _Steps_Controller.clear();
                              _Distance_Controller.clear();
                              _DayDate_Controller.clear();
                            }

                            is_newentry = !is_newentry;
                          });
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xff42ccc3),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
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
                                  : "SAVE",
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
                    height: 0.0135869565 * widget._height,
                  ),
                ],
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    this.SD_list =
        Provider.of<PatientHealthAndWellNessDetails>(context, listen: false)
            .getStepsDistanceList();

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
        child: is_initial ? Steps_Distance_inital() : Steps_Distance_ontap(),
      ),
    );
  }
}
