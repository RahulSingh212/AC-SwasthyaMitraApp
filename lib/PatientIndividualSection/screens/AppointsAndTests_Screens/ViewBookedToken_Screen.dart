// ignore_for_file: use_build_context_synchronously, unnecessary_this, unnecessary_new, prefer_const_constructors, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, unused_local_variable, avoid_print, unused_import, sized_box_for_whitespace, duplicate_import, must_be_immutable, deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../Helper/constants.dart';
import '../../models/token_info.dart';
import '../../providers/doctorCalendar_details.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientUser_details.dart';
import './DoctorContactInformation_Screen.dart';
import './PatientViewPrescriptionScreen.dart';

class ViewBookedTokenScreen extends StatefulWidget {
  static const routeName = '/patient-view-booked-token-detail-screen';

  int pageIndex;
  BookedTokenSlotInformation tokenInfo;

  ViewBookedTokenScreen(this.pageIndex, this.tokenInfo);

  @override
  State<ViewBookedTokenScreen> createState() => _ViewBookedTokenScreenState();
}

class _ViewBookedTokenScreenState extends State<ViewBookedTokenScreen> {
  bool isLangEnglish = true;

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;
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
      body: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xff42CCC3),
            ),
            padding: EdgeInsets.only(top: screenHeight * 0.0175),
            child: Column(
              children: <Widget>[
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
                                  child: widget.tokenInfo.doctorImageUrl == ""
                                      ? Image.asset(
                                          "assets/images/surgeon.png",
                                        )
                                      : Image.network(
                                          widget.tokenInfo.doctorImageUrl,
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
                                  widget.tokenInfo.doctorFullName
                                          .toLowerCase()
                                          .startsWith("dr")
                                      ? widget.tokenInfo.doctorFullName
                                      : "Dr. ${widget.tokenInfo.doctorFullName}",
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
                                          "${widget.tokenInfo.doctorSpeciality}",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 0.011508 * _height,
                              ),
                              widget.tokenInfo.doctorTotalRatings == 0.0
                                  ? SizedBox(
                                      height: 0,
                                    )
                                  : DefaultTextStyle(
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        "${widget.tokenInfo.doctorTotalRatings.toString()} ${isLangEnglish ? "Ratings" : "रेटिंग्स"}",
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
          SizedBox(
            height: screenHeight * 0.0175,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              child: Text(
                widget.tokenInfo.isClinicAppointmentType
                    ? isLangEnglish
                        ? "Clinic Appointment"
                        : "क्लिनिक नियुक्ति"
                    : isLangEnglish
                        ? "Video Consultation"
                        : "वीडियो परामर्श",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.065,
                  color: Color.fromRGBO(114, 114, 114, 1),
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.035,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              child: Text(
                isLangEnglish ? "Date of Consultation" : "परामर्श की तिथि",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.06,
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              child: Text(
                "${DateFormat.yMMMMd().format(widget.tokenInfo.bookedTokenDate).toString()}",
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: Color.fromRGBO(114, 114, 114, 1),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.035,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              child: Text(
                isLangEnglish ? "Booked Time: " : "बुक किया गया समय: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.06,
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              child: Text(
                "${widget.tokenInfo.bookedTokenTime.format(context)}",
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: Color.fromRGBO(114, 114, 114, 1),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Align(
            child: Container(
              alignment: Alignment.centerLeft,
              width: screenWidth * 0.9,
              margin: EdgeInsets.only(
                bottom: screenHeight * 0.0075,
              ),
              child: Text(
                isLangEnglish ? "Bill Details: " : "बिल विवरण: ",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      widget.tokenInfo.isClinicAppointmentType
                          ? isLangEnglish
                              ? "Appointment Fees"
                              : "नियुक्ति शुल्क"
                          : isLangEnglish
                              ? "Consultation Fees"
                              : "परामर्श शुल्क",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: '₹. ',
                            style: TextStyle(
                              fontSize: screenWidth * 0.065,
                            ),
                          ),
                          TextSpan(
                            text:
                                '${widget.tokenInfo.tokenFees..toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              child: Divider(
                thickness: 3,
                color: Color(0xffD4D4D4),
              ),
            ),
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      isLangEnglish ? "Total Payable" : "कुल देय",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.055,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: '₹. ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.065,
                            ),
                          ),
                          TextSpan(
                            text:
                                '${widget.tokenInfo.tokenFees..toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.055,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: screenHeight * 0.05,
          // ),
          // Align(
          //   child: Container(
          //     width: screenWidth * 0.75,
          //     // padding: EdgeInsets.symmetric(
          //     //   vertical: screenHeight * 0.015,
          //     //   horizontal: screenWidth * 0.01,
          //     // ),
          //     // decoration: BoxDecoration(
          //     //   color: Color(0xff42CCC3),
          //     //   borderRadius: BorderRadius.circular(50),
          //     // ),
          //     child: ElevatedButton.icon(
          //       onPressed: () {
          //         Navigator.of(context).push(
          //           MaterialPageRoute(
          //             builder: (context) => ViewPatientPrescription(
          //               2,
          //               widget.tokenInfo,
          //             ),
          //           ),
          //         );
          //       },
          //       icon: Icon(
          //         Icons.note_alt_sharp,
          //         size: screenWidth * 0.075,
          //       ),
          //       label: Text(
          //         "VIEW PRESCRIPTION",
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: screenWidth * 0.045,
          //         ),
          //       ),
          //       style: ElevatedButton.styleFrom(
          //         primary: Color.fromRGBO(66, 204, 195, 1),
          //         padding: EdgeInsets.symmetric(
          //           vertical: screenHeight * 0.0125,
          //           horizontal: screenWidth * 0.075,
          //         ),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(75),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          // Align(
          //   alignment: Alignment.center,
          //   child: Container(
          //     alignment: Alignment.center,
          //     width: screenWidth * 0.9,
          //     child: Text.rich(
          //       TextSpan(
          //         children: <TextSpan>[
          //           TextSpan(
          //             text: isLangEnglish ? 'Text and calling features will be available on:\n' : "टेक्स्ट और कॉलिंग सुविधाएं उपलब्ध होंगी होंगि:\n",
          //             style: TextStyle(
          //               fontSize: 12.5,
          //               color: Color.fromRGBO(66, 204, 195, 1),
          //             ),
          //           ),
          //           TextSpan(
          //             text: '${DateFormat.yMMMEd().format(widget.tokenInfo.bookedTokenDate).toString()}, ',
          //             style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: 15,
          //             ),
          //           ),
          //           TextSpan(
          //             text: isLangEnglish ? 'from ' : 'से ',
          //             style: TextStyle(
          //               fontSize: 12.5,
          //             ),
          //           ),
          //           TextSpan(
          //             text: '${widget.tokenInfo.bookedTokenTime.format(context)}\n',
          //             style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: 15,
          //             ),
          //           ),
          //           TextSpan(
          //             text: isLangEnglish ? 'Duration: ' : 'अवधि: ',
          //             style: TextStyle(
          //               fontSize: 12.5,
          //             ),
          //           ),
          //           TextSpan(
          //             text: '45 minutes.',
          //             style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: 15,
          //             ),
          //           ),
          //           // TextSpan(
          //           //   text: 'to ',
          //           //   style: TextStyle(
          //           //     fontSize: 12.5,
          //           //   ),
          //           // ),
          //           // TextSpan(
          //           //   text: '${}.',
          //           //   style: TextStyle(
          //           //     fontWeight: FontWeight.bold,
          //           //     fontSize: 15,
          //           //   ),
          //           // ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: screenHeight * 0.0125,
          // ),
          // checkContactDoctorEnability() ?
          checkTokenContactDoctorToday(
            widget.tokenInfo.bookedTokenDate,
            widget.tokenInfo.bookedTokenTime,
          )
              ? Align(
                  child: Container(
                    width: screenWidth * 0.75,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ContactDoctorInformationScreen(
                              2,
                              widget.tokenInfo,
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.contact_page,
                        size: screenWidth * 0.075,
                      ),
                      label: Text(
                        isLangEnglish
                            ? "CONTACT DOCTOR"
                            : "डॉक्टर से संपर्क करें",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(66, 204, 195, 1),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.0125,
                          horizontal: screenWidth * 0.075,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(75),
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  height: 1,
                ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.75,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PatientViewPrescriptionScreen(
                        2,
                        Provider.of<PatientUserDetails>(context, listen: false)
                                .mp['patient_personalUniqueIdentificationId'] ??
                            "",
                        widget.tokenInfo,
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.contact_page,
                  size: screenWidth * 0.075,
                ),
                label: Text(
                  isLangEnglish ? "VIEW PRESCRIPTION" : "प्रिस्क्रिप्शन देखें",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.045,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(66, 204, 195, 1),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.0125,
                    horizontal: screenWidth * 0.075,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(75),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool checkTokenContactDoctorToday(
    DateTime bookedTokenDate,
    TimeOfDay bookedTokenTime,
  ) {
    DateTime today = DateTime.now();

    if (bookedTokenDate.add(Duration(days: 1)).isBefore(today) == false) {
      if (bookedTokenDate.day == today.day &&
          bookedTokenDate.month == today.month &&
          bookedTokenDate.year == today.year) {
        if (checkContactDoctorEnability()) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool checkContactDoctorEnability() {
    if (widget.tokenInfo.bookedTokenDate.day == DateTime.now().day &&
        widget.tokenInfo.bookedTokenDate.month == DateTime.now().month &&
        widget.tokenInfo.bookedTokenDate.year == DateTime.now().year) {
      int currTime = DateTime.now().hour * 60 + DateTime.now().minute;
      int regTime = widget.tokenInfo.bookedTokenTime.hour * 60 +
          widget.tokenInfo.bookedTokenTime.minute;

      if (currTime >= regTime - 15 && currTime <= regTime + 45) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
