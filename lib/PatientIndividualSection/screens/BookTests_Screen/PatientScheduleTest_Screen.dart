// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_unnecessary_containers, unused_import, duplicate_import, unused_local_variable, must_be_immutable, unused_element, unused_field

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:auth/auth.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swasthyamitra/PatientIndividualSection/providers/patientUser_details.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../Helper/constants.dart';
import '../../../providers/SM_User_Details.dart';
import '../../providers/patientTestUpdation_details.dart';
import '../Setting_Screens/TermsAndCondition_Screen.dart';
import '../Tabs_Screen.dart';

class PatientScheduleTestScreen extends StatefulWidget {
  static const routeName = '/patient-schedule-test-screen';

  String selectedTest;

  PatientScheduleTestScreen({required this.selectedTest});

  @override
  State<PatientScheduleTestScreen> createState() =>
      _PatientScheduleTestScreenState();
}

class _PatientScheduleTestScreenState extends State<PatientScheduleTestScreen> {
  String SecretKeyForReceivingAccount = "zjtYNy1zRnFt86IdbdO9I2Jp";
  String SecretKeyForTheApplication = "rzp_test_gXb3YhX0TlQsBs";
  bool isAppointmentCreated = false;
  bool isConfirmButtonClicked = false;
  bool checkBox = false;
  String orderid = "";
  late Razorpay _razorpay;
  String patientAlimentText = "";

  List<String> WeekListEnglish = [
    "Mon",
    "Tues",
    "Wed",
    "Thr",
    "Fri",
    "Sat",
    "Sun"
  ];
  List<String> YearListEnglish = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  //////////////////////////////////////////////////////
  bool isLangEnglish = true;
  bool isDateSelected = false;
  bool isTimeSelected = false;
  // bool isHomeVisitSelected = false;
  // bool isCenterVisitSelected = false;
  String selectedVisitType = "Home Visit";
  String patientAddress = "";
  DateTime currDateTime = DateTime.now();
  DateTime selectedDateTime = DateTime.now();
  DateTime focusedDateTime = DateTime.now();
  TimeOfDay testSlotTime = TimeOfDay.now();
  Map<String, bool> checkBoxMapping = {
    "Home Visit": true,
    "Center Visit": false,
  };
  TextEditingController patientName = TextEditingController();
  TextEditingController patientPhoneNumber = TextEditingController();
  TextEditingController patientSelectedTest = TextEditingController();
  TextEditingController patientSelectedDateSlot = TextEditingController();
  TextEditingController patientSelectedTimeSlot = TextEditingController();
  TextEditingController patientTestAddress = TextEditingController();
  CalendarFormat _format = CalendarFormat.month;

  @override
  void initState() {
    super.initState();

    isLangEnglish = isLangEnglish =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .isReadingLangEnglish;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    patientName.text = Provider.of<PatientUserDetails>(context, listen: false)
        .patientDetails
        .patient_FullName;
    patientPhoneNumber.text =
        Provider.of<PatientUserDetails>(context, listen: false)
            .patientDetails
            .patient_PhoneNumber;
    patientSelectedTest.text = widget.selectedTest;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    var _padding = MediaQuery.of(context).padding;
    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height) -
        _padding.top -
        _padding.bottom -
        kBottomNavigationBarHeight;

