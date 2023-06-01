// ignore_for_file: prefer_final_fields, prefer_const_constructors, use_key_in_widget_constructors, unnecessary_string_interpolations, unused_local_variable, avoid_unnecessary_containers, unused_import, duplicate_import, unused_element, must_be_immutable, must_call_super

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:auth/auth.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';
import 'package:weekday_selector/weekday_selector.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../Helper/constants.dart';
import '../../models/doctor_Info.dart';
import '../../models/slot_info.dart';

import '../../providers/patientAuth_details.dart';
import '../../providers/patientUser_details.dart';
import '../../providers/doctorCalendar_details.dart';
import '../../providers/patientAvailableDoctor_details.dart';

import '../AppointsAndTests_Screens/AppointmentsNTests_Screen.dart';
import '../HealthNFitness_Screens/HealthAndFitness_screen.dart';
import '../Home_Screens/Home_Screen.dart';
import './FindDoctorScreen.dart';
import './PatientBookAppointment_Screen.dart';

class DoctorAvailableAppointmentsScreen extends StatefulWidget {
  static const routeName = '/patient-doctor-available-appointments-screen';

  int pageIndex;
  DoctorDetailsInformation doctorDetails;

  DoctorAvailableAppointmentsScreen(
    this.pageIndex,
    this.doctorDetails,
  );

  @override
  State<DoctorAvailableAppointmentsScreen> createState() =>
      _DoctorAvailableAppointmentsScreenState();
}

