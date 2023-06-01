// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, prefer_final_fields, unused_import, duplicate_import, unused_local_variable, unused_element

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
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

import '../../Helper/constants.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientAuth_details.dart';

import '../../myWidgets/LinearFlowWidget.dart';
import '../../providers/patientUser_details.dart';
import '../BookNewTests_Screens/BookYourTest_Screen.dart';
import './PreviosAppointmentSection.dart';
import './UpComingAppointmentSection.dart';

class AppointmentsAndTestsScreenPatient extends StatefulWidget {
  static const routeName = '/patient-appointments-and-tests-screen';

  @override
  State<AppointmentsAndTestsScreenPatient> createState() =>
      _AppointmentsAndTestsScreenPatientState();
}

class _AppointmentsAndTestsScreenPatientState
    extends State<AppointmentsAndTestsScreenPatient> {
  bool isFloatingBtnClicked = false;
  bool isUpComingBtnClicked = true;
  bool isPreviousBtnClicked = false;
  bool isLangEnglish = true;

  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  late AnimationController controller;

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

    return Scaffold(
      backgroundColor: Colors.white,
      // extendBody: true,
      // extendBodyBehindAppBar: true,
      body: ListView(
        // physics: ScrollPhysics(),
        // physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: screenWidth * 0.925,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.025,
                    ),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        isLangEnglish
                            ? "Appointments & Tests"
                            : "अपॉइंटमेंट और टेस्ट",
                        style: TextStyle(
                          fontSize: screenWidth * 0.0625,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.045,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isUpComingBtnClicked = true;
                            isPreviousBtnClicked = false;
                          });
                        },
                        child: Container(
                          child: Text(
                            isLangEnglish ? "Upcoming" : "आगामी",
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                  color: isUpComingBtnClicked
                                      ? Color.fromRGBO(66, 204, 195, 1)
                                      : Color.fromRGBO(184, 184, 184, 1),
                                  offset: Offset(0, -5),
                                )
                              ],
                              color: Colors.transparent,
                              decoration: isUpComingBtnClicked
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                              decorationColor: isUpComingBtnClicked
                                  ? Color.fromRGBO(66, 204, 195, 1)
                                  : Color.fromRGBO(184, 184, 184, 1),
                              decorationThickness: 2.5,
                              decorationStyle: TextDecorationStyle.solid,
                              fontSize: screenWidth * 0.055,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isPreviousBtnClicked = true;
                            isUpComingBtnClicked = false;
                          });
                        },
                        child: Container(
                          child: Text(
                            isLangEnglish ? "Previous" : "पिछला",
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                  color: isPreviousBtnClicked
                                      ? Color.fromRGBO(66, 204, 195, 1)
                                      : Color.fromRGBO(184, 184, 184, 1),
                                  offset: Offset(0, -5),
                                ),
                              ],
                              color: Colors.transparent,
                              decoration: isPreviousBtnClicked
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                              decorationColor: isPreviousBtnClicked
                                  ? Color.fromRGBO(66, 204, 195, 1)
                                  : Color.fromRGBO(184, 184, 184, 1),
                              decorationThickness: 2.5,
                              decorationStyle: TextDecorationStyle.solid,
                              fontSize: screenWidth * 0.055,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  child: Center(
                    child: Container(
                      width: screenWidth * 0.95,
                      child: Divider(
                        color: Colors.black,
                        thickness: 0.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.00035,
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          isUpComingBtnClicked
              ? Align(
                  child: Container(
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.72,
                    child: UpcomingAppointmentSection(),
                  ),
                )
              : Align(
                  child: Container(
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.72,
                    child: PreviosAppointmentSection(),
                  ),
                ),
        ],
      ),
      // floatingActionButton: LinearFlowWidget(),
    );
  }

  Widget _bottomButtons() {
    return FloatingActionButton(
      onPressed: () {
        showmenu();
      },
      backgroundColor: AppColors.AppmainColor,
      child: Icon(
        Icons.add,
        size: 30.0,
      ),
    );
  }

  showmenu() {
    Future.delayed(Duration.zero, () {
      MenuDialogBox();
    });
  }

  Future<void> MenuDialogBox() {
    return showDialog(
      context: _scaffoldKey.currentContext!,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 138,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff989898),
                    ),
                    child: Text(
                      isLangEnglish ? "Book New Test" : "नया टेस्ट बुक करें",
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookYourNewTestScreen(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.AppmainColor,
                    child: Icon(
                      Icons.text_snippet,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 138,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff989898),
                    ),
                    child: Text(
                      isLangEnglish ? "Find Doctors" : "डॉक्टरों का पता लगाएं",
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AppointmentsAndTestsScreenPatient(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.AppmainColor,
                    child: Icon(
                      Icons.person_search_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 138,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff989898),
                    ),
                    child: Text(
                      isLangEnglish ? "Scan Report" : "स्कैन रिपोर्ट",
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    // _takePicture();
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.AppmainColor,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.AppmainColor,
                child: Icon(
                  Icons.dangerous,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}