    return Scaffold(
      backgroundColor: Color(0xFFf2f3f4),
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          enableFeedback: false,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_circle_left,
            color: Color(0xff42ccc3),
            size: 35,
          ),
        ),
        title: Text(
          isLangEnglish ? "Schedule Test" : "जांच अनुसूची करें",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        physics: ScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: minDimension * 0.035,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.975,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.025,
              ),
              child: Text(
                'Name of Patient',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.045,
                ),
              ),
            ),
          ),
          Align(
            child: Container(
              width: screenWidth * 0.975,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.015,
              ),
              margin: EdgeInsets.only(
                bottom: screenHeight * 0.005,
              ),
              height: screenHeight * 0.075,
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                controller: patientName,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Patient Name',
                  hintText: 'Type Patient Name',
                ),
                // onChanged: (text) {
                //   print(text);
                //   // setState(() {
                //   //   name = text;
                //   // });
                // },
              ),
            ),
          ),
          Align(
            child: Container(
              width: screenWidth * 0.975,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.025,
              ),
              child: Text(
                'Patient Phone Number',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.045,
                ),
              ),
            ),
          ),
          Align(
            child: Container(
              width: screenWidth * 0.975,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.015,
              ),
              margin: EdgeInsets.only(
                bottom: screenHeight * 0.005,
              ),
              height: screenHeight * 0.085,
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                controller: patientPhoneNumber,
                decoration: InputDecoration(
                  enabled: false,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Patient Phone Name',
                  hintText: 'Type Patient Phone Name',
                ),
                onChanged: (text) {
                  print(text);
                  // setState(() {
                  //   name = text;
                  // });
                },
              ),
            ),
          ),
          Align(
            child: Container(
              width: screenWidth * 0.975,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.025,
              ),
              child: Text(
                'Selected Test',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.045,
                ),
              ),
            ),
          ),
          Align(
            child: Container(
              width: screenWidth * 0.975,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.015,
              ),
              margin: EdgeInsets.only(
                bottom: screenHeight * 0.005,
              ),
              height: screenHeight * 0.085,
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                controller: patientSelectedTest,
                decoration: InputDecoration(
                  enabled: false,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Patient Selected Test',
                  hintText: 'Type your test',
                ),
                onChanged: (text) {
                  print(text);
                  // setState(() {
                  //   name = text;
                  // });
                },
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          checkboxAvailableTestWidget(
            context,
            "Home Visit",
          ),
          checkBoxMapping['Home Visit']!
              ? SizedBox(
                  height: screenHeight * 0.001,
                )
              : SizedBox(
                  height: 0,
                ),
          checkBoxMapping['Home Visit']!
              ? Align(
                  child: Container(
                    width: screenWidth * 0.975,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.025,
                    ),
                    child: Text(
                      'Enter your test address',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
          checkBoxMapping['Home Visit']!
              ? Align(
                  child: Container(
                    width: screenWidth * 0.975,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.015,
                    ),
                    margin: EdgeInsets.only(
                      bottom: screenHeight * 0.005,
                    ),
                    height: screenHeight * 0.085,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.bottom,
                      controller: patientTestAddress,
                      decoration: InputDecoration(
                        // enabled: false,
                        // filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        labelText: 'Patient Address',
                        hintText: 'Enter your complete address',
                      ),
                      onChanged: (text) {
                        patientAddress = text;
                        // print(text);
                        // // setState(() {
                        // //   name = text;
                        // // });
                      },
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
          checkboxAvailableTestWidget(
            context,
            "Center Visit",
          ),
          TableCalenderWidget(
            context,
            currDateTime,
            selectedDateTime,
            focusedDateTime,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.975,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.025,
                    ),
                    child: Text(
                      'Selected Time for Test',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _selectTime(
                        testSlotTime,
                        patientSelectedTimeSlot,
                      );
                    },
                    child: Container(
                      child: Icon(
                        Icons.watch_later_rounded,
                        color: Color.fromRGBO(66, 204, 195, 1),
                        size: 35,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            child: Container(
              width: screenWidth * 0.975,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.015,
              ),
              margin: EdgeInsets.only(
                bottom: screenHeight * 0.005,
              ),
              height: screenHeight * 0.085,
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                controller: patientSelectedTimeSlot,
                decoration: InputDecoration(
                  enabled: false,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Patient Selected Test',
                  hintText: 'Type your test',
                ),
                onChanged: (text) {
                  print(text);
                  // setState(() {
                  //   name = text;
                  // });
                },
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.AppmainColor,
        child: Icon(
          Icons.check_circle_rounded,
          size: 28,
        ),
        onPressed: () {
          if (!isDateSelected && !isTimeSelected) {
            String titleText = isLangEnglish
                ? "Unselected Date & Time"
                : "अचयनित दिनांक और समय";
            String contextText = isLangEnglish
                ? "Please select your preferred Date and Time"
                : "कृपया अपनी पसंदीदा तिथि और समय चुनें";
            _checkForError(context, titleText, contextText);
          } else if (!isDateSelected) {
            String titleText =
                isLangEnglish ? "Unselected Date" : "अचयनित दिनांक";
            String contextText = isLangEnglish
                ? "Please select your preferred Date"
                : "कृपया अपनी पसंदीदा तिथि चुनें";
            _checkForError(context, titleText, contextText);
          } else if (!isTimeSelected) {
            String titleText =
                isLangEnglish ? "Unselected Time" : "अचयनित दिनांक और समय";
            String contextText = isLangEnglish
                ? "Please select your preferred Time"
                : "कृपया अपनी पसंदीदा समय चुनें";
            _checkForError(context, titleText, contextText);
          } else {
            _patientAilmentShowBox(context);
          }
        },
      ),
    );
  }

  Widget TableCalenderWidget(
    BuildContext context,
    DateTime currDateTime,
    DateTime selectedDayTime,
    DateTime focusedDayTime,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    var _padding = MediaQuery.of(context).padding;
    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height) -
        _padding.top -
        _padding.bottom -
        kBottomNavigationBarHeight;

    return Align(
      child: Container(
        child: TableCalendar(
          rowHeight: 50,
          headerStyle: HeaderStyle(
            // formatButtonVisible: false,
            titleCentered: true,
          ),
          daysOfWeekVisible: true,
          calendarFormat: _format,
          onFormatChanged: (CalendarFormat format) {
            setState(() {
              _format = format;
            });
          },
          availableGestures: AvailableGestures.all,
          focusedDay: focusedDateTime,
          firstDay: currDateTime,
          lastDay: currDateTime.add(
            Duration(days: 14),
          ),
          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            selectedDecoration: BoxDecoration(
              color: Color(0x8142CCC3),
              shape: BoxShape.circle,
            ),
          ),
          onDaySelected: (DateTime selectDate, DateTime focusDay) {
            setState(() {
              selectedDateTime = selectDate;
              focusedDateTime = focusDay;
              isDateSelected = true;
            });
          },
          selectedDayPredicate: (DateTime date) {
            return isSameDay(
              selectedDayTime,
              date,
            );
          },
        ),
        // TableCalendar<Book_Tests>(
        //   firstDay: currDateTime,
        //   lastDay: currDateTime.add(Duration(days: 14)),
        //   focusedDay: currDateTime,
        //   rowHeight: 50,
        //   selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        //   calendarFormat: CalendarFormat.month,
        //   eventLoader: _getEventsForDay,
        //   startingDayOfWeek: StartingDayOfWeek.sunday,
        //   availableCalendarFormats: {CalendarFormat.month: 'Month'},
        //   headerStyle: HeaderStyle(
        //       titleCentered: true,
        //       formatButtonVisible: false,
        //       titleTextStyle: TextStyle(
        //         fontFamily: "Roboto",
        //         fontSize: 25 * (0.035 / 15) * width,
        //         fontWeight: FontWeight.w500,
        //       )),
        //   daysOfWeekStyle: DaysOfWeekStyle(
        //     weekdayStyle: TextStyle(
        //       fontFamily: "Roboto",
        //       fontSize: 20 * (0.035 / 15) * width,
        //       fontWeight: FontWeight.w500,
        //     ),
        //     weekendStyle: TextStyle(
        //       fontFamily: "Roboto",
        //       fontSize: 20 * (0.035 / 15) * width,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        //   calendarStyle: CalendarStyle(
        //     outsideDaysVisible: false,
        //     markersMaxCount: 1,
        //     markersAnchor: -0.3,
        //     todayDecoration: BoxDecoration(
        //       color: Color(0x8142CCC3),
        //       shape: BoxShape.circle,
        //     ),
        //     markerDecoration: BoxDecoration(
        //       color: Color(0xff42ccc3),
        //       shape: BoxShape.circle,
        //     ),
        //     selectedDecoration: BoxDecoration(
        //       color: Color(0xFF42CCC3),
        //       shape: BoxShape.circle,
        //     ),
        //   ),
        //   onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        //     if (!isSameDay(_selectedDay, selectedDay)) {
        //       setState(() {
        //         _selectedDay = selectedDay;
        //         _focusedDay = focusedDay;
        //       });
        //       _selectedEvents.value = _getEventsForDay(selectedDay);
        //     }
        //   },
        // ),
      ),
    );
  }

  Future<void> _selectTime(
    TimeOfDay testTimeSlot,
    TextEditingController textController,
  ) async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null) {
      setState(() {
        testSlotTime = newTime;
        testTimeSlot = newTime;

        int hrs = (newTime.hour % 12);
        if (hrs == 0) {
          hrs = 12;
        }
        int mins = newTime.minute;
        String sig = (newTime.hour / 12).ceil() == 0 ? "AM" : "PM";

        String time =
            "${hrs < 10 ? "0" : ""}${hrs}:${mins < 10 ? "0" : ""}${mins} ${sig}";
        textController.text = time;
        isTimeSelected = true;
      });
    }
  }

  Widget checkboxAvailableTestWidget(
    BuildContext context,
    String headerText,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    return Container(
      child: Material(
        child: Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Color.fromRGBO(120, 158, 156, 1),
          ),
          child: Align(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: CheckboxListTile(
                title: Text(headerText),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Color.fromRGBO(120, 158, 156, 1),
                checkColor: Colors.white,
                // value: editCheckBoxMapping[uniqueText],
                value: checkBoxMapping[headerText],
                onChanged: (bool? value) {
                  // setState(() {
                  //   checkBoxMapping[headerText] = !checkBoxMapping[headerText]!;
                  // });
                  setState(() {
                    checkBoxMapping.forEach((key, value) {
                      // print("$key <-> $value");
                      checkBoxMapping[key] = false;
                    });
                    checkBoxMapping[headerText] = !checkBoxMapping[headerText]!;
                    selectedVisitType = headerText;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _patientAilmentShowBox(BuildContext context) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: max(screenHeight, screenWidth) * 0.475,
            width: min(screenHeight, screenWidth) * 0.85,
            padding: EdgeInsets.symmetric(
              horizontal: min(screenHeight, screenWidth) * 0.04,
              vertical: min(screenHeight, screenWidth) * 0.06,
            ),
            child: ListView(
              physics: ScrollPhysics(),
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.325,
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: isLangEnglish ? 'Date\n' : "दिनांक\n",
                                  style: TextStyle(
                                    fontSize: 17.5,
                                    color: Color.fromRGBO(137, 134, 137, 1),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${WeekListEnglish[selectedDateTime.weekday - 1]}, ${selectedDateTime.day} ${YearListEnglish[selectedDateTime.month - 1]}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.325,
                        alignment: Alignment.centerRight,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: isLangEnglish ? 'Time\n' : "समय\n",
                                  style: TextStyle(
                                    fontSize: 17.5,
                                    color: Color.fromRGBO(137, 134, 137, 1),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${testSlotTime.format(context).toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.0125,
                ),
                Container(
                  child: Text(
                    isLangEnglish
                        ? 'Write a brief description about your ailment:'
                        : "अपनी बीमारी के बारे में संक्षिप्त विवरण लिखें:",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: Color.fromRGBO(205, 205, 205, 1),
                    ),
                  ),
                  child: TextField(
                    onChanged: ((value) {
                      patientAlimentText = value;
                    }),
                    decoration: InputDecoration(
                      hintText: 'Enter your ailment...',
                      focusedBorder: InputBorder.none,
                    ),
                    autocorrect: true,
                    minLines: 4,
                    maxLines: 4,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.035,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(ctx);
                    _patientAppointmentConfirmationShowBox(context);
                  },
                  child: Container(
                    width: screenWidth * 0.65,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.025,
                      horizontal: screenWidth * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff42CCC3),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        isLangEnglish ? "Next" : "अगला",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _patientAppointmentConfirmationShowBox(
      BuildContext context) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return await showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: max(screenHeight, screenWidth) * 0.615,
            width: min(screenHeight, screenWidth) * 0.85,
            padding: EdgeInsets.symmetric(
              horizontal: min(screenHeight, screenWidth) * 0.04,
              vertical: min(screenHeight, screenWidth) * 0.06,
            ),
            child: ListView(
              physics: ScrollPhysics(),
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.325,
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: isLangEnglish ? 'Date\n' : "दिनांक\n",
                                  style: TextStyle(
                                    fontSize: 17.5,
                                    color: Color.fromRGBO(137, 134, 137, 1),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${WeekListEnglish[selectedDateTime.weekday - 1]}, ${selectedDateTime.day} ${YearListEnglish[selectedDateTime.month - 1]}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.325,
                        alignment: Alignment.centerRight,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: isLangEnglish ? 'Time\n' : "समय\n",
                                  style: TextStyle(
                                    fontSize: 17.5,
                                    color: Color.fromRGBO(137, 134, 137, 1),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${testSlotTime.format(context).toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.035,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 0.035 * screenWidth,
                      right: 0.035 * screenWidth,
                      top: 0.015 * screenHeight,
                      bottom: 0.015 * screenHeight,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(65),
                      color: Color(0xffD3F3F1),
                    ),
                    child: CircleAvatar(
                      radius: 52,
                      backgroundColor: AppColors.AppmainColor,
                      child: Icon(
                        Icons.check,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.035,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PatientTermsAndConditionsScreen(
                          3,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: screenWidth * 0.6,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: isLangEnglish
                                  ? "I've read and accept the "
                                  : "मैंने पढ़ा और स्वीकार करता हूं ",
                              style: TextStyle(
                                fontSize: 10,
                                color: Color.fromRGBO(137, 134, 137, 1),
                              ),
                            ),
                            TextSpan(
                              text: isLangEnglish
                                  ? 'terms and conditions.'
                                  : "नियम और शर्तें।",
                              style: TextStyle(
                                color: Color.fromRGBO(66, 204, 195, 1),
                                fontSize: 10,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      selectedVisitType,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.0015,
                ),
                Align(
                  child: Container(
                    width: screenWidth * 0.7,
                    child: Divider(
                      thickness: 2,
                      color: Color.fromRGBO(212, 212, 212, 1),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: screenHeight * 0.0015,
                // ),
                // Container(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: <Widget>[
                //       Container(
                //         child: Text(
                //           isLangEnglish ? "Total Payable" : "कुल देय",
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 18,
                //           ),
                //         ),
                //       ),
                //       Container(
                //         alignment: Alignment.centerLeft,
                //         child: Text.rich(
                //           TextSpan(
                //             children: <TextSpan>[
                //               TextSpan(
                //                 text: '₹ ',
                //                 style: TextStyle(
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 18,
                //                 ),
                //               ),
                //               TextSpan(
                //                 text:
                //                     '${widget.slotInfoDetails.appointmentFeesPerPatient.toStringAsFixed(2)}',
                //                 style: TextStyle(
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 18,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isConfirmButtonClicked = true;
                      Navigator.pop(ctx);
                      _creatingAppoitmentAfterSuccessfulPayment(context);

                      // isConfirmButtonClicked = true;
                      // print(isConfirmButtonClicked);

                      // Navigator.pop(ctx);

                      // if (widget.slotInfoDetails.appointmentFeesPerPatient
                      //         .floor() <
                      //     1) {
                      //   _creatingAppoitmentAfterSuccessfulPayment();
                      // } else {
                      //   createOrder(
                      //     context,
                      //     widget.doctorDetails,
                      //     widget.slotInfoDetails,
                      //     patientPhoneNumber,
                      //     choosenAppointmentDate,
                      //     choosenTimeOfDay!,
                      //   );
                      // }
                    });
                  },
                  child: Container(
                    width: screenWidth * 0.65,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.025,
                      horizontal: screenWidth * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff42CCC3),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: !isConfirmButtonClicked
                        ? Center(
                            child: Text(
                              isLangEnglish ? "CONFIRM" : "पुष्टि करें",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      setState(() {
        isConfirmButtonClicked = false;
      });
    });
  }

  Future<void> _creatingAppoitmentAfterSuccessfulPayment(
      BuildContext context) async {
    PatientAppointmentCreationProgress(context).then((value) {
      Provider.of<PatientTestAppointmentUpdationDetails>(context, listen: false)
          .savePatientTestSlot(
        context,
        widget.selectedTest,
        selectedVisitType,
        selectedDateTime,
        testSlotTime,
        patientAlimentText,
        patientAddress,
      );
    });
  }

  Future<void> PatientAppointmentCreationProgress(BuildContext context) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    Timer _timerOut = Timer(Duration(seconds: 4), () {
      PaynmentSuccessful(context);
    });
    return await showDialog(
      context: context,
      builder: (ctx) {
        Timer _timer = Timer(Duration(seconds: 3), () {
          Navigator.pop(ctx);
          // PaynmentSuccessful(context);
        });
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(25),
            height: screenHeight * 0.65,
            width: screenWidth * 0.8,
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: minDimension * 0.25,
                    width: minDimension * 0.25,
                    child: CircularProgressIndicator(),
                  ),
                ),
                SizedBox(
                  height: maxDimension * 0.05,
                ),
                Center(
                  child: Text(
                    isLangEnglish ? "In Progress..." : "प्रगति में...",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: minDimension * 0.065,
                    ),
                  ),
                ),
                SizedBox(
                  height: maxDimension * 0.065,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffD3F3F1),
                    ),
                    child: Text(
                      isLangEnglish
                          ? "Creating your appointment in progress..."
                          : "आपका अपॉइंटमेंट तैयार किया जा रहा है...",
                      textAlign: ui.TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffD3F3F1),
                    ),
                    child: Text(
                      isLangEnglish
                          ? "Please wait and don't press anything while your appointment gets created"
                          : "कृपया प्रतीक्षा करें और जब तक आपका अपॉइंटमेंट तैयार न हो जाए, तब तक कुछ भी न दबाएं.",
                      textAlign: ui.TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      _timerOut.cancel();
      PaynmentSuccessful(context);
    });
  }

  Future<void> PaynmentSuccessful(BuildContext context) async {
    var builderContext = context;

    Timer _timerOut = Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          TabsScreenPatient.routeName, (route) => false);
    });

    return await showDialog(
      context: context,
      builder: (ctx) {
        var _timer = Timer(Duration(seconds: 1), () {
          Navigator.pop(ctx);
          // Navigator.of(context).pushNamedAndRemoveUntil(
          //     TabsScreenPatient.routeName, (route) => false);
        });

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(25),
            height: 300,
            width: 150,
            child: Column(
              children: [
                Center(
                    child: Text(
                  isLangEnglish ? "PAYMENT SUCCESSFUL" : "भुगतान सफल",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                )),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(65),
                      color: Color(0xffD3F3F1),
                    ),
                    child: CircleAvatar(
                      radius: 52,
                      backgroundColor: AppColors.AppmainColor,
                      child: Icon(
                        Icons.check,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      // Navigator.pop(builderContext);
      _timerOut.cancel();
      Navigator.of(context).pushNamedAndRemoveUntil(
          TabsScreenPatient.routeName, (route) => false);
    });
  }

  Future<void> _checkForError(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check_circle_rounded,
              color: Color(0xff42ccc3),
            ),
            iconSize: 50,
            color: Colors.brown,
            onPressed: () {
              setState(() {
                if (popVal == false) {
                  Navigator.pop(ctx);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
