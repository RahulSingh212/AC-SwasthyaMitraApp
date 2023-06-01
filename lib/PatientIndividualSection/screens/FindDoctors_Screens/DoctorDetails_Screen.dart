// ignore_for_file: prefer_final_fields, prefer_const_constructors, use_key_in_widget_constructors, unnecessary_string_interpolations, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_import, duplicate_import, must_be_immutable, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
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

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../Helper/constants.dart';
import '../../models/doctor_Info.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientUser_details.dart';
import '../AppointsAndTests_Screens/AppointmentsNTests_Screen.dart';
import '../HealthNFitness_Screens/HealthAndFitness_screen.dart';
import '../Home_Screens/Home_Screen.dart';
import './DoctorAvailableAppointments_Screen.dart';
import './FindDoctorScreen.dart';

class DoctorDetailsScreen extends StatefulWidget {
  static const routeName = '/patient-doctor-details-screen';

  int pageIndex;
  DoctorDetailsInformation doctorDetails;

  DoctorDetailsScreen(
    this.pageIndex,
    this.doctorDetails,
  );

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  bool isLangEnglish = true;
  bool isNavigationButtonClicked = false;
  // List qualification = [];

  var _pages = [];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

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
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) - _padding.top;

    // qualification.add(
    //     "${isLangEnglish ? "Edu Qualification:" : "शिक्षा योग्यता:"} ${widget.doctorDetails.doctor_EducationQualification}\n");
    // qualification.add(
    //     "${isLangEnglish ? "Medicine Type:" : "दवा का प्रकार:"} ${widget.doctorDetails.doctor_MedicineType}");
    // qualification.add(
    //     "${isLangEnglish ? "Speciality:" : "विशेषता:"} ${widget.doctorDetails.doctor_Speciality}");
    // // qualification.add(
    // //     "${isLangEnglish ? "Speciality:" : "विशेषता:"}");
    // qualification.add("");

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xff42CCC3),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: screenHeight * 0.015,
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
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Align(
                  child: Container(
                    width: screenWidth * 0.925,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: screenHeight * 0.1725,
                          width: screenWidth * 0.35,
                          decoration: BoxDecoration(
                            image: widget.doctorDetails.doctor_ProfilePicUrl ==
                                    ""
                                ? DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      "assets/images/surgeon.png",
                                    ),
                                  )
                                : DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      widget.doctorDetails.doctor_ProfilePicUrl,
                                    ),
                                  ),
                            borderRadius: BorderRadius.circular(15),
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
                                              .startsWith("dr") ||
                                          widget.doctorDetails.doctor_FullName
                                              .toLowerCase()
                                              .startsWith("डॉ")
                                      ? widget.doctorDetails.doctor_FullName
                                      : isLangEnglish
                                          ? "Dr. ${widget.doctorDetails.doctor_FullName}"
                                          : "डॉ. ${widget.doctorDetails.doctor_FullName}",
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
                                alignment: Alignment.center,
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
                  height: screenHeight * 0.015,
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.925,
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.doctorDetails.doctor_FullName
                              .toLowerCase()
                              .startsWith("dr")
                          ? widget.doctorDetails.doctor_FullName
                          : "Dr. ${widget.doctorDetails.doctor_FullName}",
                      style: TextStyle(
                        color: Color(0xff929292),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        decorationThickness: 0,
                        decorationStyle: TextDecorationStyle.solid,
                        textBaseline: TextBaseline.alphabetic,
                        letterSpacing: 1,
                        wordSpacing: 0,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    TextSpan(
                      text: isLangEnglish
                          ? ' is a trained medical practitioner for the past '
                          : ' एक प्रशिक्षित चिकित्सक पिचले ',
                      style: TextStyle(
                        color: Color(0xff929292),
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text:
                          "${widget.doctorDetails.doctor_YearsOfExperience} ${isLangEnglish ? "years" : "वर्षों"}",
                      style: TextStyle(
                        color: Color(0xff929292),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: isLangEnglish
                          ? ' with expertise in '
                          : ' से है जिन्हें ',
                      style: TextStyle(
                        color: Color(0xff929292),
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: '${widget.doctorDetails.doctor_Speciality}',
                      style: TextStyle(
                        color: Color(0xff929292),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    TextSpan(
                      text: isLangEnglish ? "." : ' क्परिपूर्णता पैरापत है।',
                      style: TextStyle(
                        color: Color(0xff929292),
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  widget.doctorDetails.doctor_NumberOfPatientsTreated == 0
                      ? Container(
                          alignment: Alignment.center,
                          width: screenWidth * 0.275,
                          height: screenWidth * 0.275,
                          padding: EdgeInsets.all(
                            screenWidth * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(235, 250, 249, 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Container(
                              alignment: Alignment.center,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  isLangEnglish
                                      ? "Joined\nRecently"
                                      : "हाल में\nशामिल",
                                  style: TextStyle(
                                    color: Color.fromRGBO(66, 204, 195, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.05,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: screenWidth * 0.275,
                          height: screenWidth * 0.275,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Container(
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: charBox(
                                  text:
                                      "${widget.doctorDetails.doctor_NumberOfPatientsTreated}",
                                  char: isLangEnglish ? "Paitents" : "रोगी",
                                ),
                              ),
                            ),
                          ),
                        ),
                  widget.doctorDetails.doctor_YearsOfExperience == 0
                      ? Container(
                          alignment: Alignment.center,
                          width: screenWidth * 0.275,
                          height: screenWidth * 0.275,
                          padding: EdgeInsets.all(
                            screenWidth * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(235, 250, 249, 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Container(
                              alignment: Alignment.center,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  isLangEnglish
                                      ? "Not\nMentioned"
                                      : "नहीं\nउल्लेखित",
                                  style: TextStyle(
                                    color: Color.fromRGBO(66, 204, 195, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.05,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: screenWidth * 0.275,
                          height: screenWidth * 0.275,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Container(
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: charBox(
                                  text:
                                      "${widget.doctorDetails.doctor_YearsOfExperience.toString()}+",
                                  char: isLangEnglish
                                      ? "Exp. Years"
                                      : "अनुभव वर्ष",
                                ),
                              ),
                            ),
                          ),
                        ),
                  widget.doctorDetails.doctor_ExperienceRating == 0
                      ? Container(
                          alignment: Alignment.center,
                          width: screenWidth * 0.275,
                          height: screenWidth * 0.275,
                          padding: EdgeInsets.all(
                            screenWidth * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(235, 250, 249, 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Container(
                              alignment: Alignment.center,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  isLangEnglish ? "Not\nRated" : "नहीं\nरेटेड",
                                  style: TextStyle(
                                    color: Color.fromRGBO(66, 204, 195, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.05,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: screenWidth * 0.275,
                          height: screenWidth * 0.275,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Container(
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: charBox(
                                  text:
                                      "${widget.doctorDetails.doctor_ExperienceRating.toString()}/5",
                                  char: isLangEnglish ? "Rating" : "रेटिंग",
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(
                left: screenWidth * 0.04,
              ),
              width: screenWidth * 0.9,
              child: Text(
                isLangEnglish ? "Qualifications: " : "योग्यता: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: minDimension * 0.05,
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Container(
                width: screenWidth * 0.95,
                padding: EdgeInsets.only(
                  left: screenWidth * 0.025,
                ),
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            "${isLangEnglish ? "Edu Qualification: " : "शिक्षा योग्यता: "}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      TextSpan(
                        text:
                            "${widget.doctorDetails.doctor_EducationQualification}",
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Container(
                width: screenWidth * 0.95,
                padding: EdgeInsets.only(
                  left: screenWidth * 0.025,
                ),
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            "${isLangEnglish ? "Medicine Type: " : "दवा का प्रकार: "}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      TextSpan(
                        text: "${widget.doctorDetails.doctor_MedicineType}",
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Container(
                width: screenWidth * 0.95,
                padding: EdgeInsets.only(
                  left: screenWidth * 0.025,
                ),
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "${isLangEnglish ? "Speciality: " : "विशेषता: "}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      TextSpan(
                        text: "${widget.doctorDetails.doctor_Speciality}\n",
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.1,
          ),
          Align(
            child: Container(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DoctorAvailableAppointmentsScreen(
                        2,
                        widget.doctorDetails,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: screenWidth * 0.8,
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
                      isLangEnglish
                          ? "BOOK APPOINTMENT"
                          : "निर्धारित तारीख बुक करना",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: Theme(
      //   data: Theme.of(context).copyWith(
      //     iconTheme: IconThemeData(color: Colors.white),
      //     backgroundColor: Color(0xff42ccc3),
      //   ),
      //   child: buildMyNavBar(context),
      //   // CurvedNavigationBar(
      //   //   onTap: _selectPage,
      //   //   backgroundColor: Colors.transparent,
      //   //   color: Theme.of(context).primaryColor,
      //   //   buttonBackgroundColor: Theme.of(context).primaryColor,
      //   //   index: 0,
      //   //   height: screenHeight * 0.070,
      //   //   animationCurve: Curves.easeInOut,
      //   //   animationDuration: Duration(milliseconds: 300),
      //   //   items: iconItemsInActive,
      //   // ),
      // ),
    );
  }

  final TextStyle style = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    wordSpacing: 0,
    fontStyle: FontStyle.normal,
    decorationThickness: 0,
    decoration: TextDecoration.none,
    letterSpacing: 1,
    textBaseline: TextBaseline.alphabetic,
    height: 1,
    decorationStyle: TextDecorationStyle.solid,
  );

  Container buildMyNavBar(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Container(
      height: screenHeight * 0.075,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22.5),
          topRight: Radius.circular(22.5),
          bottomRight: Radius.circular(22.5),
          bottomLeft: Radius.circular(22.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                isNavigationButtonClicked = true;
                _selectPage(0);
              });
            },
            icon: _selectedPageIndex == 0
                ? Icon(
                    Icons.home_rounded,
                    color: Color(0xff42ccc3),
                    size: 25,
                  )
                : Icon(
                    Icons.home_outlined,
                    color: Colors.grey,
                    size: 25,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                isNavigationButtonClicked = true;
                _selectPage(1);
              });
            },
            icon: _selectedPageIndex == 1
                ? Icon(
                    Icons.notes_rounded,
                    color: Color(0xff42ccc3),
                    size: 25,
                  )
                : Icon(
                    Icons.notes_outlined,
                    color: Colors.grey,
                    size: 25,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                isNavigationButtonClicked = true;
                _selectPage(2);
              });
            },
            icon: _selectedPageIndex == 2
                ? Icon(
                    Icons.search_rounded,
                    color: Color(0xff42ccc3),
                    size: 25,
                  )
                : Icon(
                    Icons.search_outlined,
                    color: Colors.grey,
                    size: 25,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                isNavigationButtonClicked = true;
                _selectPage(3);
              });
            },
            icon: _selectedPageIndex == 3
                ? Icon(
                    Icons.link_rounded,
                    color: Color(0xff42ccc3),
                    size: 25,
                  )
                : Icon(
                    Icons.link_outlined,
                    color: Colors.grey,
                    size: 25,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                isNavigationButtonClicked = true;
                _selectPage(4);
              });
            },
            icon: _selectedPageIndex == 4
                ? Icon(
                    Icons.heart_broken_rounded,
                    color: Color(0xff42ccc3),
                    size: 25,
                  )
                : Icon(
                    Icons.heart_broken_outlined,
                    color: Colors.grey,
                    size: 25,
                  ),
          ),
        ],
      ),
    );
  }
}

class charBox extends StatelessWidget {
  String char;
  String text;
  charBox({Key? key, required this.text, required this.char}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xffEBFAF9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color: AppColors.AppmainColor,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            char,
            style: TextStyle(
              color: Color(0xff929292),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
