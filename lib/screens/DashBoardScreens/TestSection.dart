// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, unused_import, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, unused_element, duplicate_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
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

import '../../models/testSlot_into.dart';
import '../../providers/SM_DashBoard_Details.dart';
import '../../providers/SM_User_Details.dart';

class TestSectionSwasthyaMitra extends StatefulWidget {
  static const routeName = 'swasthya-mitra-test-section-screen';

  @override
  State<TestSectionSwasthyaMitra> createState() =>
      _TestSectionSwasthyaMitraState();
}

class _TestSectionSwasthyaMitraState extends State<TestSectionSwasthyaMitra> {
  bool isLangEnglish = true;

  Map<String, String> imagePathMapping = {
    "Blood Tests": "assets/images/blood-test.png",
    "Complete Blood Count": "assets/images/complete-blood-count.png",
    "Liver Function Tests": "assets/images/liver-function-test.png",
    "Kidney Function Tests": "assets/images/kidney-function-test.png",
    "Lipid Profile": "assets/images/lipid-profile.png",
    "Blood Sugar Test": "assets/images/blood-sugar-test.png",
    "Urine Test": "assets/images/urine-test.png",
    "Cardiac Blood Text": "assets/images/cardiac-blood-test.png",
    "Thyroid Function Test": "assets/images/thyroid-function-test.png",
    "Blood Tests For Infertility":
        "assets/images/blood-test-for-infertility.png",
    "Semen Analysis Test": "assets/images/semen-analysis-test.png",
    "Blood Tests For Arthritis": "assets/images/blood-test-for-arthritis.png",
    "Dengu Serology": "assets/images/dengu-serology.png",
    "Chikungunya Test": "assets/images/chikungunya-test.png",
    "HIV Test": "assets/images/hiv-test.png",
    "Pregnancy Test": "assets/images/pregnancy-test.png",
    "Stool Microscopy Test": "assets/images/stool-microscopy.png",
    "ESR Test": "assets/images/esr-test.png",
  };

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

    Provider.of<SwasthyaMitraDashBoardDetails>(context, listen: false)
        .fetchPatientBookedTests(context);
  }

  Future<void> _refreshTheStatusOfBookedTokens(BuildContext context) async {
    Provider.of<SwasthyaMitraDashBoardDetails>(context, listen: false)
        .fetchPatientBookedTests(context);
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

    return Provider.of<SwasthyaMitraDashBoardDetails>(context, listen: false)
            .getPatientActiveTestAppointmentList
            .isEmpty
        ? RefreshIndicator(
            onRefresh: () {
              return _refreshTheStatusOfBookedTokens(context);
            },
            child: Align(
              child: Container(
                alignment: Alignment.center,
                height: screenHeight * 0.2,
                width: screenWidth * 0.8,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.005,
                ),
                child: Text(
                  isLangEnglish
                      ? "No upcoming tests available"
                      : "कोई आगामी जांच उपलब्ध नहीं है",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.075,
                    color: Color.fromRGBO(66, 204, 195, 1),
                  ),
                  textAlign: ui.TextAlign.center,
                ),
              ),
            ),
          )
        : Align(
            child: Container(
              width: screenWidth * 0.975,
              child: ListView.builder(
                physics: ScrollPhysics(),
                itemCount: Provider.of<SwasthyaMitraDashBoardDetails>(context,
                            listen: false)
                        .getPatientActiveTestAppointmentList
                        .length +
                    1,
                itemBuilder: (ctx, index) {
                  if (index <
                      Provider.of<SwasthyaMitraDashBoardDetails>(context)
                          .getPatientActiveTestAppointmentList
                          .length) {
                    return bookedTestRequestTokenWidget(
                      context,
                      Provider.of<SwasthyaMitraDashBoardDetails>(context)
                          .getPatientActiveTestAppointmentList[index],
                    );
                  } else {
                    return SizedBox(
                      height: screenHeight * 0.05,
                    );
                  }
                },
              ),
            ),
          );
  }

  Widget bookedTestRequestTokenWidget(
    BuildContext context,
    SwasthyaMitrTestSlotInformation tokenInfo,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    return Card(
      elevation: 0.25,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.025,
          vertical: screenWidth * 0.01125,
        ),
        margin: EdgeInsets.only(
          bottom: screenWidth * 0.025,
        ),
        height: screenHeight * 0.145,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "${tokenInfo.appointmentTime.format(context).toString()} ⌾",
                      style: TextStyle(
                        color: Color.fromRGBO(127, 128, 132, 1),
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "${WeekListEnglish[tokenInfo.appointmentDate.weekday - 1]}, ${tokenInfo.appointmentDate.day} ${YearListEnglish[tokenInfo.appointmentDate.month - 1]}, ${tokenInfo.appointmentDate.year}",
                      style: TextStyle(
                        color: Color.fromRGBO(127, 128, 132, 1),
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
            ), // time
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      width: screenWidth * 0.75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: screenHeight * 0.095,
                            margin: EdgeInsets.only(
                              left: 6.5,
                              right: 5.5,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(205, 205, 205, 1),
                                width: 1,
                              ),
                            ),
                          ), // line
                          Container(
                            height: screenHeight * 0.095,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "${tokenInfo.testType}",
                                    style: TextStyle(
                                      color: Color.fromRGBO(136, 136, 136, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.0475,
                                    ),
                                  ),
                                ), // test name
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 8.5,
                                  ),
                                  child: Text(
                                    "${tokenInfo.patientFullName}",
                                    style: TextStyle(
                                      color: Color.fromRGBO(136, 136, 136, 1),
                                      fontSize: screenWidth * 0.041125,
                                    ),
                                  ),
                                ), // patient name
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 8.5,
                                  ),
                                  child: Text(
                                    "${tokenInfo.isHomeAppointmentType ? tokenInfo.patientAddress : "Center Visit"}",
                                    style: TextStyle(
                                      color: Color.fromRGBO(136, 136, 136, 1),
                                      fontSize: screenWidth * 0.039,
                                    ),
                                  ),
                                ), // patient address
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    height: screenWidth * 0.125,
                    width: screenWidth * 0.1125,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: screenWidth,
                      child: CircleAvatar(
                        radius: screenWidth,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            screenWidth,
                          ),
                          child: ClipOval(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1000),
                              ),
                              child: Image.asset(
                                imagePathMapping[tokenInfo.testType]!,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // test icon
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