class _DoctorAvailableAppointmentsScreenState
    extends State<DoctorAvailableAppointmentsScreen> {
  bool isLangEnglish = true;

  @override
  void initState() {
    Provider.of<DoctorCalendarDetails>(context, listen: false)
        .fetchSelectedDoctorAvailableSlots(
      context,
      widget.doctorDetails,
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );

    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  Future<void> _refreshAvailableDoctorAppointments(BuildContext context) async {
    Provider.of<DoctorCalendarDetails>(context, listen: false)
        .fetchSelectedDoctorAvailableSlots(
      context,
      widget.doctorDetails,
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) - _padding.top;

    var doctorAvailableAppointmentDetails =
        Provider.of<DoctorCalendarDetails>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xff42CCC3),
              ),
              padding: EdgeInsets.only(top: screenHeight * 0.035),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.01125,
                  ),
                  Container(
                    width: screenWidth,
                    child: Align(
                      child: Container(
                        width: screenWidth * 0.925,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Container(
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 0.08055 * _width / 2,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: AppColors.AppmainColor,
                                  ),
                                ),
                              ),
                            ),
                            // Container(
                            //   child: Icon(
                            //     Icons.library_add_outlined,
                            //     color: Colors.white,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    child: Container(
                      width: screenWidth * 0.925,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: screenWidth * 0.275,
                            width: screenWidth * 0.275,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.011111 * _width,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(1000),
                            ),
                            child: CircleAvatar(
                              radius: screenWidth * 0.6,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  screenWidth * 0.2,
                                ),
                                child: ClipOval(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: widget.doctorDetails
                                                .doctor_ProfilePicUrl ==
                                            ""
                                        ? Image.asset(
                                            "assets/images/uProfile.png",
                                          )
                                        : Image.network(
                                            widget.doctorDetails
                                                .doctor_ProfilePicUrl,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                DefaultTextStyle(
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  child: Text(
                                    widget.doctorDetails.doctor_FullName
                                            .toLowerCase()
                                            .startsWith("dr")
                                        ? widget.doctorDetails.doctor_FullName
                                        : "Dr. ${widget.doctorDetails.doctor_FullName}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.05,
                                      color: Colors.white,
                                    ),
                                    softWrap: false,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 0.01534 * _height,
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(
                                    left: 0.013888 * _width,
                                    top: 0.006393 * _height,
                                    bottom: 0.006393 * _height,
                                    right: 0.013888 * _width,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Container(
                                        width: screenWidth * 0.5,
                                        child: DefaultTextStyle(
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.AppmainColor,
                                          ),
                                          child: Text(
                                            "${widget.doctorDetails.doctor_Speciality}",
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 0.011508 * _height,
                                ),
                              widget.doctorDetails.doctor_ExperienceRating ==
                                      0.0
                                  ? SizedBox(
                                      height: 0,
                                    )
                                  : DefaultTextStyle(
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        "${widget.doctorDetails.doctor_ExperienceRating.toString()} ${isLangEnglish ? "Ratings" : "रेटिंग्स"}",
                                      ),
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                ],
              ),
            ),
            doctorAvailableAppointmentDetails.items.isNotEmpty
                ? Container(
                    width: screenWidth * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.0125,
                          ),
                          child: Text(
                            isLangEnglish
                                ? "Available Appointments:"
                                : "उपलब्ध नियुक्तियां:",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: screenWidth * 0.055,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.0125,
                          ),
                          child: Text(
                            "${doctorAvailableAppointmentDetails.items.length}",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: screenWidth * 0.055,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 0,
                  ),
            Container(
              child: doctorAvailableAppointmentDetails.items.isEmpty
                  ? RefreshIndicator(
                      onRefresh: () {
                        return _refreshAvailableDoctorAppointments(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.5,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.0125,
                          vertical: screenHeight * 0.005,
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.005,
                        ),
                        child: Text(
                          isLangEnglish
                              ? "No appointment available at the moment. \n\nTry again some other time..."
                              : "फिलहाल कोई अपॉइंटमेंट उपलब्ध नहीं है। \n\nफिर कोशिश करें...",
                          style: TextStyle(
                            fontSize: screenWidth * 0.065,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(66, 204, 195, 1),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Container(
                      // color: Colors.green,
                      height: screenHeight * 0.65,
                      width: screenWidth * 0.95,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.025,
                        ),
                        itemCount:
                            doctorAvailableAppointmentDetails.items.length,
                        itemBuilder: (ctx, index) {
                          if (doctorAvailableAppointmentDetails
                                  .items[index].isRepeat ||
                              !DateTime.utc(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                              ).isAfter(doctorAvailableAppointmentDetails
                                  .items[index].expiredDate)) {
                            return doctorAppointmentDetailInfoWidget(
                              context,
                              doctorAvailableAppointmentDetails.items[index],
                            );
                          } else {
                            return Null as Widget;
                          }
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget doctorAppointmentDetailInfoWidget(
  //   BuildContext context,
  //   DoctorSlotInformation appointmentInfo,
  // ) {
  //   var screenHeight = MediaQuery.of(context).size.height;
  //   var screenWidth = MediaQuery.of(context).size.width;
  //   var topInsets = MediaQuery.of(context).viewInsets.top;
  //   var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
  //   var useableHeight = screenHeight - topInsets - bottomInsets;

  //   return InkWell(
  //     onTap: () {},
  //     child: Card(
  //       elevation: 5,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //         // side: BorderSide(
  //         //   width: 5,
  //         //   color: Colors.green,
  //         // ),
  //       ),
  //       child: Align(
  //         child: Container(
  //           color: Colors.blue,
  //           height: screenHeight * 0.5,
  //           width: screenWidth * 0.8,
  //           child: Text(appointmentInfo.maximumNumberOfSlots.toString()),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget CalendarAppointmentDetailsWidgets(
  Widget doctorAppointmentDetailInfoWidget(
    BuildContext context,
    DoctorSlotInformation slotInfoDetails,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var avlScreenHeight = screenHeight - topInsets - bottomInsets;

    return InkWell(
      onTap: () {},
      // splashColor: Theme.of(context).primaryColorDark,

      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            width: 1.5,
            color: Color.fromRGBO(66, 204, 195, 1),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5),
            color: Colors.white70,
          ),
          height: slotInfoDetails.isRepeat
              ? screenHeight * 0.4
              : screenHeight * 0.35,
          width: screenWidth * 0.8,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.0125,
            vertical: screenWidth * 0.025,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.005,
                  horizontal: screenWidth * 0.005,
                ),
                child: Text(
                  slotInfoDetails.isRepeat
                      ? isLangEnglish
                          ? "Weekly Repeated"
                          : "साप्ताहिक दोहराव"
                      : isLangEnglish
                          ? "Valid only for a day"
                          : "केवल एक दिन के लिए मान्य",
                  style: TextStyle(
                    fontWeight: ui.FontWeight.bold,
                    fontSize: screenWidth * 0.055,
                    overflow: TextOverflow.ellipsis,
                    color: Color.fromRGBO(66, 204, 195, 1),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.0125,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.005,
                  horizontal: screenWidth * 0.025,
                ),
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: isLangEnglish
                            ? '▶ Appointment Fees: '
                            : '▶ नियुक्ति शुल्क: ',
                        style: TextStyle(
                          // fontWeight: ui.FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TextSpan(
                        text:
                            '${slotInfoDetails.appointmentFeesPerPatient.toString()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: screenHeight * 0.0125,
              // ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.005,
                  horizontal: screenWidth * 0.025,
                ),
                child: Text(
                  (slotInfoDetails.isClinic && slotInfoDetails.isVideo)
                      ? isLangEnglish
                          ? "▶ Clinic Appointment Available\n▶ Video Consultation Available"
                          : "▶ क्लिनिक अपॉइंटमेंट उपलब्ध\n▶ वीडियो परामर्श उपलब्ध"
                      : slotInfoDetails.isClinic
                          ? isLangEnglish
                              ? "▶ Only \"Clinic Appointment\" Available"
                              : "▶ केवल \"क्लिनिक अपॉइंटमेंट\" उपलब्ध है"
                          : isLangEnglish
                              ? "▶ Only \"Video Consultation\" Available"
                              : "▶ केवल \"वीडियो परामर्श\" उपलब्ध है",
                  style: TextStyle(
                    // fontWeight: ui.FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                    overflow: TextOverflow.ellipsis,
                    // color: Color.fromRGBO(66, 204, 195, 1),
                  ),
                  textAlign: ui.TextAlign.left,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.005,
                  horizontal: screenWidth * 0.025,
                ),
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: isLangEnglish
                            ? '▶ Available from: \n     '
                            : '▶ से उपलब्ध: \n     ',
                        style: TextStyle(
                          // fontWeight: ui.FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                          overflow: TextOverflow.ellipsis,
                          // color: Color.fromRGBO(66, 204, 195, 1),
                        ),
                      ),
                      TextSpan(
                        text: '${slotInfoDetails.startTime.format(context)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                      TextSpan(
                        text: isLangEnglish ? '  to  ' : '  प्रति  ',
                        style: TextStyle(
                          // fontWeight: ui.FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                          overflow: TextOverflow.ellipsis,
                          // color: Color.fromRGBO(66, 204, 195, 1),
                        ),
                      ),
                      TextSpan(
                        text: '${slotInfoDetails.endTime.format(context)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.025,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.0025,
                  horizontal: screenWidth * 0.025,
                ),
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: isLangEnglish
                            ? '▶ Activation Date: '
                            : '▶ सक्रियण तिथि: ',
                        style: TextStyle(
                          // fontWeight: ui.FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                          overflow: TextOverflow.ellipsis,
                          // color: Color.fromRGBO(66, 204, 195, 1),
                        ),
                      ),
                      TextSpan(
                        text:
                            '${DateFormat.yMMMMd('en_US').format(slotInfoDetails.registeredDate)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.0025,
                  horizontal: screenWidth * 0.025,
                ),
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: isLangEnglish
                            ? '▶ Expiry Date:        '
                            : "▶ समाप्ति तिथि:        ",
                        style: TextStyle(
                          // fontWeight: ui.FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                          overflow: TextOverflow.ellipsis,
                          // color: Color.fromRGBO(66, 204, 195, 1),
                        ),
                      ),
                      TextSpan(
                        text: slotInfoDetails.isRepeat
                            ? isLangEnglish
                                ? "None..."
                                : "कोई भी नहीं..."
                            : '${DateFormat.yMMMMd('en_US').format(slotInfoDetails.expiredDate)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.025,
              ),
              slotInfoDetails.isRepeat
                  ? Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.005,
                        horizontal: screenWidth * 0.025,
                      ),
                      child: Text(
                        isLangEnglish
                            ? "▶ Available days of the week are:"
                            : "▶ सप्ताह के उपलब्ध दिन हैं:",
                        style: TextStyle(
                          // fontWeight: ui.FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                          overflow: TextOverflow.ellipsis,
                          // color: Color.fromRGBO(66, 204, 195, 1),
                        ),
                        textAlign: ui.TextAlign.left,
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              slotInfoDetails.isRepeat
                  ? weekDayShowerWidget(
                      context,
                      slotInfoDetails.repeatWeekDaysList,
                    )
                  : SizedBox(
                      height: 0,
                    ),
              SizedBox(
                height: slotInfoDetails.isRepeat
                    ? screenHeight * 0.065
                    : screenHeight * 0.1425,
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            PatientBookAppointmentBookingScreen(
                          2,
                          widget.doctorDetails,
                          slotInfoDetails,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: screenWidth * 0.65,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.0135,
                      horizontal: screenWidth * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff42CCC3),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        isLangEnglish ? "Select" : "चयन करें",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget weekDayShowerWidget(BuildContext context, List<bool> selectedDays) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    var weekDaySelected = selectedDays;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
      ),
      child: WeekdaySelector(
        color: Color.fromRGBO(120, 158, 156, 1),
        selectedColor: Color.fromRGBO(120, 158, 156, 1),
        elevation: 3,
        fillColor: Colors.white,
        selectedFillColor: Color.fromRGBO(220, 229, 228, 1),
        onChanged: (int day) {},
        values: weekDaySelected,
      ),
    );
  }

  void TimePicker(BuildContext context, TimeOfDay timechosen) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: timechosen,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(primaryColor: Color(0xff42CCC3)),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: false,
            ),
            child: Directionality(
              textDirection: ui.TextDirection.ltr,
              child: child!,
            ),
          ),
        );
      },
    );
    if (time != null) {
      setState(() {
        timechosen = time;
      });
    }
  }

  void _dateShowerInCalendar(BuildContext context, DateTime givenTime) {
    showDatePicker(
      context: context,
      firstDate: givenTime,
      initialDate: givenTime,
      lastDate: givenTime,
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        } else {}
      },
    );
  }

  Future<void> _checkForError(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

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
